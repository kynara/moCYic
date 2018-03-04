PImage mainImage;
PImage im;
PImage[] allImages;

int r;
int g;
int b;
int numpix;

color[] avgc;

int ww = 9600; 
int hh = 8710; 

int w;
int h;

int scale = 8;
void setup()
{
  size(9600, 8710);
 // size(600, 800); //sloth1
  mainImage = loadImage("test1.png");
  
  File[] files = listFiles(sketchPath("./images"));
  allImages = new PImage[files.length/4];
  avgc = new color[files.length/4];
  
  for(int i = 0; i < allImages.length; i++)
  {
    allImages[i] = loadImage(files[i].toString());
    avgc[i] = extractColorFromImage(allImages[i]);
    print((double) i/allImages.length*100 + "\n");
  }  
  
  w = mainImage.width/scale;
  h = mainImage.height/scale;
  
  im = createImage(w, h, RGB);
  im.copy(mainImage, 0, 0, mainImage.width, mainImage.height, 0, 0, w, h);
  
}


void draw()
{
  im.loadPixels();
  for(int x = 0; x < w; x++)
  {
    for(int y = 0; y < h; y++)
    {
      int index = x + y * w;
      color c = im.pixels[index];
      int imin = 0;
      float diffmin = 999999;
      float diff = 0;
      for(int i = 0; i < allImages.length; i++)
      {
        diff = abs(c - avgc[i]);
        //(red(c)-red(avgc[i])) + (blue(c)-blue(avgc[i])) + (green(c)-green(avgc[i])));
        if(diff < diffmin) 
        {
          diffmin = diff;
          imin = i;
        }  

      }

      image(allImages[imin],x*100, y*100, 100, 100);
      //fill(c);
      //noStroke();
      //rect(x*scale, y*scale, scale, scale);
    }
  }
  
  saveFrame(); 
  
  //image(im, 0, 0);
  noLoop();
}

color extractColorFromImage(PImage img) {
    img.loadPixels();
    int r = 0, g = 0, b = 0;
    for (int i=0; i<img.pixels.length; i++) {
        color c = img.pixels[i];
        r += c>>16&0xFF;
        g += c>>8&0xFF;
        b += c&0xFF;
    }
    r /= img.pixels.length;
    g /= img.pixels.length;
    b /= img.pixels.length;
 
    return color(r, g, b);
}

File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}