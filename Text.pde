class Text { //<>//
  PFont ff;
  PImage [] pictureFrom ;
  ArrayList <PVector> positions = new ArrayList <PVector>();

  int posX = width*2;
  int posY = height*2;

  float factorX, factorY, factorZ;
  int tSize, tFont;
  
  float widthText;

  float refX ;
  float refY ;
  float refZ ;

  PVector temp;

  Text (String  phrase, int index, int _arrayLn) {


    tSize = posX/10;
    tFont = posY/10;

    pictureFrom = new PImage[_arrayLn];
    ff = createFont("Arial", tFont);
  }
  void init(float _midX, float _midY, float _midZ) {

    refX =  lerp(refX, _midX -tSize/2 - tFont/2, 0.05);
    refY =  lerp(refY, _midY -tSize/2 - tFont/2, 0.05);
    refZ =  lerp(refZ, _midZ, 0.05);
  }
  void createImg(String splitWord)
  {
    //PImage w = createImage(posX, posY, RGB);
    PGraphics pg = createGraphics(posX, posY, P3D);
    pg.beginDraw();
    pg.background(255);
    pg.fill(200);
    pg.textAlign(CENTER);
    pg.textSize(tSize);
    pg.text(splitWord, posX/2, posY/2);
    widthText = pg.textWidth(splitWord);
    pg.loadPixels();
    for (int x = 0; x < posX; x++) {
      for (int y = 0; y < posY; y++) {
        color c = color(pg.pixels[x+y*posX]);
        if (c != -1) {
          positions.add(new PVector(x, y, 0));
        }
      }
    }
    pg.endDraw();
    pg.updatePixels();
  
  }
  ArrayList getLocation() {
    return positions;
  }
  void display(float _factorX, float _factorY, float _factorZ) {
      factorX = _factorX;
      factorY = _factorY;
      factorZ = _factorZ;     
    for (int i = 0; i < positions.size ()-1; i+=20) {
      PVector ps = (PVector) positions.get(i);    
      temp = new PVector (ps.x*factorX+refX, ps.y*factorY+refY, ps.z*factorZ+refZ);
      pushMatrix();
      translate(temp.x, temp.y, temp.z);
      //stroke(175);
      //box(4, 4, 4);
      popMatrix();
    }
  }
}