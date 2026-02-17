CXX ?= g++
CXXFLAGS = -Idependencies/glad/include
LDFLAGS  =
LDLIBS   = -lGL -lglfw -ldl

OBJECTS = main.o glad.o
TARGET  = Snake
TARGET_WIN = Snake.exe

ifeq ($(findstring mingw,$(CXX)),mingw)
	TARGET = $(TARGET_WIN)
	LDFLAGS  = -Wl,-subsystem,console -static-libgcc -static-libstdc++
endif

.PHONY: all build run clean

all: build

build: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CXX) $(LDFLAGS) -o $@ $(OBJECTS) $(LDLIBS)

%.o: src/%.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

glad.o: dependencies/glad/src/glad.c
	$(CC) $(CXXFLAGS) -c $< -o $@

clean:
	rm -f $(TARGET) *.o

clean_all:
	rm -f $(TARGET) *.o
	rm -f $(TARGET_WIN) *.o

run: $(TARGET)
	./$(TARGET)
