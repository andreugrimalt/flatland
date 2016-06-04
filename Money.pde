// Money is a child class of Polygon
class Money extends Polygon {

  boolean exist=false;

  Money(float x, float y, float r, float numVertices, ArrayList other) {
    super(x,y,r,numVertices,other);
    this.numVertices=21;
  }

  // draw the coins
  void draw() {
    noStroke();
    fill(255,215,0);
    // face the movement direction
    float f=atan2(vy,vx);
    beginShape();
    for (float i = 0; i <= 2*PI; i+=(2*PI)/numVertices) {
      vertex(xPos+r*cos(i), yPos+r*sin(i));
    }
    endShape(CLOSE);
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
      coins.add(new Money(random(-width/2+40,width/2-40), random(-height/2+60,height/2-60), 10, 4,regularPolygons));

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

// all the objects colide with the coins. 
// It determines if the player has come across a coin, if so, it turns the boolean "moneyFound" to true
  void colision() {

    for (int i = 0; i < players.size(); i++) {
      Player player=(Player) players.get(i);
      //compare your distance to regularPolygons
      float dx = player.xPos - xPos;
      float dy = player.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = player.r+r;
      if (distance < minDist) {

        moneyFound=true;
      }
      else {
        moneyFound=false;
      }
    } 

    for (int i = 0; i < regularPolygons.size(); i++) {
      //compare your distance to others
      Polygon reg=(Polygon) regularPolygons.get(i);
      float dx = reg.xPos - xPos;
      float dy = reg.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = reg.r+r;
      if (distance < minDist) {
        //        println("colision");
        float angle = atan2(dy, dx);
        float targetX = xPos + cos(angle) * minDist;
        float targetY = yPos + sin(angle) * minDist;
        float ax = (targetX - reg.xPos);
        float ay = (targetY - reg.yPos);
        vx -= ax;
        vy -= ay;
        reg.vx += ax;
        reg.vy += ay;
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
    for (int i = 0; i < irregularPolygons.size(); i++) {
      //compare your distance to others
      IrregularPolygon irregularPolygon=(IrregularPolygon) irregularPolygons.get(i);
      float dx = irregularPolygon.xPos - xPos;
      float dy = irregularPolygon.yPos - yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = irregularPolygon.r+r;
      if (distance < minDist) {
        //        println("colision");
        float angle = atan2(dy, dx);
        float targetX = xPos + cos(angle) * minDist;
        float targetY = yPos + sin(angle) * minDist;
        float ax = (targetX - irregularPolygon.xPos);
        float ay = (targetY - irregularPolygon.yPos);
        vx -= ax;
        vy -= ay;
        irregularPolygon.vx += ax;
        irregularPolygon.vy += ay;
      }
    }
  }
}


