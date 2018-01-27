//port from https://www.shadertoy.com/view/Xl2BWw

import processing.video.*;
PShader buffer;
PShader primitiveEdges;
Movie myMovie;
PImage prevBuf = createImage(1280, 720, RGB);
PImage img;
Capture cam;

void setup() {
  size(1280, 720, P2D);
  noStroke();
  //img = loadImage("landscape.jpg");
  myMovie = new Movie(this, "bunnybuck.mov");
  myMovie.loop();
  // This GLSL code shows how to use shaders from 
  // shadertoy in Processing with minimal changes.
  buffer = loadShader("buffer.glsl");
  primitiveEdges = loadShader("image.glsl");
  //edges.set("texture", img);
  //buffer.set("iResolution", float(width), float(height));
  image(myMovie, 0, 0);
  loadPixels();
  prevBuf.loadPixels();
  prevBuf.pixels = pixels;
  prevBuf.updatePixels();
}

void draw() {
  //image(img, 0, 0);
  image(myMovie, 0, 0);
  //image(prevBuf, 0, 0);
  buffer.set("iChannel0", myMovie);
  buffer.set("iChannel1", prevBuf);
  buffer.set("iTime", float(frameCount));
  filter(buffer);
  loadPixels();
  prevBuf.loadPixels();
  prevBuf.pixels = pixels;
  prevBuf.updatePixels();
  primitiveEdges.set("iChannel0", prevBuf);
  filter(primitiveEdges);
  loadPixels();
  prevBuf.loadPixels();
  prevBuf.pixels = pixels;
  prevBuf.updatePixels();
}

void movieEvent(Movie m) {
  m.read();
}