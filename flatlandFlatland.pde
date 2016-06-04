AudioThread audioThread;
// store the audio data from the audio file
float[] audioData;
float[] audioData2;
float[] audioData3;
float[] audioData4;
float[] audioData5;
// remember the position in the audio data array
int readHead;
int readHead2;
int readHead3;
int readHead4;
int readHead5;

// these arrayList contain all the different objects
ArrayList regularPolygons, irregularPolygons, players, houses, soldiers, coins, killerCircles, monoliths, lovers;

// create a score object and a global variable that will store the score
Score score;
float scoreCount;

// create the menu object (gui) 
Menu menu;

// background is black
int backgroundc=0;

// global variable: it's true when the player is outside the house and false if not.
boolean outHouse=true;

// global variable: it's true if the player is and false if alive.
boolean dead=false;

// MoneyFound should be local a variable!! It's true when a coin is founded
boolean moneyFound=false;

// PlayItMoney should be local a variable!! 
// it's true if moneyFound is true. It remains true until the end of the audio sample
boolean playItMoney=false;

// PlayItMoney2 should be local a variable!! It has the same function as PlayItMoney and
// activates a different audio sample. 
boolean playItMoney2=false;

// Global variable: It plays audio when the menu screen is active
boolean playItMenu=true;

// Global variable: It determines how fast the particles approach to the player, higher number = slow
float force=40000;

void setup() {
size(1200,750);

  // initial number of regularPolygons, soldiers and coins
  int initialNumberOfRegularPolygons=8;
  int initialNumberOfSoldiers=10;
  int initialNumberOfCoins=3;
  

  // audio files, they are in the data directory
  String audioFilename = "kick.wav";
  String audioFilename2 = "menu.wav";
  String audioFilename3 = "game.wav";
  String audioFilename4 = "solaris.wav";
  String audioFilename5 = "bell.wav";
  // read the audio data into float arrays using the AudioFileIn class
  audioData = new AudioFileIn(audioFilename, this).getSampleData();
  audioData2 = new AudioFileIn(audioFilename2, this).getSampleData();
  audioData3 = new AudioFileIn(audioFilename3, this).getSampleData();
  audioData4 = new AudioFileIn(audioFilename4, this).getSampleData();
  audioData5 = new AudioFileIn(audioFilename5, this).getSampleData();

  // start up the audio thread
  audioThread = new AudioThread();
  audioThread.start();

  // create all the arrayLists
  regularPolygons = new ArrayList();
  irregularPolygons = new ArrayList();
  players=new ArrayList();
  houses=new ArrayList();
  soldiers=new ArrayList();
  coins=new ArrayList();
  killerCircles=new ArrayList();
  monoliths=new ArrayList(); 
  lovers=new ArrayList();

  // create the score object and initialize it to 0
  score=new Score(0);

  // create the menu 
  menu=new Menu(width/2-(width/16.0),height-(height*5/43.0),(width*height/8256.0));

  // add one play and one house into the correspondent arrayList
  players.add(new Player(0,height/2-(height*(100.0/750.0)),10,4,regularPolygons));
  houses.add(new House(0,height/2-(height*(100.0/750.0)),60,5,regularPolygons));

  // add a circle that kills everybody to its arrayList
  killerCircles.add(new Killer(random(-width/2,width/2), random(-height/2), random(30,40), int(random(2,13)),regularPolygons));

  // add a monolith, a lover and a irregularPolygon outside the window, it's a guarantie that there will be always at least
  // one of these objects in their arrayList. This is important as the functions relating to these objects are 
  // called insed loops that depend on the arrayList size. If the arrayList size is 0, then the functions are
  // not called
  monoliths.add(new Monolith(width+100,height+100,10,4,regularPolygons));
  lovers.add(new Lover(width+100,height+100,10,4,regularPolygons));
  irregularPolygons.add(new IrregularPolygon(width+100,height+100,10,4,regularPolygons));

  // create 13 coins outside the window = there will always be at least 13 coins in the arrayList
  for(int i=1; i<14; i++) {
    coins.add(new Money(width+110+i,height+110+i,10,4,regularPolygons));
  }

  // create the initial polygons, soldiers and coins
  for(int i=0;i<initialNumberOfCoins;i++) {
    coins.add(new Money(random(-width/2+40,width/2-40),random(-height/2+40),10,4,regularPolygons));
  }

  for (int i =0 ; i < (initialNumberOfRegularPolygons); i++) {
    regularPolygons.add(new Polygon(random(-width/2), random(-height/2), random(10,30), int(random(2,13)),regularPolygons));
  }

  for (int i =0 ; i < (initialNumberOfSoldiers); i++) {
    soldiers.add(new Soldier(random(-width/2), random(-height/2), random(5,25), int(random(2,8)),regularPolygons));
  }
}

