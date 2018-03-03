PImage img;
int height;
int width;

void setup(){
  height = 609;
  width = 629;
  size(629,609);
  img = loadImage("god.jpg");
}

void draw(){
  background(0);
  PImage img1 = makeLessPixels();
  image(img1,0,0);
}

PImage makeLessPixels(){
  loadPixels();
  img.loadPixels();
  PImage newImg = createImage(629,609,RGB);
  for(int y = 5; y < height - 5; y++){
    for (int x = 5; x < width -5 ; x++){
      float sumR = 0;
      float sumG = 0;
      float sumB = 0;
      for (int y1 = y -5; y1 <= y+5; y1++){
        for (int x1 = x - 5; x1 <= x+5; x1++){
          int loc = x1 + y1*width;
          sumR += red(img.pixels[loc]);
          sumG += green(img.pixels[loc]);
          sumB += blue(img.pixels[loc]);
        }
      }
      float newR = sumR / 9;
      float newG = sumG / 9;
      float newB = sumB / 9;
      newImg.pixels[x + y*width] = color(newR, newG, newB);
    }
  }
  return newImg;
}

      
      
          