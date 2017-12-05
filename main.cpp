#include <stdio.h>
#include <iostream>
#include <sstream>
#include <fstream>

#include <cassert>
#include <cstdarg>
#include <cstdint>
#include <cstdlib>
#include <cstdio>
#include <string>
#include <cxxabi.h>

#include "config.h"

#include "src/binary-writer.h"
#include "src/common.h"
#include "src/error-handler.h"
#include "src/feature.h"
#include "src/filenames.h"
#include "src/ir.h"
#include "src/option-parser.h"
#include "src/resolve-names.h"
#include "src/stream.h"
#include "src/validator.h"
#include "src/wast-parser.h"

#include "src/cast.h"
#include <map>

using namespace wabt;

static const char* s_infile = "table.wast";
static std::string s_outfile;
static bool s_dump_module;
static int s_verbose;
static WriteBinaryOptions s_write_binary_options;
static bool s_validate = true;
static bool s_debug_parsing;
static Features s_features;

static std::unique_ptr<FileStream> s_log_stream;

struct ezFuncVal {
	ezFuncVal() {}
	ezFuncVal(std::string newName, std::string newRealName,std::vector<Type> newSignature): name(newName), realName(newRealName), signature(newSignature) {}
	std::string name;
	std::string realName;
	std::vector<Type> signature;
};

struct ezTableVal {
	ezTableVal() {}
	ezTableVal(std::string newName, std::string newValue): name(newName), value(newValue) {}
	std::string name;
	std::string value;
	uint64_t initial = 0;
    uint64_t max = 0;
};


struct ezImport
{
  enum importType {
    None,
	Function,
	Table
  };

  importType currentType;

  ezImport(std::string newName, std::string newRealName,std::vector<Type> newSignature) : function(newName,newRealName,newSignature),currentType(importType::Function) {}

  ezImport(std::string newName, std::string newValue) : table(newName,newValue), currentType(importType::Table) {
	  currentType = importType::Table;
  }

  union {
    ezTableVal table;
    ezFuncVal function;
  };

  ~ezImport(){
	  switch(currentType){
		  case importType::Function : {
			  function.~ezFuncVal();
			  break;
		  }
		  case importType::Table : {
			  table.~ezTableVal();
			  break;
		  }
	  }
  };

  ezImport(ezImport &&import){

  }

  importType getType() const{
	  return currentType;
  }
};

struct innerMap {
	std::map<std::string,ezImport> map;
};

std::map<std::string, innerMap> jsModule;

std::string printParams(std::vector<Type> signature){
	int param_counter = 1;
	std::stringstream ss;
	for(auto& type : signature){
		switch(type) {
			case Type::I32 : {
				ss << "i32_" << param_counter << ", ";
				break;
			}
			case Type::I64 : {
				ss << "i64_" << param_counter << ", ";
				break;
			}
			case Type::F32 : {
				ss << "f32_" << param_counter << ", ";
				break;
			}
			case Type::F64 : {
				ss << "f64_" << param_counter << ", ";
				break;
			}
		}
	}

	auto ret = ss.str();
	ret.pop_back();
	ret.pop_back();

	return ret;
}


int main(){
	std::cout << "Hello world" << "\r\n";
	std::unique_ptr<WastLexer> lexer = WastLexer::CreateFileLexer(s_infile);
	if (!lexer)
	    WABT_FATAL("unable to read file: %s\n", s_infile);

	ErrorHandlerFile error_handler(Location::Type::Text);
	std::unique_ptr<Module> module;
	WastParseOptions parse_wast_options(s_features);
	Result result =
		  ParseWatModule(lexer.get(), &module, &error_handler, &parse_wast_options);
	std::cout << "Imports count " << module->imports.size() << "\r\n";
	for(auto& import : module->imports){
		int     status;
		switch(import->kind()){
			case ExternalKind::Func :{
				char *realnamec = abi::__cxa_demangle(import->field_name.c_str(), 0, 0, &status);
				auto func_import =  dyn_cast<FuncImport>(import);
				auto param_types = func_import->func.decl.sig.param_types;
				int param_counter = 1;
				auto strRealName = import->field_name;
				if(realnamec != nullptr){
					strRealName = std::string(realnamec);
				}

				std::replace( strRealName.begin(), strRealName.end(), ' ', '_');
				std::replace( strRealName.begin(), strRealName.end(), '*', '_');
				std::replace( strRealName.begin(), strRealName.end(), '(', '_');
				std::replace( strRealName.begin(), strRealName.end(), ')', '_');

				auto iter = jsModule.find(func_import->func.name);
				if(iter == jsModule.end()){
					iter = jsModule.emplace(func_import->module_name,innerMap{}).first;
				}

				iter->second.map.emplace(func_import->func.name,import->field_name,strRealName,func_import->func.decl.sig.param_types);

				break;
			}
			case ExternalKind::Table : {
				printf("Table! %s %s\n",import->field_name.data(),import->module_name.data());
				auto table_import =  dyn_cast<TableImport>(import);
				printf("Table! %lu %lu %s\n",table_import->table.elem_limits.initial,table_import->table.elem_limits.max,table_import->table.name.data());
				break;
			}
		}
	}

	std::stringstream jsCode;
	jsCode << "var imports = {\n";
	for(auto const &iter : jsModule) {
	  jsCode << "\t" << iter.first << " : {\n";
	  auto vecSize = iter.second.map.size();
	  auto argCounter = 0;
	  for(auto const &function : iter.second.map) {
		  const auto &temp = jsCode.str();
		  jsCode.seekp(0);

		  if(function.second.getType() == ezImport::importType::Function){
			  jsCode << "function " << function.second.function.realName << "("+printParams(function.second.function.signature)+") {\n\n}\n\n";
			  jsCode << temp;

			  jsCode << "\t\t" << function.second.function.name << " : " << function.second.function.realName;
		  }

		  if(argCounter+1 != vecSize){
			  jsCode << ",\n";
		  }
		  else{
			  jsCode << "\n";
		  }
		  argCounter++;
	  }
	  jsCode << "\t}\n";
	}
	jsCode << "}";

	std::ofstream outFile("test.js");
	outFile << jsCode.rdbuf();
	outFile.close();

	return 0;
}

