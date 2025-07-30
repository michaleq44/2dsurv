USR = ${USR_DIR}
INCLUDE = -Iinc
CFLAGS = --std=c++17
DEBUGCFLAGS = -g
RELEASECFLAGS = -O2
OBJS = obj/main.o obj/app.o obj/vlk.o obj/appprivate.o
EXENAME = 2dsurv
LDFLAGS =

ifeq ($(OS),Windows_NT)
	EXEEXT = .exe
	LIBS = -lglfw3 -lvulkan-1
	RELEASELDFLAGS += -mwindows
	MKDIR = $(USR)/../usr/bin/mkdir
else
	LIBS = $(shell pkg-config --libs glfw3) $(shell pkg-config --libs vulkan) $(shell pkg-config --libs x11) $(shell pkg-config --libs xxf86vm) $(shell pkg-config --libs xi) $(shell pkg-config --libs xrandr) -ldl -lpthread
	CFLAGS += $(shell pkg-config --cflags glfw3) $(shell pkg-config --cflags vulkan) $(shell pkg-config --cflags x11) $(shell pkg-config --cflags xxf86vm) $(shell pkg-config --cflags xi) $(shell pkg-config --cflags xrandr)
	MKDIR = /usr/bin/mkdir
endif

shader:
	${MKDIR} -p bin/shaders
	glslc shaders/shader.vert -o bin/shaders/vert.spv
	glslc shaders/shader.frag -o bin/shaders/frag.spv

debug: shader
	g++ -c src/main.cpp $(CFLAGS) $(DEBUGCFLAGS) $(INCLUDE) -o obj/main.o
	g++ -c src/app.cpp $(CFLAGS) $(DEBUGCFLAGS) $(INCLUDE) -o obj/app.o
	g++ -c src/vlk.cpp $(CFLAGS) $(DEBUGCFLAGS) $(INCLUDE) -o obj/vlk.o
	g++ -c src/appprivate.cpp $(CFLAGS) $(DEBUGCFLAGS) $(INCLUDE) -o obj/appprivate.o

	g++ $(OBJS) $(LIBS) -o "bin/$(EXENAME)$(EXEEXT)" $(LDFLAGS)
	cd bin ; "./$(EXENAME)"

release: shader
	g++ -c src/main.cpp $(CFLAGS) $(RELEASECFLAGS) $(INCLUDE) -o obj/main.o
	g++ -c src/app.cpp $(CFLAGS) $(RELEASECFLAGS) $(INCLUDE) -o obj/app.o
	g++ -c src/vlk.cpp $(CFLAGS) $(RELEASECFLAGS) $(INCLUDE) -o obj/vlk.o
	g++ -c src/appprivate.cpp $(CFLAGS) $(RELEASECFLAGS) $(INCLUDE) -o obj/appprivate.o

	g++ $(OBJS) $(LIBS) -o "bin/$(EXENAME)$(EXEEXT)" $(LDFLAGS) $(RELEASELDFLAGS)
	cd bin ; "./$(EXENAME)"