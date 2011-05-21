all: asteroids.app

asteroids.love: $(wildcard *.lua quadtree/quadtree.lua)
	zip -9 $@ $^

asteroids.app: asteroids.love
	cp -r /Applications/love.app asteroids.app
	cp asteroids.love asteroids.app/Contents/Resources
