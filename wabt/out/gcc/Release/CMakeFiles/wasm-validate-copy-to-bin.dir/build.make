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

# Utility rule file for wasm-validate-copy-to-bin.

# Include the progress variables for this target.
include CMakeFiles/wasm-validate-copy-to-bin.dir/progress.make

CMakeFiles/wasm-validate-copy-to-bin: wasm-validate
	/usr/bin/cmake -E make_directory /home/strelok/wabt/bin
	/usr/bin/cmake -E copy /home/strelok/wabt/out/gcc/Release/wasm-validate /home/strelok/wabt/bin

wasm-validate-copy-to-bin: CMakeFiles/wasm-validate-copy-to-bin
wasm-validate-copy-to-bin: CMakeFiles/wasm-validate-copy-to-bin.dir/build.make

.PHONY : wasm-validate-copy-to-bin

# Rule to build all files generated by this target.
CMakeFiles/wasm-validate-copy-to-bin.dir/build: wasm-validate-copy-to-bin

.PHONY : CMakeFiles/wasm-validate-copy-to-bin.dir/build

CMakeFiles/wasm-validate-copy-to-bin.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/wasm-validate-copy-to-bin.dir/cmake_clean.cmake
.PHONY : CMakeFiles/wasm-validate-copy-to-bin.dir/clean

CMakeFiles/wasm-validate-copy-to-bin.dir/depend:
	cd /home/strelok/wabt/out/gcc/Release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/strelok/wabt /home/strelok/wabt /home/strelok/wabt/out/gcc/Release /home/strelok/wabt/out/gcc/Release /home/strelok/wabt/out/gcc/Release/CMakeFiles/wasm-validate-copy-to-bin.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/wasm-validate-copy-to-bin.dir/depend

