PImage mainImage;
PImage im;
PImage[] allImages;

int r;
int g;
int b;
int numpix;

color[] avgc;

int w;
int h;

int scale = 5;
void setup()
{
  size(557, 800); //sloth
 // size(600, 800); //sloth1
  mainImage = loadImage("sloth.jpg");
  
  File[] files = listFiles(sketchPath("moCYic/images"));
  allImages = new PImage[files.length];
  avgc = new color[files.length];
  
  for(int i = 0; i < allImages.length; i++)
  {
    allImages[i] = loadImage(files[i].toString());
    allImages[i].loadPixels();
    r = g = b = numpix = 0;
    for(int x = 0; x < allImages[i].width; x++)
    {
      for(int y = 0; y < allImages[i].height; y++)
      {
        int index = x + y * allImages[i].width;
        color c = allImages[i].pixels[index];
        r += red(c);
        b += blue(c);
        g += green(c);
        
        numpix++;
      }
    }
    avgc[i] = color(r/numpix, g/numpix, b/numpix);
    print((double)i/allImages.length*100 + "\n");
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
        diff = abs((red(c)-red(avgc[i])) + (blue(c)-blue(avgc[i])) + (green(c)-green(avgc[i])));
        if(diff < diffmin) 
        {
          diffmin = diff;
          imin = i;
        }  
        /*if(diff < 10)
        {
          imin = i;
          break;
        }  */
      }
      if(diff>99999)
      {
        fill(c);
        noStroke();
      }  
      else
        image(allImages[imin],x*scale, y*scale, scale, scale);
      //fill(c);
      //noStroke();
      //rect(x*scale, y*scale, scale, scale);
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