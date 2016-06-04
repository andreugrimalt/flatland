class Score {
  
  PFont scores, highScores;

// initializes the score count
  Score(int initialScore) {
    scoreCount=initialScore;
    scores = loadFont("CourierNewPSMT-60.vlw");
    highScores = loadFont("CourierNewPSMT-40.vlw");
    textFont(scores);
  }
  
  // carries the score count
  void carryCount() {
    if(moneyFound) {
      scoreCount+=1;
      
// everytime the score is a multiple of 5, the force is multiplied by 0.9 and therefore the objects move faster
      if(scoreCount % 5 == 0) {
        force=0.9*force;
      }
    }
    // if the player is dead, then initialize "force" and "scoreCount"
    if(dead){
      scoreCount=0;
      force=40000;
    }
  }
  
  // print the score. In order to make it look nice, the position of the text changes as the number
  // of digits increases
  void printScore() {
    fill(255);
    
    if(scoreCount<10){
      textFont(scores);
      
    text(""+(int)scoreCount, width/2-(width*(18.0/1200.0)),height/2+(height*(300.0/750.0)));
    }
    if(scoreCount>=10&&scoreCount<100){
      textFont(scores);
    text(""+(int)scoreCount, width/2-(width*(35.0/1200.0)),height/2+(height*(300.0/750.0)));
    }
    if(scoreCount>=100){
      textFont(highScores);
    text(""+(int)scoreCount, width/2-(width*(35.0/1200.0)),height/2+(height*(300.0/750.0)));
    }
  }
  
  // returns the "scoreCount" value
  float getScore(){
    return scoreCount;
  }
}
    


