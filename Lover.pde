// Lover is a child class of Polygon
class Lover extends Polygon {
  
  boolean theyLove=false;
  
  // variables for the timer
  int savedTime;
  int totalTime = 8000;

  Lover(float x, float y, float r, float numVertices, ArrayList other) {
    super(x,y,r,numVertices,other);
  }

// if the player comes across a lover, then the lover's position is the same as the player and "theyLove" is true
  void love() {
    for (int i = 0; i < lovers.size(); i++) {
      Lover lover=(Lover) lovers.get(i);
      Player player=(Player) players.get(0);
      //compare your distance to regularPolygons
      float dx = lover.xPos - player.xPos;
      float dy = lover.yPos - player.yPos;
      float distance = sqrt(dx*dx + dy*dy);

      float minDist = lover.r+player.r;
      if (distance < minDist) {
        theyLove=true;
        xPos=player.xPos;
        yPos=player.yPos;
      }else{theyLove=false;}
    }
  }

// draw the lover
  void draw() {
    stroke(255);
    fill(255);
    // face the movement direction
    float f=atan2(vy,vx);
    beginShape();
    for (float i = 0+f; i <= 2*PI+f; i+=(2*PI)/numVertices) {
      vertex(xPos+r*cos(i), yPos+r*sin(i));
    }
    endShape(CLOSE);
  }

// add new objects to the arrayList. This process is controled by a Gaussian distribution.
// this function is very similar to the one in the Polygon class
  void appear() {

    float r=(int)random(6,10);
    // numbers for deciding if output or not 
    float gr=random(1);
    // parameters of gauss bell
    float sigma=2;
    float mu=0;

    if(exist) {
      lovers.add(new Lover(random(-width/2), random(-height/2), random(10,30), int(random(2,8)),regularPolygons));
      // store the time when the object is created
      savedTime=millis();
      exist=false;
    }

    if(gr<gauss(r,sigma,mu)) {
      exist=true;
    }
  }

  float gauss(float x, float s, float u) {
    float d;

    d=exp(-(pow((x-u),2))/(2*pow(s,2)))/(sqrt(2*PI)*s);
    return d;
  }

// this function returns a boolean. "splitThem" is true if the time passed after the player came across
// the lover is greater than 8 seconds, in that case, the object is removed from the arrayList
  boolean splitCouple() {
    boolean splitThem=false;
    if(theyLove==true) {
      int passedTime = millis() - savedTime;
      if (passedTime > totalTime) {
        splitThem=true;
      }
      else {
        splitThem=false;
      }
    }
    return splitThem;
  }

// when removing the lover after the 8 seconds, all the objects are removed from the arrayList, so this function
// makes sure that there is allways one lover outside the window
  void alwaysOneInTheArrayList() {
    if(lovers.size()<1) {
      lovers.add(new Lover(width+100,height+100,10,4,regularPolygons));
    }
  }
  
  // if the player gets to put the lover into the house, then the score goes up
  void loverInTheHouse(){
    if(theyLove==true && outHouse==false){
      scoreCount+=0.03;
    }
  }
}


