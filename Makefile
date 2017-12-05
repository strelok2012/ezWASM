all:
	g++ \
	 main.cpp \
	 -g \
	 -I./wabt \
	 -I./wabt/out/gcc/Release \
	 -L./wabt/out/gcc/Release \
	 -lwabt \
	 -o main