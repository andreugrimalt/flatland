// Killer is a child class of Polygon
class Killer extends Polygon {
  Killer(float x, float y, float r, float numVertices,ArrayList other) {
    super(x,y,r,numVertices,other);
    this.numVertices=30;
  }
  
  // this function works in a identical way as it does the one in Polygon class, there is a minor 
  // difference in the speed calculation 
  void atraction() {
    if(monoliths.size()<=1){
    for (int i = 0; i < killerCircles.size(); i++) {
      Killer killerCircle=(Killer) killerCircles.get(i);
      Player player=(Player) players.get(0);

      float dx = killerCircle.xPos - player.xPos;
      float dy = killerCircle.yPos - player.yPos;
      vx -= 2*dx/force;
      vy -= 2*dy/force;
      killerCircle.vx += -2*dx/force;
      killerCircle.vy += -2*dy/force;
    }
    }
    if(monoliths.size()>1){
      for (int i = 0; i < killerCircles.size(); i++) {
      Killer killerCircle=(Killer) killerCircles.get(i);
      Monolith church=(Monolith) monoliths.get(1);

      float dx = killerCircle.xPos - church.xPos;
      float dy = killerCircle.yPos - church.yPos;
      vx -= 2*dx/force;
      vy -= 2*dy/force;
      killerCircle.vx += -2*dx/force;
      killerCircle.vy += -2*dy/force;
      }
    }
    
  }

// if the killerCircle comes across any object, then remove it from the correspondent array list
  void kill() {

    for (int i = 0; i < regularPolygons.size(); i++) {
      //compare your distance to others
      Polygon regularPolygon=(Polygon) regularPolygons.get(i);
      float dx = regularPolygon.xPos - xPos;
      float dy = regularPolygon.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = regularPolygon.r+r;
      if (distance < minDist) {
        regularPolygons.remove(i);
      }
      // if regularPolygons size is 1, then add 5 regularPolygons to the arrayList
            if(regularPolygons.size()==1) {
        for(i=0; i<5;i++) {
          regularPolygons.add(new Polygon(random(-width/2,width/2), random(-height/2), random(10,30), int(random(2,13)),regularPolygons));
        }
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
        soldiers.remove(i);
      }
      // if soldiers size is 1 then add 2 soldiers to the arraylist
      if(soldiers.size()==1) {
        for(i=0; i<2;i++) {
          soldiers.add(new Soldier(-width/2, -height/2, random(5,25), int(random(2,8)),regularPolygons));
        }
      }
    }
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
  
   for (int i = 0; i < coins.size(); i++) {
      //compare your distance to others
      Money coin=(Money) coins.get(i);
      float dx = coin.xPos - xPos;
      float dy = coin.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = coin.r+r;
      if (distance < minDist) {
        coins.remove(i);
      }
//      if(coins.size()==0) {
//        for(i=0; i<2;i++) {
//          coins.add(new Money(random(width-20),random(height-20),10,4,regularPolygons));
//        }
//      }
    }
  }
}