void draw() {

  smooth();

  // draw the menu screen
  menu.draw();

  // if statement that determines if the game should start or not
  if(menu.activateGame()&&dead==false) {
    // the game starts
    background(backgroundc);
    backgroundc=(int)score.getScore();
    // obtain each element in the arrayList, cast it as a Polygon object inside a variable
    // called regularPolygon and call the functions related. A detailed comment of each function can 
    // be found inside the Polygon class
    for(int i=0; i<regularPolygons.size(); i++) {
      Polygon regularPolygon = (Polygon) regularPolygons.get(i);
      regularPolygon.appear();
      regularPolygon.draw();    
      regularPolygon.move();
      regularPolygon.bounce();
      regularPolygon.colision();
      regularPolygon.death();
      regularPolygon.killSoldier();
      regularPolygon.killIrregularPolygons();

      // if there isn't a monolyth in the screen and the player is outside the house, 
      // the regularPolygons are attracted by the player
      if(outHouse==true||monoliths.size()>1) {
        regularPolygon.atraction();
      }
    }
    
    for(int i=0; i<irregularPolygons.size(); i++) {
      IrregularPolygon irregularPolygon = (IrregularPolygon) irregularPolygons.get(i);
      irregularPolygon.draw();
      
      irregularPolygon.move();
      
      irregularPolygon.bounce();
      irregularPolygon.colision();
      irregularPolygon.appear();
    }


    // same process as above. In this case there is only one element in the arrayList which is a house.
    for(int i=0; i<houses.size();i++) {
      House house = (House) houses.get(i);
      house.draw();
      house.outHouse();
    }

    // obtain each element in the arrayList, cast it as a player object inside a variable
    // called player and call the functions related. A detailed comment of each function can 
    // be found inside the Player class
    for(int i=0; i<players.size();i++) {
      Player player = (Player) players.get(i);
      player.draw();
      player.colision();
      player.updatePlayer();
      player.killIrregularPolygons();
    }


    // obtain each element in the arrayList, cast it as a Soldier object inside a variable
    // called soldier and call the functions related. A detailed comment of each function can 
    // be found inside the Soldier class
    for(int i=0; i<soldiers.size(); i++) {
      Soldier soldier = (Soldier) soldiers.get(i);
      soldier.draw();
      soldier.move();
      soldier.bounce();
      soldier.colision();
      soldier.death();

      // if there isn't a monolyth in the screen and the player is outside the house, 
      // the soldiers are attracted by the player
      if(outHouse==true||monoliths.size()>1) {
        soldier.atraction();
      }
      soldier.appear();
      soldier.killregularPolygons();
      soldier.killIrregularPolygons();
    }

    // obtain each element in the arrayList, cast it as a Money object inside a variable
    // called coin and call the functions related. A detailed comment of each function can 
    // be found inside the Money class
    for(int i=0; i<coins.size();i++) {
      Money coin=(Money) coins.get(i);
      coin.draw();
      coin.appear();
      coin.colision();

      // if the player founds a coin then remove that coin from the arrayList
      if(moneyFound) {
        coins.remove(i);
      }

      // carry the score count
      score.carryCount();
      // print the score
      score.printScore();
    }

    // obtain each element in the arrayList, cast it as a Killer object inside a variable
    // called killerCircle and call the functions related. A detailed comment of each function can 
    // be found inside the Killer class
    for(int i=0; i<killerCircles.size();i++) {
      Killer killerCircle=(Killer) killerCircles.get(i);
      killerCircle.draw();
      killerCircle.move();
      killerCircle.colision();
      killerCircle.kill();
      // if there isn't a monolyth in the screen and the player is outside the house, 
      // the regularPolygons are attracted by the player
      if(outHouse==true||monoliths.size()>1) {
        killerCircle.atraction();
      }
      killerCircle.bounce();
      killerCircle.appear();
    }

    // obtain each element in the arrayList, cast it as a Monolith object inside a variable
    // called monolith and call the functions related. A detailed comment of each function can 
    // be found inside the Monolith class
    for(int i=0; i<monoliths.size(); i++) {
      Monolith monolith = (Monolith) monoliths.get(i);
      monolith.draw();
      monolith.appear();    

      // if regularPolygon, soldier or killerCircle come across the monolith, then remove that monolith
      if(monolith.polygonFoundMonolith() || monolith.killerCircleFoundMonolith() 
      || monolith.soldiersFoundMonolith() || monolith.playerFoundMonolith()) {
        monoliths.remove(i);
      }
      monolith.colision();
    }

    // obtain each element in the arrayList, cast it as a Lover object inside a variable
    // called lover and call the functions related. A detailed comment of each function can 
    // be found inside the Lover class
    for(int i=0; i<lovers.size(); i++) {
      Lover lover=(Lover) lovers.get(i);
      lover.draw();
      lover.colision();
      lover.love();
      // if there isn't any lover in the screen, then call the appear function. Remember that there is one
      // lover object outside the window
      if(lovers.size()<2) {
        lover.appear();
      }

      // if the time after the player has come the lover is bigger than 8 seconds, then remove the lover.
      // This removes all the lover objects in the lovers arrayList 
      if(lover.splitCouple()) {
        lovers.remove(i);
      }

      // creates a lover outside the window so the lovers arrayList size is always 1
      lover.alwaysOneInTheArrayList();

      // if the lover is inside the house and the player has come across it, then sum points to the score
      lover.loverInTheHouse();
    }

    //If dead, then reset the game
    if(dead==true) {

      // leave 4 regularPolygons in the arrayList, remove all others
      for(int i=5; i<regularPolygons.size(); i++) {
        Polygon regularPolygon = (Polygon) regularPolygons.get(i);
        regularPolygons.remove(i);
      }

      // leave 4 soldiers in the arrayList, remove all others
      for(int i=5; i<soldiers.size(); i++) {
        Soldier soldier = (Soldier) soldiers.get(i);
        soldiers.remove(i);
      }

      // leave 13 coins in the arrayList (the ones outside the window), remove all others
      for(int i=14; i<coins.size(); i++) {
        Money coin = (Money) coins.get(i);
        coins.remove(i);
      }
    }
  }

  // if the player come across a coin, the play the audio files
  if(moneyFound) {

    // first sound
    playItMoney=true;
    // second sound
    playItMoney2=true;
  }

  // play the music for the menu screen
  if(menu.activateGame()==false) {
    playItMenu=true;
  }
  else {
    playItMenu=false;
  }
}


