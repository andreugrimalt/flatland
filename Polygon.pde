class Polygon {
  
  // r=size; xPos ="x" position; yPos ="y" position; dx = "x" distance difference; dy = "y" distance difference
  float r,xPos,yPos, dx, dy;
  
  // numberVertices = polygon vertex number
  float numVertices;
  
  // if exists is true, a regularPolygon is added. It is controled by a gaussian distribution
  boolean exist=false;
  
  // "x" and "y" speed
  float vx=random(-0.6,1);
  float vy=random(-0.6,1);
  
  // the constructor contain everything for initialize a regularPolygon object. 
  // Notice that by passing the arrayList where the objects will be added, each object contain information
  // about itself and all the others.
  Polygon(float x, float y, float r, float numVertices,ArrayList other) {
    
    // translate the origin to the center of the window
    xPos=x+width/2;
    yPos=y+height/2;
    
    this.r=r;
    this.numVertices=numVertices;
    regularPolygons=other;
  }
  
  // draw the regularPolygons
  void draw() {
    stroke(255);
    fill(0);
    // face the movement direction
    float f=atan2(vy,vx);
    
    beginShape();
    for (float i = 0+f; i <= 2*PI+f; i+=(2*PI)/numVertices) {
      vertex(xPos+r*cos(i), yPos+r*sin(i));
    }
    endShape(CLOSE);
  }

  // move the regularPolygons
  void move() {
    xPos+=vx;
    yPos+=vy;
  }

  // bounce the regularPolygons when they reach a window edge
  void bounce() {
    if(xPos>=width-r || xPos<=r) {
      vx*=-0.5;
      xPos=constrain(xPos,0,width);
      if(abs(vx)<r) {
        vx=random(-4,4);
      }
    }
    if(yPos>=height-r || yPos<=r) {
      vy*=-0.5;
      yPos=constrain(yPos,0,height);
      if(abs(vy)<r) {
        vy=random(-4,4);
      }
    }
  }
  
  // make the regularPolygons detect eachother and colide
  void colision() {

    for (int i = 0; i < regularPolygons.size(); i++) {
      Polygon regularPolygon=(Polygon) regularPolygons.get(i);
      //find the distance to other regularPolygons
      float dx = regularPolygon.xPos - xPos;
      float dy = regularPolygon.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);
      
      // if the distance is smaller than the sum of the sizes, then interchange the speeds between
      // the two objects
      float minDist = regularPolygon.r+r;
      if (distance < minDist) {
        
        // angle of the velocity vector
        float angle = atan2(dy, dx);
        float targetX = xPos + cos(angle) * minDist;
        float targetY = yPos + sin(angle) * minDist;
        // new acceleration
        float ax = (targetX - regularPolygon.xPos);
        float ay = (targetY - regularPolygon.yPos);
        // interchange the speeds between regularPolygons
        vx -= ax;
        vy -= ay;
        regularPolygon.vx += ax;
        regularPolygon.vy += ay;
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

// find out if the player has come across a regularPolygon with more than 5 sides or a soldier, if so, 
// turn "dead" to true. When "dead" is true, the menu screen is displayed
  void death() {

    for(int i=0; i<players.size();i++) {
      Player player=(Player) players.get(i);
      float dx = player.xPos - xPos;
      float dy = player.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = player.r+r;
      // when almost colision check numVertices (that figure)
      if (distance<minDist) {
        float killerCircles = numVertices;
        if(killerCircles>5) {
          println("death");

          dead=true;
        }
      }
    }
  }

// atract regularPolygons to the player or to the monolith
  void atraction() {
    // if there isn't any monolith in the window, then the player atracts the regularPolygons
    if(monoliths.size()<=1) {

      for (int i = 0; i < regularPolygons.size(); i++) {
        Polygon regularPolygon=(Polygon) regularPolygons.get(i);
        Player player=(Player) players.get(0);

        float dx = regularPolygon.xPos - player.xPos;
        float dy = regularPolygon.yPos - player.yPos;
        // the smaller the force, the faster they move
        vx -= dx/force;
        vy -= dy/force;
        regularPolygon.vx += -dx/force;
        regularPolygon.vy += -dy/force;
      }
    }
    
    // if there is a monolith, then regularPolygons are atracted by it
    if(monoliths.size()>1) {
      for (int i = 0; i < regularPolygons.size(); i++) {
        Polygon regularPolygon=(Polygon) regularPolygons.get(i);
        Monolith monolith=(Monolith) monoliths.get(1);
        float dx = regularPolygon.xPos - monolith.xPos;
        float dy = regularPolygon.yPos - monolith.yPos;
        vx -= dx/force;
        vy -= dy/force;
        regularPolygon.vx += -dx/force;
        regularPolygon.vy += -dy/force;
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
      regularPolygons.add(new Polygon(random(-width/2), random(-height/2), random(10,30), int(random(2,8)),regularPolygons));

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

  // if the regularPolygon has more than 5 vertices and comes across one soldier, then kill it
  void killSoldier() {
    for(int i=0; i<soldiers.size();i++) {
      Soldier soldier=(Soldier) soldiers.get(i);
      float dx = soldier.xPos - xPos;
      float dy = soldier.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = soldier.r+r;
      // when almost colision check numVertices (that figure)
      if (distance<minDist) {
        float shouldKill = numVertices;
        if(shouldKill>5) {
          soldiers.remove(i);
        }
      }
      // if there are not soldiers into the soldiers arrayList, then add two
      if(soldiers.size()==0) {
        for(i=0; i<2;i++) {
          soldiers.add(new Soldier(-width/2, -height/2, random(5,25), int(random(2,8)),regularPolygons));
        }
      }
    }
  }
  
  void killIrregularPolygons(){
  for(int i=0; i<irregularPolygons.size();i++) {
      IrregularPolygon irregularPolygon=(IrregularPolygon) irregularPolygons.get(i);
      float dx = irregularPolygon.xPos - xPos;
      float dy = irregularPolygon.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = irregularPolygon.r+r;
      // when almost colision check numVertices (that figure)
      if (distance<minDist) {
          irregularPolygons.remove(i);
      }
      // if there are not irregularPolygons into the soldiers arrayList, then add one
      if(irregularPolygons.size()==0) {
        for(i=0; i<1;i++) {
          irregularPolygons.add(new IrregularPolygon(random(width/2), random(-height/2), random(5,25), random(2,8),regularPolygons));
        }
      }
    }
  }
}


