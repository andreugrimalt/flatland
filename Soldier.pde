// Soldier is a child class of Polygon
class Soldier extends Polygon {

  Soldier(float x, float y, float r, float numVertices, ArrayList other) {
    super(x,y,r,numVertices,other);
    this.numVertices=random(2,2.2);
  }
  
  // draw the soldier
  void draw() {
    fill(0);
    // face the movement direction
    float f=(atan2(-numVertices*vy,-numVertices*vx));
    beginShape();
    for (float i = 0+f; i <= 2*PI+f; i+=(2*PI)/numVertices) {
      vertex(xPos+r*cos(i), yPos+r*sin(i));
    }
    endShape(CLOSE);
  }

// the soldiers colide with themselves, regularPolygons and the house. 
  void colision() {

    for (int i = 0; i < regularPolygons.size(); i++) {
      //compare your distance to others
      Polygon regularPolygon=(Polygon) regularPolygons.get(i);
      float dx = regularPolygon.xPos - xPos;
      float dy = regularPolygon.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = regularPolygon.r+r;
      if (distance < minDist) {
        //        println("colision");
        float angle = atan2(dy, dx);
        float targetX = xPos + cos(angle) * minDist;
        float targetY = yPos + sin(angle) * minDist;
        float ax = (targetX - regularPolygon.xPos);
        float ay = (targetY - regularPolygon.yPos);
        vx -= ax;
        vy -= ay;
        regularPolygon.vx += ax;
        regularPolygon.vy += ay;
      }
    }
    for (int i = 0; i < soldiers.size(); i++) {
      //compare your distance to others
      Soldier soldier=(Soldier) soldiers.get(i);
      float dx = soldier.xPos - xPos;
      float dy = soldier.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = soldier.r+r;
      if (distance < minDist) {
        //        println("colision");
        float angle = atan2(dy, dx);
        float targetX = xPos + cos(angle) * minDist;
        float targetY = yPos + sin(angle) * minDist;
        float ax = (targetX - soldier.xPos);
        float ay = (targetY - soldier.yPos);
        vx -= ax;
        vy -= ay;
        soldier.vx += ax;
        soldier.vy += ay;
      }
    }

    //compare your distance to others
    for(int i=0;i<houses.size();i++) {
      House house=(House) houses.get(i);
      float dx = house.xPos - xPos;
      float dy = house.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = house.r+r;
      if (distance < minDist) {
        //        println("colision");
        float angle = atan2(dy, dx);
        float targetX = xPos + cos(angle) * minDist;
        float targetY = yPos + sin(angle) * minDist;
        float ax = (targetX - house.xPos);
        float ay = (targetY - house.yPos);
        vx -= ax;
        vy -= ay;

      }
    }
  }

// if the player comes across a soldier, then the player is dead
  void death() {
    for(int i=0; i<players.size();i++) {
      Player player=(Player) players.get(i);
      float dx = player.xPos - xPos;
      float dy = player.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = player.r+r;
      if (distance < minDist) {
        println("death");
        dead=true;
      }
    }
  }
  
// atract soldiers to the player or to the monolith
  void atraction() {
    // if there isn't any monolith in the window, then the player atracts the soldiers
    if(monoliths.size()>=1) {
      for (int i = 0; i < soldiers.size(); i++) {
        Soldier soldier=(Soldier) soldiers.get(i);
        Player player=(Player) players.get(0);

        float dx = soldier.xPos - player.xPos;
        float dy = soldier.yPos - player.yPos;
        vx -= dx/force;
        vy -= dy/force;
        soldier.vx += -dx/force;
        soldier.vy += -dy/force;
      }
    }
    // if there is a monolith, then regularPolygons are atracted by it
    if(monoliths.size()>1) {
      for (int i = 0; i < soldiers.size(); i++) {
        Soldier soldier=(Soldier) soldiers.get(i);
        Monolith monolith=(Monolith) monoliths.get(1);

        float dx = soldier.xPos - monolith.xPos;
        float dy = soldier.yPos - monolith.yPos;
        vx -= dx/force;
        vy -= dy/force;
        soldier.vx += -dx/force;
        soldier.vy += -dy/force;
      }
    }
  }

// add new objects to the arrayList. This process is controled by a Gaussian distribution
  void appear() {
    // the gaussian bell is centered at 0, random values from 6 to 10 are passed to it. 
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
      soldiers.add(new Soldier(random(-width/2, width/2), random(-height/2,height/2), random(5,25), int(random(2,8)),regularPolygons));

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

// if a soldier comes across a regularPolygon with less than 6 vertices, then kill it
  void killregularPolygons() {
    for(int i=0; i<regularPolygons.size();i++) {
      Polygon regularPolygon=(Polygon) regularPolygons.get(i);
      float dx = regularPolygon.xPos - xPos;
      float dy = regularPolygon.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = regularPolygon.r+r;
      // check numVertices
      if (distance<minDist) {
        float shouldKill = regularPolygon.numVertices;
        if(shouldKill<6) {

          regularPolygons.remove(i);
        }
      }
      if(regularPolygons.size()==0) {
        regularPolygons.add(new Polygon(random(-width/2),random(-height/2) -50, random(10,30), int(random(2,13)),regularPolygons));
      }
    }
  }
}


