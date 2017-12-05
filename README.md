# ezWASM
This tool generates JS-boilerplate for WASM modules.

Example js code for [this wast file](https://github.com/strelok2012/ezWASM/blob/master/wast/cpp.wast):

```javascript
var mem = new WebAssembly.Memory({});

// Table elements:
// [0] => $__wasm_nullptr : () => ()
// [1] => $_ZN4Vec3D2Ev : (i32) => (i32) (demangled Vec3::~Vec3__)
// [2] => $_ZN4Vec3D0Ev : (i32) => () (demangled Vec3::~Vec3__)
// [3] => $_ZNK4Vec35indexEv : (i32) => (f32) (demangled Vec3::index___const)
// [4] => $_ZNK4Vec37sq_distEv : (i32) => (f32) (demangled Vec3::sq_dist___const)
// [5] => $_ZNK4Vec34getXEv : (i32) => (f32) (demangled Vec3::getX___const)
// [6] => $_ZNK4Vec34getYEv : (i32) => (f32) (demangled Vec3::getY___const)
// [7] => $_ZN4SizeD2Ev : (i32) => (i32) (demangled Size::~Size__)
// [8] => $_ZN4SizeD0Ev : (i32) => () (demangled Size::~Size__)
// [9] => $_ZNK4Size8getWidthEv : (i32) => (f32) (demangled Size::getWidth___const)
// [10] => $_ZNK4Size9getHeightEv : (i32) => (f32) (demangled Size::getHeight___const)
var tbl = new WebAssembly.Table({initial: 11, max: 11, element:"anyfunc"});

function import_function(i32_1) {

}

function operator_delete_void__(i32_1) {

}

var imports = {
	env : {
		_ZdlPv : operator_delete_void__,
		import_function : import_function
	}
	js : {
		tbl : tbl,
		mem : mem
	}
}
```
