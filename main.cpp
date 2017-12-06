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

static const char* s_infile = "wast/cpp.wast";
static std::string s_outfile;
static bool s_dump_module;
static int s_verbose;
static WriteBinaryOptions s_write_binary_options;
static bool s_validate = true;
static bool s_debug_parsing;
static Features s_features;

static std::unique_ptr<FileStream> s_log_stream;

struct ezFuncVal {
	std::string name;
	std::string realName;
	std::vector<Type> signature;
	std::vector<Type> returnValues;
};

struct ezTableVal {
	std::string name;
	uint64_t initial = 0;
    uint64_t max = 0;
};

struct ezMemoryVal {
	std::string name;
	uint64_t initial = 0;
    uint64_t max = 0;
};

struct ezElements
{
  std::string moduleName;
  std::vector<ezFuncVal> functions;
  std::vector<ezTableVal> tables;
  std::vector<ezMemoryVal> memory;
};


struct jsModule {
	std::vector<ezElements> imports;
	ezElements exports;
};

jsModule parsedModule;

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

	if(signature.size() > 0){
		ret.pop_back();
		ret.pop_back();
	}



	return ret;
}

std::string printReturnParams(std::vector<Type> returnValues){
	int param_counter = 1;
	std::stringstream ss;
	std::string varName;
	std::string varVal;
	for(auto& type : returnValues){
		switch(type) {
			case Type::I32 : {
				varName = "r_i32_"+std::to_string(param_counter);
				varVal = "0";
				break;
			}
			case Type::I64 : {
				varName = "r_i64_"+std::to_string(param_counter);
				varVal = "0";
				break;
			}
			case Type::F32 : {
				varName = "r_f32_"+std::to_string(param_counter);
				varVal = "0.0";
				break;
			}
			case Type::F64 : {
				varName = "r_f32_"+std::to_string(param_counter);
				varVal = "0.0";
				break;
			}
		}
	}

	if(!varName.empty()){
		ss << "\tvar " << varName << " = " << varVal << ";\n";
		ss << "\treturn " << varName << ";\n";
	}


	return ss.str();
}

std::string printFuncSignature(ezFuncVal func){
	std::stringstream ss;
	std::string paramsSignature = "";
	ss << "(";
	for(auto& type : func.signature){
		switch(type) {
			case Type::I32 : {
				paramsSignature += "i32, ";
				break;
			}
			case Type::I64 : {
				paramsSignature += "i64, ";
				break;
			}
			case Type::F32 : {
				paramsSignature += "f32, ";
				break;
			}
			case Type::F64 : {
				paramsSignature += "f64, ";
				break;
			}
		}
	}
	if(!paramsSignature.empty()){
		paramsSignature.pop_back();
		paramsSignature.pop_back();
	}

	ss << paramsSignature << ") => ";

	paramsSignature = "";
	for(auto& type : func.returnValues){
		switch(type) {
			case Type::I32 : {
				paramsSignature += "i32, ";
				break;
			}
			case Type::I64 : {
				paramsSignature += "i64, ";
				break;
			}
			case Type::F32 : {
				paramsSignature += "f32, ";
				break;
			}
			case Type::F64 : {
				paramsSignature += "f64, ";
				break;
			}
		}
	}
	if(!paramsSignature.empty()){
		paramsSignature.pop_back();
		paramsSignature.pop_back();
	}

	ss << "(" << paramsSignature << ")";

	return ss.str();
}

std::string printFuncSignature(Func *func){
	std::stringstream ss;
	std::string paramsSignature = "";
	ss << "(";
	for(auto& type : func->decl.sig.param_types){
		switch(type) {
			case Type::I32 : {
				paramsSignature += "i32, ";
				break;
			}
			case Type::I64 : {
				paramsSignature += "i64, ";
				break;
			}
			case Type::F32 : {
				paramsSignature += "f32, ";
				break;
			}
			case Type::F64 : {
				paramsSignature += "f64, ";
				break;
			}
		}
	}
	if(!paramsSignature.empty()){
		paramsSignature.pop_back();
		paramsSignature.pop_back();
	}

	ss << paramsSignature << ") => ";

	paramsSignature = "";
	for(auto& type : func->decl.sig.result_types){
		switch(type) {
			case Type::I32 : {
				paramsSignature += "i32, ";
				break;
			}
			case Type::I64 : {
				paramsSignature += "i64, ";
				break;
			}
			case Type::F32 : {
				paramsSignature += "f32, ";
				break;
			}
			case Type::F64 : {
				paramsSignature += "f64, ";
				break;
			}
		}
	}
	if(!paramsSignature.empty()){
		paramsSignature.pop_back();
		paramsSignature.pop_back();
	}

	ss << "(" << paramsSignature << ")";

	return ss.str();
}

