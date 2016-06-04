class IrregularPolygon extends Polygon {
  color itscolor=color(random(255),random(255),random(255));
  IrregularPolygon(float x, float y, float r, float numVertices,ArrayList other){
    
    super(x,y,r,numVertices,other);
    
  }
  
  void draw() {
    stroke(255);
    fill(itscolor);
    // face the movement direction
    float f=atan2(vy,vx);
    
    beginShape();
    for (float i = 0+f; i <= 2*PI+f; i+=(2*PI)/numVertices) {
      vertex(xPos+r*cos(i), yPos+r*sin(i));
    }
    endShape(CLOSE);
  }
  
  // add new objects to the arrayList. This process is controled by a Gaussian distribution
  void appear() {
    
    // the gaussian bell is centered at 0, random numbers from 6 to 10 are passed to it. 
    // The gaussian function returns the correspondent value and this is compared with a random number
    // between 0 and 1. If the random number is smaller than the gaussian value (random number under the bell)
    // "exist" is true and a new object is added. The probability that this happens is smaller than 0.22 % (considering
    // one object)
    float r=(int)random(6,10);
    // numbers for deciding if output or not 
    float gr=random(1);
    // parameters of gauss bell
    float sigma=2;
    float mu=0;

    if(exist) {
      irregularPolygons.add(new IrregularPolygon(random(-width/2), random(-height/2), random(10,30), random(2,8),regularPolygons));

      exist=false;
    }
    // if a random value between 0 and 1 is smaller that the gaussian function result, then "exist" is true
    if(gr<gauss(r,sigma,mu)) {
      exist=true;
    }
    println(irregularPolygons.size());
  }
  
  // calculate the gaussian function values
  float gauss(float x, float s, float u) {
    float d;

    d=exp(-(pow((x-u),2))/(2*pow(s,2)))/(sqrt(2*PI)*s);
    return d;
  }

}
  

  
  
  