// this function gets called when you press the escape key in the sketch
void stop() {
  // tell the audio to stop
  audioThread.quit();
  // call the version of stop defined in our parent class, in case it does anything vital
  super.stop();
}


// this gets called by the audio thread when it wants some audio
// we should fill the sent buffer with the audio we want to send to the 
// audio output

void generateAudioOut(float[] buffer) {
  for (int i=0;i<buffer.length; i++) {
    // copy data from the audio we read from the file
    // into the buffer that gets sent to the sound card

    // audio for the menu screen
    if(playItMenu==true) {
      buffer[i] = 0.5*audioData2[(int)readHead2];
      readHead2=(readHead2+2) % audioData2.length;
    }
    else {
      readHead2=0;
    }

    // audio for the game when the score is under 20
    if(playItMenu==false&&scoreCount<20) {
      buffer[i] = 0.5*(audioData3[(int)readHead3]+audioData[(int)readHead]);
      readHead3=(readHead3+1+(int)scoreCount%20) % audioData3.length;
      if(playItMoney==true) {
        readHead = (readHead + 1);
      }
    }
    else {
      readHead3=0;
    }
    // play the audio once when a coin is found. playItMoney should be a local variable, this is why this if
    // statement doesn't always work
    if(readHead==audioData.length-10) {
      readHead=0;
      playItMoney=false;
    }

    // audio for the game when the score is over 20
    if(playItMenu==false&&scoreCount>=20) {
      buffer[i] = 0.5*(audioData4[(int)readHead4]+audioData5[(int)readHead5]);
      readHead4=(readHead4+2) % audioData4.length;
      if(playItMoney2==true) {
        readHead5 = (readHead5 + 1);
      }
    }
    else {
      readHead4=0;
    }

    // play the audio once when a coin is found. playItMoney2 should be a local variable, this is why this if
    // statement doesn't always work
    if(readHead5==audioData5.length-20) {
      readHead5=0;
      playItMoney2=false;
    }
  }
}