void prepareMemoryImport(Import *import){
	auto memory_import =  dyn_cast<MemoryImport>(import);
	auto iter = std::find_if(std::begin(parsedModule.imports), std::end(parsedModule.imports),
			    [&] (ezElements const& ezI)
			{
				return ezI.moduleName == import->module_name;
			});

	decltype(parsedModule.imports.begin()) moduleImports;

	if(iter == parsedModule.imports.end()){
		parsedModule.imports.emplace_back(ezElements{import->module_name});
		moduleImports = parsedModule.imports.end() - 1;
	}
	else{
		moduleImports = iter;
	}

	moduleImports->memory.push_back(ezMemoryVal{import->field_name,memory_import->memory.page_limits.initial,memory_import->memory.page_limits.max});
}

void prepareTableImport(Import *import){
	auto table_import =  dyn_cast<TableImport>(import);
	auto iter = std::find_if(std::begin(parsedModule.imports), std::end(parsedModule.imports),
			    [&] (ezElements const& ezI)
			{
				return ezI.moduleName == import->module_name;
			});

	decltype(parsedModule.imports.begin()) moduleImports;

	if(iter == parsedModule.imports.end()){
		parsedModule.imports.emplace_back(ezElements{import->module_name});
		moduleImports = parsedModule.imports.end() - 1;
	}
	else{
		moduleImports = iter;
	}

	moduleImports->tables.push_back(ezTableVal{import->field_name,table_import->table.elem_limits.initial,table_import->table.elem_limits.max});
}

std::string demangle(std::string name, bool replace = true){
	int     status;
	char *realnamec = abi::__cxa_demangle(name.c_str(), 0, 0, &status);
	auto strRealName = name;
	if(realnamec != nullptr){
		strRealName = std::string(realnamec);
	}

	if(replace){
		auto bracketIdx = strRealName.find("(");
		if (bracketIdx!=std::string::npos){
			strRealName.erase(bracketIdx, strRealName.size()-bracketIdx);
		}
		std::replace( strRealName.begin(), strRealName.end(), ' ', '_');
		std::replace( strRealName.begin(), strRealName.end(), '*', '_');
		std::replace( strRealName.begin(), strRealName.end(), '(', '_');
		std::replace( strRealName.begin(), strRealName.end(), ')', '_');
	}


	return strRealName;
}

void prepareFunctionImport(Import *import){
	int     status;
	char *realnamec = abi::__cxa_demangle(import->field_name.c_str(), 0, 0, &status);
	auto func_import =  dyn_cast<FuncImport>(import);
	auto strRealName = demangle(import->field_name);

	auto iter = std::find_if(std::begin(parsedModule.imports), std::end(parsedModule.imports),
		    [&] (ezElements const& ezI)
			{
				return ezI.moduleName == import->module_name;
			});

	decltype(parsedModule.imports.begin()) moduleImports;

	if(iter == parsedModule.imports.end()){
		parsedModule.imports.emplace_back(ezElements{import->module_name});
		moduleImports = parsedModule.imports.end() - 1;
	}
	else{
		moduleImports = iter;
	}

	moduleImports->functions.push_back(ezFuncVal{import->field_name,strRealName,func_import->func.decl.sig.param_types,func_import->func.decl.sig.result_types});
}

void prepareFunctionExport(Export *mExport, Module *module){
	int     status;
	char *realnamec = abi::__cxa_demangle(mExport->name.c_str(), 0, 0, &status);
	auto func = module->GetFunc(mExport->var);
	auto strRealName = demangle(mExport->name);

	parsedModule.exports.functions.push_back(ezFuncVal{mExport->name,strRealName,func->decl.sig.param_types,func->decl.sig.result_types});

}



