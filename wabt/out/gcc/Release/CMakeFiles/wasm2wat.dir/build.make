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

# Include any dependencies generated for this target.
include CMakeFiles/wasm2wat.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/wasm2wat.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/wasm2wat.dir/flags.make

CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o: CMakeFiles/wasm2wat.dir/flags.make
CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o: ../../../src/tools/wasm2wat.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/strelok/wabt/out/gcc/Release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o"
	/usr/bin/g++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o -c /home/strelok/wabt/src/tools/wasm2wat.cc

CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.i"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/strelok/wabt/src/tools/wasm2wat.cc > CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.i

CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.s"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/strelok/wabt/src/tools/wasm2wat.cc -o CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.s

CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o.requires:

.PHONY : CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o.requires

CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o.provides: CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o.requires
	$(MAKE) -f CMakeFiles/wasm2wat.dir/build.make CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o.provides.build
.PHONY : CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o.provides

CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o.provides.build: CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o


# Object files for target wasm2wat
wasm2wat_OBJECTS = \
"CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o"

# External object files for target wasm2wat
wasm2wat_EXTERNAL_OBJECTS =

wasm2wat: CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o
wasm2wat: CMakeFiles/wasm2wat.dir/build.make
wasm2wat: libwabt.a
wasm2wat: CMakeFiles/wasm2wat.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/strelok/wabt/out/gcc/Release/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable wasm2wat"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/wasm2wat.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/wasm2wat.dir/build: wasm2wat

.PHONY : CMakeFiles/wasm2wat.dir/build

CMakeFiles/wasm2wat.dir/requires: CMakeFiles/wasm2wat.dir/src/tools/wasm2wat.cc.o.requires

.PHONY : CMakeFiles/wasm2wat.dir/requires

CMakeFiles/wasm2wat.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/wasm2wat.dir/cmake_clean.cmake
.PHONY : CMakeFiles/wasm2wat.dir/clean

CMakeFiles/wasm2wat.dir/depend:
	cd /home/strelok/wabt/out/gcc/Release && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/strelok/wabt /home/strelok/wabt /home/strelok/wabt/out/gcc/Release /home/strelok/wabt/out/gcc/Release /home/strelok/wabt/out/gcc/Release/CMakeFiles/wasm2wat.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/wasm2wat.dir/depend

