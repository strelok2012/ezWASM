# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.7

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/strelok/wabt

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/strelok/wabt/out/gcc/Release

# Utility rule file for run-tests.

# Include the progress variables for this target.
include CMakeFiles/run-tests.dir/progress.make

CMakeFiles/run-tests: wat2wasm
CMakeFiles/run-tests: wast2json
CMakeFiles/run-tests: wasm2wat
CMakeFiles/run-tests: wasm-opcodecnt
CMakeFiles/run-tests: wasm-objdump
CMakeFiles/run-tests: wasm-link
CMakeFiles/run-tests: wasm-interp
CMakeFiles/run-tests: spectest-interp
CMakeFiles/run-tests: wat-desugar
CMakeFiles/run-tests: wasm-validate
CMakeFiles/run-tests: wabt-unittests
	cd /home/strelok/wabt && /usr/bin/python2.7 /home/strelok/wabt/test/run-tests.py --bindir /home/strelok/wabt/out/gcc/Release

run-tests: CMakeFiles/run-tests
run-tests: CMakeFiles/run-tests.dir/build.make

.PHONY : run-tests

# Rule to build all files generated by this target.
CMakeFiles/run-tests.dir/build: run-tests

.PHONY : CMakeFiles/run-tests.dir/build

CMakeFiles/run-tests.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/run-tests.dir/cmake_clean.cmake
.PHONY : CMakeFiles/run-tests.dir/clean

CMakeFiles/run-tests.dir/depend:
	cd /home/strelok/wabt/out/gcc/Release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/strelok/wabt /home/strelok/wabt /home/strelok/wabt/out/gcc/Release /home/strelok/wabt/out/gcc/Release /home/strelok/wabt/out/gcc/Release/CMakeFiles/run-tests.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/run-tests.dir/depend