int main(){
	std::unique_ptr<WastLexer> lexer = WastLexer::CreateFileLexer(s_infile);
	if (!lexer)
	    WABT_FATAL("unable to read file: %s\n", s_infile);

	ErrorHandlerFile error_handler(Location::Type::Text);
	std::unique_ptr<Module> module;
	WastParseOptions parse_wast_options(s_features);
	Result result =
		  ParseWatModule(lexer.get(), &module, &error_handler, &parse_wast_options);
	std::cout << "Imports count " << module->imports.size() << "\r\n";
	std::vector<std::string> tableElems;

	for(auto& import : module->imports){
		switch(import->kind()){
			case ExternalKind::Func :{
				prepareFunctionImport(import);
				break;
			}
			case ExternalKind::Table : {
				prepareTableImport(import);
				break;
			}
			case ExternalKind::Memory : {
				prepareMemoryImport(import);
				break;
			}
		}
	}

	for(auto& mExport : module->exports){
		switch(mExport->kind){
			case ExternalKind::Func :{
				prepareFunctionExport(mExport,module.get());
				break;
			}
		}
	}

	std::stringstream jsCode;
	jsCode << "Module.imports = {\n";
	for(auto const &import : parsedModule.imports) {
	  jsCode << "\t" << import.moduleName << " : {\n";
	  auto vecSize = import.functions.size()+import.tables.size()+import.memory.size();
	  auto argCounter = 0;
	  for(auto const &function : import.functions) {
		  const auto &temp = jsCode.str();
		  jsCode.seekp(0);

		  jsCode << "// " << function.realName << " : " << printFuncSignature(function) << "\n";
		  jsCode << "Module." << function.realName << " = function " << "("+printParams(function.signature)+") {\n";
		  jsCode << printReturnParams(function.returnValues);
		  jsCode << "\n}\n\n";
		  jsCode << temp;

		  jsCode << "\t\t" << "" << function.name << " : " << "Module." <<function.realName;

		  if(argCounter+1 != vecSize){
			  jsCode << ",\n";
		  }
		  else{
			  jsCode << "\n";
		  }
		  argCounter++;
	  }

	  for(auto const &table : import.tables) {
	  		  const auto &temp = jsCode.str();
	  		  jsCode.seekp(0);

	  		  int elemsCounter = 0;

	  		  jsCode << "Module." << table.name << " = new WebAssembly.Table({";
	  		  if(table.initial > 0){
	  			jsCode << "initial: " << table.initial << ", ";
	  		  }

	  		  if(table.max > 0){
	  			  jsCode << "max: " << table.max << ", ";
	  		  }

	  		  jsCode << "element:\"anyfunc\"});\n\n";

	  		elemsCounter = 0;
	  		if(!module->elem_segments.empty()){
				jsCode << "Module.tableMapping = {\n";
				for(auto& segment : module->elem_segments){
					  for(auto& tableVar : segment->vars){
						auto func = module->GetFunc(tableVar);
						auto funcParamsStr = printParams(func->decl.sig.param_types);
						jsCode << "\t// [" << elemsCounter << "] => " << tableVar.name() << " : " << printFuncSignature(func);
						auto fName = tableVar.name().substr(1); //removing $
						auto demangled = demangle(fName,false);
						if(fName != demangled){
							jsCode << " (demangled " << demangled << ")";
						}
						jsCode << "\n";
						jsCode << "\t" << tableVar.name() << " : " << "function(" << funcParamsStr << ") {\n";
						jsCode << "\t\t" << "return Module." << table.name << ".get(" << elemsCounter << ")(" << funcParamsStr << ");\n";
						jsCode << "\t}";
						if (elemsCounter+1 < module->elem_segments.size()){
							jsCode << ",";
						}
						jsCode << "\n";
						elemsCounter++;
					  }
				  }
			  }

	  		  jsCode << "}\n\n";

	  		  jsCode << temp;

	  		  jsCode << "\t\t" << table.name << " : Module." << table.name;

	  		  if(argCounter+1 != vecSize){
	  			  jsCode << ",\n";
	  		  }
	  		  else{
	  			  jsCode << "\n";
	  		  }
	  		  argCounter++;
	  }

	  for(auto const &memory : import.memory) {
			  const auto &temp = jsCode.str();
			  jsCode.seekp(0);

			  jsCode << "Module." << memory.name << " = new WebAssembly.Memory({";
			  std::string memoryInner = "";
			  if(memory.initial > 0){
				  memoryInner+= "initial: " + std::to_string(memory.initial) + ", ";
			  }

			  if(memory.max > 0){
				  memoryInner+= "max: " + std::to_string(memory.initial) + ", ";
			  }

			  if(!memoryInner.empty()){
				  memoryInner.pop_back();
				  memoryInner.pop_back();
			  }

			  jsCode << "});\n\n";

			  jsCode << temp;

			  jsCode << "\t\t" << memory.name << " : Module." << memory.name;

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
	jsCode << "}\n\n";

	jsCode << "Module.exports = {\n";
	auto vecSize =  parsedModule.exports.functions.size();
	auto argCounter = 0;
	for(auto const &exportFunc : parsedModule.exports.functions){
		auto funcParams = printParams(exportFunc.signature);
		jsCode << "\t// " << exportFunc.name << " : " << printFuncSignature(exportFunc) << "\n";
		jsCode << "\t" << exportFunc.realName << " : function" << "("+funcParams+") {\n";
		jsCode << "\t\treturn " << "Module.waInstance.exports." << exportFunc.name <<  "("+funcParams+");\n";
		jsCode << "\t}";
		if(argCounter+1 != vecSize){
		  jsCode << ",\n";
	    }
	    else {
		  jsCode << "\n";
	    }
		argCounter++;
	}
	jsCode << "}\n\n";


	const auto &temp = jsCode.str();
	jsCode.seekp(0);
	jsCode << "var Module = {};\n\n";
	jsCode << temp;

	jsCode << "Module.instantiate = function(modulePath){\n";
	jsCode << "\tfetch(modulePath).then(response =>\n";
	jsCode << "\t\tresponse.arrayBuffer()\n";
	jsCode << "\t).then(bytes =>\n";
	jsCode << "\t\tWebAssembly.compile(bytes)\n";
	jsCode << "\t).then(function(mod) {\n";
	jsCode << "\t\tModule.waInstance = new WebAssembly.Instance(mod,Module.imports);\n";
	jsCode << "\t})\n";
	jsCode << "}";


	std::ofstream outFile("test.js");
	outFile << jsCode.rdbuf();
	outFile.close();

	return 0;
}

