// Player is a child class of Polygon
class Player extends Polygon {

  Player(float x, float y, float r, float numVertices, ArrayList other) {
    super(x,y,r,numVertices,other);
  }

// draw the player
  void draw() {
    fill(0,0);
    stroke(255);
    float f=PI/4;
    beginShape();
    for (float i = 0+f; i <= 2*PI+f; i+=(2*PI)/numVertices) {
      vertex(xPos+r*cos(i), yPos+r*sin(i));
    }
    endShape(CLOSE);
  }

// move the player
  void updatePlayer() {
    xPos=mouseX;
    yPos=mouseY;
  }

// the objects colide with the player
  void colision() {
    for (int i = 0; i < regularPolygons.size(); i++) {
      Polygon regularPolygon=(Polygon) regularPolygons.get(i);
      //compare your distance to regularPolygons
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
    for (int i = 0; i < killerCircles.size(); i++) {
      Killer killerCircle=(Killer) killerCircles.get(i);
      //compare your distance to regularPolygons
      float dx = killerCircle.xPos - xPos;
      float dy = killerCircle.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = killerCircle.r+r;
      if (distance < minDist) {
        //        println("colision");
        float angle = atan2(dy, dx);
        float targetX = xPos + cos(angle) * minDist;
        float targetY = yPos + sin(angle) * minDist;
        float ax = (targetX - killerCircle.xPos);
        float ay = (targetY - killerCircle.yPos);
        vx -= ax;
        vy -= ay;
        killerCircle.vx += ax;
        killerCircle.vy += ay;
        
        // if the player touches the circle, then the core is 0
        scoreCount=0;
      }
    }
  }
}


