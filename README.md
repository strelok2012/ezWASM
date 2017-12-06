# ezWASM
This tool generates JS-boilerplate for WASM modules (includes function signatures and demangled function names).

Example js code for [this wast file](https://github.com/strelok2012/ezWASM/blob/master/wast/cpp.wast):

```javascript
var Module = {};

Module.mem = new WebAssembly.Memory({});

Module.tbl = new WebAssembly.Table({initial: 11, max: 11, element:"anyfunc"});

Module.tableMapping = {
	// [0] => $__wasm_nullptr : () => ()
	$__wasm_nullptr : function() {
		return Module.tbl.get(0)();
	}
	// [1] => $_ZN4Vec3D2Ev : (i32) => (i32) (demangled Vec3::~Vec3())
	$_ZN4Vec3D2Ev : function(i32_1) {
		return Module.tbl.get(1)(i32_1);
	}
	// [2] => $_ZN4Vec3D0Ev : (i32) => () (demangled Vec3::~Vec3())
	$_ZN4Vec3D0Ev : function(i32_1) {
		return Module.tbl.get(2)(i32_1);
	}
	// [3] => $_ZNK4Vec35indexEv : (i32) => (f32) (demangled Vec3::index() const)
	$_ZNK4Vec35indexEv : function(i32_1) {
		return Module.tbl.get(3)(i32_1);
	}
	// [4] => $_ZNK4Vec37sq_distEv : (i32) => (f32) (demangled Vec3::sq_dist() const)
	$_ZNK4Vec37sq_distEv : function(i32_1) {
		return Module.tbl.get(4)(i32_1);
	}
	// [5] => $_ZNK4Vec34getXEv : (i32) => (f32) (demangled Vec3::getX() const)
	$_ZNK4Vec34getXEv : function(i32_1) {
		return Module.tbl.get(5)(i32_1);
	}
	// [6] => $_ZNK4Vec34getYEv : (i32) => (f32) (demangled Vec3::getY() const)
	$_ZNK4Vec34getYEv : function(i32_1) {
		return Module.tbl.get(6)(i32_1);
	}
	// [7] => $_ZN4SizeD2Ev : (i32) => (i32) (demangled Size::~Size())
	$_ZN4SizeD2Ev : function(i32_1) {
		return Module.tbl.get(7)(i32_1);
	}
	// [8] => $_ZN4SizeD0Ev : (i32) => () (demangled Size::~Size())
	$_ZN4SizeD0Ev : function(i32_1) {
		return Module.tbl.get(8)(i32_1);
	}
	// [9] => $_ZNK4Size8getWidthEv : (i32) => (f32) (demangled Size::getWidth() const)
	$_ZNK4Size8getWidthEv : function(i32_1) {
		return Module.tbl.get(9)(i32_1);
	}
	// [10] => $_ZNK4Size9getHeightEv : (i32) => (f32) (demangled Size::getHeight() const)
	$_ZNK4Size9getHeightEv : function(i32_1) {
		return Module.tbl.get(10)(i32_1);
	}
}

// import_function : (i32) => ()
Module.import_function = function (i32_1) {

}

// operator_delete : (i32) => ()
Module.operator_delete = function (i32_1) {

}

Module.imports = {
	env : {
		_ZdlPv : Module.operator_delete,
		import_function : Module.import_function
	}
	js : {
		tbl : tbl,
		mem : mem
	}
}

Module.exports = {
	// _Z8makeVec3fff : (i32, f32, f32, f32) => ()
	makeVec3 : function(i32_1, f32_1, f32_1, f32_1) {
		return Module.waInstance.exports._Z8makeVec3fff(i32_1, f32_1, f32_1, f32_1);
	},
	// _Z10vec3SqDistRK4Vec3 : (i32) => (f32)
	vec3SqDist : function(i32_1) {
		return Module.waInstance.exports._Z10vec3SqDistRK4Vec3(i32_1);
	},
	// _Z9vec3IndexRK4Vec3 : (i32) => (f32)
	vec3Index : function(i32_1) {
		return Module.waInstance.exports._Z9vec3IndexRK4Vec3(i32_1);
	},
	// _Z8makeSizeff : (i32, f32, f32) => ()
	makeSize : function(i32_1, f32_1, f32_1) {
		return Module.waInstance.exports._Z8makeSizeff(i32_1, f32_1, f32_1);
	},
	// _Z12getSizeWidthRK4Size : (i32) => (f32)
	getSizeWidth : function(i32_1) {
		return Module.waInstance.exports._Z12getSizeWidthRK4Size(i32_1);
	},
	// _Z13getSizeHeightRK4Size : (i32) => (f32)
	getSizeHeight : function(i32_1) {
		return Module.waInstance.exports._Z13getSizeHeightRK4Size(i32_1);
	},
	// export_function : (i32) => (i32)
	export_function : function(i32_1) {
		return Module.waInstance.exports.export_function(i32_1);
	},
	// header_function : (i32) => (i32)
	header_function : function(i32_1) {
		return Module.waInstance.exports.header_function(i32_1);
	}
}

Module.instantiate = function(modulePath){
	fetch(modulePath).then(response =>
		response.arrayBuffer()
	).then(bytes =>
		WebAssembly.compile(bytes)
	).then(function(mod) {
		Module.waInstance = new WebAssembly.Instance(mod,Module.imports);
	})
}
```
