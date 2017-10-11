class Stars {
  PVector location;
  PVector origin;
  PVector velocity;
  boolean target=false;

  Stars(float x, float y, float z) {
    origin = new PVector(x, y, z);
    location = new PVector(x, y, z);
    velocity = new PVector(random(-0.5,0.5), random(-0.5,0.5), random(-0.5,0.5));
  }
  PVector getLocation() {
    return location;
  }
  void slowDown(float factor) {
    velocity.mult(factor);
  }
  void reset() {
    target=false;
  }
  void display() {
    // stroke(255);
    stroke(255/sqrt(velocity.mag()+1), 255, 255, 175*sqrt(velocity.mag()+1));
    strokeWeight(4);
    /*
    pushMatrix();
     translate(location.x, location.y, location.z);
     noFill();
     stroke(255);
     //strokeWeight(100);
     box(1);
     popMatrix();
     */
    line(location.x, location.y, location.z, 
      location.x+0.06*velocity.x, 
      location.y+0.06*velocity.y, 
      location.z+0.06*velocity.z);
  }
  void toOrigin() {
    location.x = lerp(location.x, origin.x, 0.1);
    location.y = lerp(location.y, origin.y, 0.1);
    location.z = lerp(location.z, origin.z, 0.1);
  }
  void update() {
    location.add(velocity);
  }
  void activationText(PVector word, float lenghtOnDist) {
    if (target==false) {
      target=true;
      PVector step = PVector.sub(word, location);
      step.div(lenghtOnDist);  // more is the distance less is the step aka the lenght of the star
      velocity= step;//kicking the particle in the direction of the point
    }
  }
}