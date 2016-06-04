// Monolith is a child class of Polygon
class Monolith extends Polygon {

  boolean exist=false;


  Monolith(float x, float y, float r, float numVertices, ArrayList other) {
    super(x,y,r,numVertices,other);
    
  }

// draw the monolith
void draw() {
    noStroke();
    fill(0,0,255,50);
    rect(xPos,yPos,r,r+20);
  }
  
// add new objects to the arrayList. This process is controled by a Gaussian distribution
  void appear() {
// the gaussian bell is centered at 0, random values from 6 to 10 are passed to it. 
    // The gaussian function returns the correspondent value and this is compared with a random number
    // between 0 and 1. If the random number is smaller than the gaussian value (random number under the bell)
    // "exist" is true and a new object is added.
    float r=(int)random(7,10);
    // numbers for deciding if output or not 
    float gr=random(1);
    // parameters of gauss bell
    float sigma=2;
    float mu=0;

    if(exist) {
      monoliths.add(new Monolith(random(-width/2), random(-height/2), 20, 4,regularPolygons));

      exist=false;
    }
// if a random value between 0 and 1 is smaller that the gaussian function result, then "exist" is true
    if(gr<gauss(r,sigma,mu)) {
      exist=true;
    }
  }

// calculate the gaussian function values
  float gauss(float x, float s, float u) {
    float d;

    d=exp(-(pow((x-u),2))/(2*pow(s,2)))/(sqrt(2*PI)*s);
    return d;
  }

// the next 3 functions return a boolean if a regularPolygon, killerCircle or a soldier come across a monolith
  boolean polygonFoundMonolith() {
    boolean foundMonolith=false;
    for (int i = 0; i < regularPolygons.size(); i++) {
      Polygon regularPolygon=(Polygon) regularPolygons.get(i);
      //compare your distance to regularPolygons
      float dx = regularPolygon.xPos - xPos;
      float dy = regularPolygon.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = regularPolygon.r+r;
      if (distance < minDist) {
        foundMonolith=true;

      }else{
        foundMonolith=false;
      }
    }
    return foundMonolith;
  }
  boolean killerCircleFoundMonolith() {
    
    boolean foundMonolith=false;
      
      for (int i = 0; i < killerCircles.size(); i++) {
      Killer killerCircle=(Killer) killerCircles.get(i);
      //compare your distance to regularPolygons
      float dx = killerCircle.xPos - xPos;
      float dy = killerCircle.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = killerCircle.r+r;
      if (distance < minDist) {
        foundMonolith=true;
      }
      else {
        foundMonolith=false;
      }
    }
    return foundMonolith;
  }

  boolean soldiersFoundMonolith() {
    boolean foundMonolith=false;
    for (int i = 0; i < soldiers.size(); i++) {
      Soldier soldier=(Soldier) soldiers.get(i);
      //compare your distance to regularPolygons
      float dx = soldier.xPos - xPos;
      float dy = soldier.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = soldier.r+r;
      if (distance < minDist) {
        foundMonolith=true;
      }
      else {
        foundMonolith=false;
      }
    }
    return foundMonolith;
  }
  
    boolean playerFoundMonolith() {
    boolean foundMonolith=false;
    for (int i = 0; i < players.size(); i++) {
      Player player=(Player) players.get(i);
      //compare your distance to regularPolygons
      float dx = player.xPos - xPos;
      float dy = player.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = player.r+r;
      if (distance < minDist) {
        foundMonolith=true;
      }
      else {
        foundMonolith=false;
      }
    }
    return foundMonolith;
  }
}


