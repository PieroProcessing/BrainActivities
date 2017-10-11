class Neuron {

  // Neuron has a location
  PVector location;
  float lspan;
  float raggio;  
  float sum = 0;

  ArrayList<Connection> connections = new ArrayList<Connection>();

  Neuron(float x, float y, float z, float w, float _lspan) {
    location = new PVector(x, y, z);
    lspan = _lspan;
    raggio = w;
  }
  void run(boolean c) {
    changeC = c ;
    update();
    render();
    displayConnection();
  }
  void update() {
    lspan -= 0.50;
  }
  // Draw Neuron as a circle
  void render() {
    pushMatrix();  
    // translate(location.x, location.y, location.z); 
    strokeWeight(raggio);
    float b = map(sum, 0, 1, 202, 45);
    if (changeC) {
      stroke(b, 0, 0, lspan);
      raggio = dimension * 2.5;
    } else {
      stroke(b, lspan);
      
    }
    //fill( lspan);
    point(location.x, location.y, location.z);
    popMatrix();
    raggio = lerp(raggio, dimension, 0.1);
  }
  // Receive an input
  void chargeNeuron(float input) {
    // Accumulate it
    sum += input;
   // lspan += input*20;
    // Activate it?
    if (sum > 2) {
      fire();
      sum = 0;  // Reset the sum to 0 if it fires
    }
  }
  void fire() {
    raggio = dimension*4;   // It suddenly is bigger
    // We send the output through all connections
    for (Connection c : connections) {
      c.jounce(sum);
    }
  }
  void addConnection(Neuron n) {
    connections.add(new Connection(this, n, random(0.5)));
  } 
  void displayConnection() {
    for (Connection c : connections) {
      c.display(lspan, changeC);
      c.update();
    }
  }
  void rmoveC() {
    connections.clear();
  }
  boolean isDead() {
    if (lspan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}