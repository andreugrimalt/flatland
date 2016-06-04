class Menu {
  // x="x" position; y="y" position; r=size: w=frequency
  float x,y,r,w;
  
  boolean startGame=false;
  PFont flatland;
  
  // variables for the timer
  int savedTime;
  int totalTime = 1200;
  
  int numVertices=2;
  

  Menu(float x, float y, float r) {
    this.x=x;
    this.y=y;
    this.r=r;
    flatland = loadFont("CourierNewPSMT-60.vlw");
    textFont(flatland);
    savedTime = millis();
    
  }

// display the menu screen. There is a timer for controling when the letters and figures appear
  void draw() {
    
    background(0);
    textFont(flatland);
    int passedTime = millis() - savedTime;
    // Has five seconds passed?
    fill(255);
    text("F", width/(144.0/7.0)+width * 0.25, height*0.125);

    if (passedTime > totalTime) {
      text("L", width/12+width * 0.25, height*0.125);
    }
    if (passedTime > 2*totalTime) {
      text("A", (width)/((144.0/17.0))+width * 0.25, height*0.125);
    }
    if (passedTime > 3*totalTime) {
      text("T", width/(72.0/11.0)+width * 0.25, height*0.125);
    }
    if (passedTime > 4*totalTime) {
      text("L", width/(16.0/3.0)+width * 0.25, height/9+height*0.125);
    }
    if (passedTime > 5*totalTime) {
      text("A", width/(9.0/2.0)+width * 0.25, height/9+height*0.125);
    }
    if (passedTime > 6*totalTime) {
      text("N", width/(144.0/37.0)+width * 0.25, height/9+height*0.125);
    }
    if (passedTime > 7*totalTime) {
      text("D", width/(24.0/7.0)+width * 0.25, height/9+height*0.125);
    }
if (passedTime > 7*totalTime) {
  fill(0);
  stroke(255);

        beginShape();
    for (float i = 0; i <= 2*PI; i+=(2*PI)/numVertices) {
      vertex(width/2+(r)*cos(i), height/2+(r)*sin(i));
      
      if (passedTime > 7.8*totalTime) {
        numVertices=3;
      }
      if (passedTime > 8.8*totalTime) {
        numVertices=4;
      }
      if (passedTime > 9.8*totalTime) {
        numVertices=5;
      }
      if (passedTime > 10.8*totalTime) {
        numVertices=6;
      }
      if (passedTime > 11*totalTime) {
        numVertices=7;
      }
      if (passedTime > 11.25*totalTime) {
        numVertices=8;
      }
      if (passedTime > 11.5*totalTime) {
        numVertices=9;
      }
      if (passedTime > 11.75*totalTime) {
        numVertices=10;
      }
      if (passedTime > 12*totalTime) {
        numVertices=11;
      }
      if (passedTime > 12.5*totalTime) {
        numVertices=12;
      }
      if (passedTime > 12.75*totalTime) {
        numVertices=13;
      }
      if (passedTime > 13*totalTime) {
        numVertices=14;
      }
      if (passedTime > 13.25*totalTime) {
        numVertices=15;
      }
      if (passedTime > 13.5*totalTime) {
        numVertices=16;
      }
      if (passedTime > 13.75*totalTime) {
        numVertices=17;
      }
      if (passedTime > 14*totalTime) {
        numVertices=18;
      }
      if (passedTime > 14.25*totalTime) {
        numVertices=19;
      }
      if (passedTime > 14.5*totalTime) {
        numVertices=50;
      }

    }
    endShape(CLOSE);
}


    if (passedTime > totalTime) {
      fill(255*sin(w)*sin(w));
      w+=0.07;
      
      text("START", x-(width*(11.0/1200.0)),y-(height*(30.0/750.0)));
    }
  }

// this function returns a boolean that starts the game
  boolean activateGame() {
    if(mouseX>x-(width*(12.0/1200.0)) && mouseX<x+r+(width*(55.0/1200.0)) && mouseY>y-(height*(70.0/750.0)) 
      && mouseY<y-(height*(30.0/750.0)) && mousePressed) {
      startGame=true;
      dead=false;
      return startGame;
    }
    else {
      return startGame;
    }
  }
}


