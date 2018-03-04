PImage mainImage;
PImage im;
PImage[] allImages;

int[] r;
int[] g;
int[] b;

int w;
int h;

int scale = 5;
void setup()
{
  size(557, 800);
  mainImage = loadImage("sloth.jpg");
  
  File[] files = listFiles(sketchPath("moCYic/images"));
  allImages = new PImage[files.length];
  for(int i = 0; i < allImages.length; i++)
  {
    allImages[i] = loadImage(files[i].toString());
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
      fill(c);
      noStroke();
      rect(x*scale, y*scale, scale, scale);
    }
  }
  
  
  //image(im, 0, 0);
  noLoop();
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