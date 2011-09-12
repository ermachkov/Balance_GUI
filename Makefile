CXX = g++
PREFIX = /usr
PACKAGES = clanApp-2.3 clanCore-2.3 clanDisplay-2.3 clanGL-2.3 clanNetwork-2.3 clanSound-2.3 clanVorbis-2.3 lua
CXXFLAGS = -DGAME_DATA_DIR=\"$(PREFIX)/share/balance\" $(shell pkg-config --cflags $(PACKAGES)) -Wall -O2 -s
LIBS = $(shell pkg-config --libs $(PACKAGES)) -ltolua++-5.1
BIN = balance

PCH = src/Precompiled.h.gch
OBJ = \
	src/Application.o \
	src/Balance.o \
	src/Font.o \
	src/FontResource.o \
	src/Graphics.o \
	src/Keyboard.o \
	src/LuaBindings.o \
	src/LuaModule.o \
	src/LuaScript.o \
	src/Mouse.o \
	src/Precompiled.o \
	src/Profile.o \
	src/Program.o \
	src/ResourceManager.o \
	src/ResourceQueue.o \
	src/Sound.o \
	src/SoundResource.o \
	src/Sprite.o \
	src/SpriteResource.o

all : $(BIN)

$(BIN) : $(PCH) $(OBJ)
	$(CXX) $(CXXFLAGS) $(OBJ) -o $(BIN) $(LIBS)

%.gch : %
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o : %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

install:
	mkdir -p $(PREFIX)/bin
	mkdir -p $(PREFIX)/share/balance
	cp $(BIN) $(PREFIX)/bin
	cp -rf data/* $(PREFIX)/share/balance

clean:
	rm -f $(PCH) $(OBJ) $(BIN)
