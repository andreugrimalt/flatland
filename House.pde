// House is a child class of Polygon
class House extends Polygon {
  
  House(float x, float y, float r, float numVertices, ArrayList other) {

    super(x,y,r,numVertices,other);
  }

// draw the house
  void draw() {
    fill(255,0,0,50);
    noStroke();
    
    // rotation
    float f=2*PI/4;
    
    beginShape();
    for (float i = PI/5+f; i <= 2*PI+f; i+=(2*PI)/5) {
      vertex(xPos+r*cos(i), yPos+r*sin(i));
    }
    endShape(OPEN);
  }

// determine if the player is inside the house
// or not
  void outHouse() {

    for (int i = 0; i < players.size(); i++) {
      Player player=(Player) players.get(i);
      //compare your distance to regularPolygons
      float dx = player.xPos - xPos;
      float dy = player.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = player.r+r;
      if (distance < minDist) {
        outHouse=false;
  }else{outHouse=true;}
}
  }
}



