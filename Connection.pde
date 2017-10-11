class Connection {

  // Connection is from Neuron A to B
  Neuron a;
  Neuron b;

  // Connection has a weight
  float weight;

  // Variables to track the animation
  boolean sending = false;
  PVector sender;

  // Need to store the output for when its time to pass along
  float output = 0;

  Connection(Neuron from, Neuron to, float _weight) {

    a = from;
    b = to;
    weight = _weight;
  }
  void jounce(float val) {
    output = val*weight;        // Compute output
    sender = a.location.get();  // Start animation at Neuron A
    sending = true;             // Turn on sending
  }

  // Update traveling sender
  void update() {
    if (sending) {
      // Use a simple interpolation
      sender.x = lerp(sender.x, b.location.x, 0.1);
      sender.y = lerp(sender.y, b.location.y, 0.1);
      sender.z = lerp(sender.z, b.location.z, 0.1);
      float d = PVector.dist(sender, b.location);
      // If we've reached the end
      if (d < 1) {
        // Pass along the output!
        b.chargeNeuron(output);
        sending = false;
      }
    }
  }
  // Drawn as a line
  void display(float lifes, boolean colorChange) {
   if (colorChange) {
      strokeWeight(1);
      stroke( 255, 0, 0, lifes);
    } else {
      stroke( 255, lifes);
     // strokeWeight(0.02);
     strokeWeight(0.055);
    }
    
    line(a.location.x, a.location.y, a.location.z, b.location.x, b.location.y, b.location.z);
    if (sending && !b.isDead()) {     
      pushMatrix();
      translate(sender.x, sender.y, sender.z);
      stroke(10, 255, 10, 255);
      //fill(10, 255, 10, 255);
      strokeWeight(dimension*0.8);
      ellipse(0, 0, 15*weight, 15*weight);
      popMatrix();
    }
  }
}