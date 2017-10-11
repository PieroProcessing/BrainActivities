class Brain {

  ArrayList<Neuron> neurons = new ArrayList<Neuron>();

  float ls;
  float dim; 
  float netDistMax, netDistMin;
  int numOfStimuli;
  int devX, devY, devZ;

  float cX, cY, cZ;
  int alpha, omega;
  int increment, angleIncrement;
  int VertexSize; // size of the array of 3d model vertex
  int maxConnection;

  Brain (float _cX, float _cY, float _cZ, 
    int _cartesianIncrement, 
    float _netDistMax, float _netDistMin, 
    int _numOfStimuli, 
    float _ls, float _dim, 
    int _VertexSize, int _maxConnection
    ) 
  {  
    cX = _cX;
    cY = _cY;
    cZ = _cZ; //riferimento nello spazio
    increment = _cartesianIncrement; // incremento vertici
    netDistMax = _netDistMax; // numero di collegamenti 
    netDistMin = _netDistMin;
    numOfStimuli = _numOfStimuli; //numero di neuroni attivi in origine
    ls = _ls; 
    dim = _dim; // aspettative di vita - dimensioni neuroni
    VertexSize = _VertexSize; // size of the array of 3d model vertex
    maxConnection = _maxConnection; // max connections for each neuron
  }
  void map3dBrainModel (int indx) {
    for (int i = 0; i<VertexSize; i+=increment) {

      PVector pos = brain3DModel[indx].getVertex(i);
      // println(pos);

      neurons.add(new Neuron(  cX+pos.x, 
        cY+pos.y, 
        cZ+pos.z, 
        dim, 
        random(ls-100, ls))
        );
    }
  }

  void buildConnection() {
    int maxC=0;
    for (int prev =0; prev < neurons.size (); prev++) {
      for ( int actual = prev +1; actual< neurons.size (); actual++) {
        //int actual = constrain(prev+1, 1, neurons.size()-1);
        float dist = abs(dist(neurons.get(prev).location.x, 
          neurons.get(prev).location.y, 
          neurons.get(prev).location.z, 
          neurons.get(actual).location.x, 
          neurons.get(actual).location.y, 
          neurons.get(actual).location.z));
        if ( dist < netDistMax && dist >netDistMin && maxC< 3) {
          neurons.get(actual).addConnection( neurons.get(prev));
          maxC++;
        }
      }
      maxC = 0;
    }
  }
  void activate( boolean CC, int cortex) {
    for (int j = neurons.size ()-1; j >= 0; j--) {
      Neuron nwro = neurons.get(j);
      nwro.run(CC);      
      apoptosiCellulare( nwro, j);
      if ( CC && triggered && mousePressed) {
        triggered = false;
        getText = cortex;
        clicked = !clicked;
      }
    }
  }
  boolean screen() {
    boolean changeColor = false;
    for (Neuron n : neurons) {
      float x = screenX(n.location.x, 
        n.location.y, 
        n.location.z);
      float y = screenY(n.location.x, 
        n.location.y, 
        n.location.z);
      if (mouseX<x+10 && mouseX>x-10 && mouseY<y+10 && mouseY>y-10) {
        changeColor=true;  
        break;
      } else {
        changeColor=false;
      }
    }
    return changeColor;
  }
  void apoptosiCellulare(Neuron c, int i) {
    if (c.isDead()) {
      //neurons.add(new Neuron(neurons.get(i).location.x, neurons.get(i).location.y, neurons.get(i).location.z, dim, random(lifespan-200, lifespan+200)));
      neurons.get(i).rmoveC();
      neurons.add(new Neuron(neurons.get(i).location.x  + random (-5, 5), 
        neurons.get(i).location.y  + random (-5, 5), 
        neurons.get(i).location.z  + random (-5, 5), 
        dim, 
        random(ls-150, ls))
        );           
      neurons.remove(i);
    }
  }
  void regenNewConnection() {
    int maxC = 0;
    for ( int actual = neurons.size ()-2; actual >= 0; actual--) {
      float dist = abs(dist(neurons.get(neurons.size ()-1).location.x, 
        neurons.get(neurons.size ()-1).location.y, 
        neurons.get(neurons.size ()-1).location.z, 
        neurons.get(actual).location.x, 
        neurons.get(actual).location.y, 
        neurons.get(actual).location.z)
        );
      if ( dist < netDistMax && dist >netDistMin && maxC< maxConnection) {
        //      if ( dist > netDistMax || (dist >pow(dim,3) && dist < netDistMin)) {
        neurons.get(actual).addConnection(neurons.get(neurons.size ()-1));
        maxC++;
      }
    }
  }
  void feedforward(float inputCharge) {
    for ( int i=0; i< (neurons.size ()*numOfStimuli/100); i++) {
      Neuron n = neurons.get(int(random(neurons.size())));
      n.chargeNeuron(inputCharge);
    }
  }
}