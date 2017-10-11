import processing.opengl.*; //<>// //<>// //<>//

boolean changeC;

import saito.objloader.*;
OBJModel [] brain3DModel = new OBJModel[8];

// ambient variables
int depth = 2000;
float theta =0;
float centerX, centerY, centerZ;
boolean clicked = false;
boolean triggered = false;
boolean countdown = true;

String allWords ="Installation Paintings Dauber CreativeCoding VideoArt Photography Vfx Poetry";
Text [] text;
String[] list;
int getText;

Brain [] brainCortex = new Brain [8];
int dimension = 3; //dimentions of neurons

Stars[] star;

int Percent =10;
int PNum = 1000;
float ref = 0;
float ctime = 15;

void setup()
{
  //size(640, 480, P3D);
  noCursor();
  fullScreen(P3D);

  frameRate(25);
  centerX = width/2;
  centerY = height/2;
  centerZ = depth/2;

  star = new Stars[PNum];

  list = allWords.split(" ");
  text = new Text[list.length];
  for (int i=0; i<list.length; i++) {
    text[i] = new Text(list[i], i, list.length);
    text[i].createImg(list[i]);
  }
  for (int i =0; i<brain3DModel.length; i++) {
    brain3DModel[i] = new OBJModel(this, i+".obj", "absolute", TRIANGLE);
    //  brain3DModel[i].enableDebug();
    brain3DModel[i].scale(18);
  }
  for (int index=0; index < brain3DModel.length; index++) {
    int b3dVertexSize = brain3DModel[index].getVertexCount();
    brainCortex[index] = new Brain(0, 0, 0, //riferimento nello spazio
      2, // incremento vertici
      250, pow(dimension, 2), // numero di collegamenti Max-Min
      25, //numero di neuroni attivi in origine
      255, dimension, // aspettative di vita - dimensioni neuroni 
      b3dVertexSize, 8                    // max connections for each new neuron
      );
    brainCortex[index].map3dBrainModel(index);
    brainCortex[index].buildConnection();
    brainCortex[index].feedforward(random(.5));
  }
} // end of setup  
void draw() {
  background(19, 19, 56);

  glitterOfText();
  activatioOnClickofStarsOverText();
  testTextButton();
  // pushMatrix();
  translate(centerX, centerY*6, -depth*2);
  rotateY(radians(theta));

  if (clicked == false) {
    countdown = true;    // reset the writing animation
  }
  for (int index=0; index < brainCortex.length; index++) {
    pushMatrix();
    noFill();
    stroke(255);
    // brain3DModel[index].draw();
    boolean temp = brainCortex[index].screen();
    brainCortex[index].activate(temp, index);
    brainCortex[index].regenNewConnection();
    //  mousePicking(index);
    popMatrix();
    if (frameCount % 30 == 0) {
      brainCortex[index].feedforward(random(.5));
    }
  }
  // popMatrix();


  theta+= 0.3;
  theta= theta%360;
}
void mousePressed() {
  triggered = true;
}
int printDebug() {
  return color(random(100, 220), random(100, 220), random(100, 220));
}