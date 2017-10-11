void activatioOnClickofStarsOverText() {

  if (countdown) {
    for (Stars s : star) { 
      if ( ref == 0) {
        ref = ctime; 
        //resetting particles and slowing them down
        s.reset();
        s.slowDown(0.35);
      } else if (ref <= 5) {
        s.slowDown(0.85);
      }
    }
    ref -= 1;
  }

  for (Stars y : star) {
    if (clicked) {
      //  Text t = text[int(random(text.length))]; // take the target text
      Text t = text[getText]; // take the target text
      ArrayList <PVector> arrayOfPos = new ArrayList <PVector>();
      arrayOfPos = t.positions; // store the position of the target store
      if ((arrayOfPos.size() != 0) ) {
        PVector tempLoc = arrayOfPos.get(int(random(arrayOfPos.size())));
        // 2,2,3 are factor for position of the writings /// set coherence on Text class
        PVector DefLoc = new PVector(tempLoc.x*t.factorX+t.refX, 
          tempLoc.y*t.factorY+t.refY, 
          tempLoc.z*t.factorZ+t.refZ);
        if ( ref < 2) {
          countdown = false; // need to stop letters on position when triggered
        }
        y.activationText( DefLoc, ref);
      } 
      /*
        float dist = dist(tempLoc.x*t.factorX+t.refX,tempLoc.y*t.factorY+t.refY, mouseX, mouseY);
       if (dist<0.1) {
       println("mouseAction");
       } 
       */
    } else {
      ref=0;
      y.toOrigin();
    }
  }
  for (Stars s : star) {//resetting particles and slowing them down
    s.update();
    s.display( );
  }
  
}
void glitterOfText() {
  for (int i=0; i<list.length; i++) {
    text[i].init(random(-width*1.8, -width/1.3), 
      random(-height*2.7, height/2.4), 
      -centerZ*3/1.4);
    text[i].display(2, 2, 3);
  }
  for (int i = 0; i < star.length; i++) {//creating the particles
    star[i] = new Stars(random(0, centerX*2), 
      random(0, centerY*2), 
      random(0, -centerZ*4) 
      );
  }
}
void testTextButton() {
      // take the target text
  pushMatrix();
  noFill();
  stroke(255);
  translate(text[getText].refX + text[getText].posX, text[getText].refY + text[getText].posY, -centerZ*1.9);
  rectMode(CENTER);
 // rect(-text[getText].tFont*0.0, -text[getText].tSize*0.6, text[getText].widthText*1.8, text[getText].tSize*1.4);
  popMatrix();
}