PImage bgtexture;
PImage title;
PImage classic;
PImage choosePartyType;
PImage lipsTitle;
PImage lipsBig;

PImage adult;
PImage college;
PImage highSchool;
PImage pressToSpin;
PImage spinAgain;
PImage chooseDifferentParty;

PImage millerLite;
PImage smirnoff;
PImage wine;

PFont helvetica;

int appState = 0;
int partyType = 0;

// locations of the various buttons
float adultX;
float adultY;
float collegeX;
float collegeY;
float highSchoolX;
float highSchoolY;
float buttonY;

float pressToSpinY;
float spinAgainY;
float chooseDifferentY;

// variables for fading instructions
boolean fading = false;
int fadeTime = 0;
int opacity = 255;
int fadeInterval = 5000;


void setup() {
  size(displayWidth, displayHeight);
  noStroke();

  // load all the images
  bgtexture = loadImage("bg_texture.png");
  title = loadImage("title.png");
  classic = loadImage("classic.png");
  choosePartyType = loadImage("choose_party_type.png");
  lipsTitle = loadImage("lips_title_page.png");
  lipsBig = loadImage("lips.png");

  adult = loadImage("adult.png");
  college = loadImage("college.png");
  highSchool = loadImage("high_school.png");

  pressToSpin = loadImage("press_to_spin.png");
  spinAgain = loadImage("spin_again.png");
  chooseDifferentParty = loadImage("choose_another.png");

  millerLite = loadImage("miller_lite.png");
  smirnoff = loadImage("smirnoff.png");
  wine = loadImage("wine.png");

  helvetica = createFont("Helvetica-Bold", 16);
  textFont(helvetica);

  adultX = width * 0.25;
  collegeX = width * 0.5;
  highSchoolX = width * 0.75;
  buttonY = height * 0.85;

  pressToSpinY = height * 0.8;
  spinAgainY = height * 0.3;
  chooseDifferentY = height* 0.7;

  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  orientation(PORTRAIT);
  fill(255, 255, 255, 100);
}

void draw() {
  // println(appState);

  background(34, 28, 91);  
  image(bgtexture, width * 0.5, height * 0.5);


  // title screen
  if (appState == 0) {
    image(title, width * 0.5, height * 0.2);
    image(classic, width * 0.5, height * 0.35);
    image(lipsTitle, width * 0.5, height * 0.55);
    displayThreePartyButtons();
    image(choosePartyType, width * 0.5, height * 0.97);
  }

  // click to spin
  if (appState == 1) {
    displayBottle();
    image(pressToSpin, width * 0.5, pressToSpinY);
  }

  // spin round; instructions fade; can click anywhere to end
  if (appState == 2) {
    displayBottle();
    if (partyType == 2){
      fill(0,0,0, opacity);
      rect(width * 0.5, height * 0.9, width * 0.95, height * 0.15);
    }
    fill(255, 255, 255, opacity);
    text("Lay device on a smooth surface and spin.\nPlay Spin-the-Bottle.\nPress anywhere when finished.", width * 0.5, height * 0.9);
    if (fading && millis() - fadeTime > fadeInterval && opacity > -3) {
      opacity-=3;
    }
  }

  // choice of spinning again or picking different party
  if (appState == 3) {
    image(spinAgain, width * 0.5, spinAgainY);
    image(chooseDifferentParty, width * 0.5, chooseDifferentY);
  }

  // non-title screen to pick a different party
  if (appState == 4) {
    image(lipsBig, width * 0.5, height * 0.4);
    displayThreePartyButtons();
  }
}

void mousePressed() {

  // title screen and non-title screen for choosing three parties
  if (appState==0 || appState == 4) {
    chooseAmongThreeButtons();
  }

  // clicking to start
  else if (appState == 1 && mouseX > width * 0.5 - pressToSpin.width * 0.5 && mouseX < width * 0.5 + pressToSpin.width * 0.5 && mouseY > pressToSpinY - pressToSpin.height * 0.5 && mouseY < pressToSpinY + pressToSpin.height * 0.5) {
    fading = true;
    fadeTime = millis();
    opacity = 255;
    appState = 2;
  }

  // spin round; instructions fade; can click anywhere to end
  else if (appState == 2) {
    fill(255, 255, 255, 100);
    appState = 3;
  }

  // choice of spinning again or picking different party
  else if (appState == 3) {
    if (mouseX > width * 0.5 - spinAgain.width * 0.5 && mouseX < width * 0.5 + spinAgain.width) {
      if (mouseY > spinAgainY - spinAgain.height * 0.5 && mouseY < spinAgainY + spinAgain.height * 0.5) {
        appState = 1;
      }
      if (mouseY > chooseDifferentY - chooseDifferentParty.height * 0.5 && mouseY < chooseDifferentY + chooseDifferentParty.height * 0.5) {
        appState = 4;
      }
    }
  }
}

void displayThreePartyButtons() {
  image(adult, adultX, buttonY);
  image(college, collegeX, buttonY);
  image(highSchool, highSchoolX, buttonY);
}

void chooseAmongThreeButtons() {
  if (mouseY > buttonY - adult.height * 0.5 && mouseY < buttonY + adult.height * 0.5) {
    // clicking "adult" button
    if (mouseX > adultX - adult.width * 0.5 && mouseX < adultX + adult.width * 0.5) {
      partyType = 1;
      appState = 1;
    }

    // clicking "college" button
    if (mouseX > collegeX - college.width * 0.5 && mouseX < collegeX + college.width * 0.5) {
      partyType = 2;
      appState = 1;
    }

    // clicking "high school" button
    if (mouseX > highSchoolX - highSchool.width * 0.5 && mouseX < highSchoolX + highSchool.width * 0.5) {
      partyType = 3;
      appState = 1;
    }
  }
}

void displayBottle() {
  if (partyType == 1) {
    image(wine, width * 0.5, height * 0.5);
  } 
  else if (partyType == 2) {
    image(smirnoff, width * 0.5, height * 0.5);
  } 
  else if (partyType == 3) {
    image(millerLite, width * 0.5, height * 0.5);
  }
}

