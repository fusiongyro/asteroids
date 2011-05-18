all: asteroids.love

asteroids.love: $(wildcard *.lua)
	zip -9 $@ $^
