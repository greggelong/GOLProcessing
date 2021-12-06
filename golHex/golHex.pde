// arrays in processing
// declare, create array (how long is it),initalize and use
// declare name and type

// init and create
//int[][] world = new int [80][80];
//int[][] newWorld = new int[80][80];
// not really game of life on a hexagon
// just gol visualized on a hexagon
// neighobors are still calculated as the eight on a grid
// i just loop through the grid of hexagons and plot live or dead cells
// it has a nice effect but it is not truly checing neighbors
//

int [][] world;
int [][] newWorld;
int cols =80;
int rows = 80;

int sz = 10;
//int hxs= 10;
float r = sz/sqrt(3);

void setup() {
  size(800, 700);
  world = new int [cols][rows];
  newWorld = new int [cols][rows];
  background(0);
  strokeWeight(0.4);
  stroke(90);
 // stroke(0);
  //makeRndStart();
  //makeglide();
  makeRpent();
  showWorld();
  frameRate(10);
  //println(newWorld[3][2]);
}


void draw() {
  showWorld();
  update();
  if (mousePressed) {
    if (mouseX > width/2) {
      makeRndStart();
    } else {
      makeRpent();
    }
  }
}

int getNeighbors(int j, int i) {  // y and x coorodinate of the two dim array
  int sum = 0;
  for (int y = -1; y < 2; y++) {
    for (int x = -1; x < 2; x++) {
      int col = (x + i + cols) % cols;
      int row = (y + j + rows) % rows;
      sum += world[row][col];
    }
  }
  sum -= world[j][i];
  return sum;
}



void update() {

  for (int j=0; j< world.length; j++) {  // row or y    
    for (int i=0; i< world[j].length; i++) { // column or x   
      int neigh = getNeighbors(j, i); // start with more or less random parts
      if (world[j][i] == 1 && neigh == 2 || world[j][i] == 1 && neigh ==3 ) {     // keeps living
        newWorld[j][i] = 1;
      } else if (world[j][i] == 0 && neigh == 3) {    // comes to life
        newWorld[j][i] = 1;
      } else {
        newWorld[j][i] = 0;  // else zero
      }
    }
  }

  // arrayCopy(newWorld,world); this does not work  need to manually copy the array

  for (int j=0; j< world.length; j++) {  //  
    for (int i=0; i< world[j].length; i++) {
      world[j][i] = newWorld[j][i];
    }
  }
}


void makeRndStart() {
  int perChance = int(random(3, 10));
  for (int j=0; j< world.length; j++) {  // row or y
    for (int i=0; i< world[j].length; i++) { // column or x
      int state = int(random(perChance)); // start with more or less random parts
      //println(state);
      if (state == 1) {
        world[j][i] = 1;
      } else {
        world[j][i] = 0;
      }
    }
  }
}

void makeglide() {

  // glider
  world[38][42] =1;
  world[39][43] =1;
  world[40][41] =1;
  world[40][42]=1;
  world[40][43]=1;
}


void makeRpent() {
  // clears it
 for (int j=0; j< world.length; j++) {  // row or y
    for (int i=0; i< world[j].length; i++) { // column or x
       world[j][i] = 0;
    }
  }
  int offset = floor(random(-5,5));
  // rpent
  world[42][38-offset] =1;
  world[43][38-offset] =1;
  world[41][38-offset] =1;
  world[42][37-offset]=1;
  world[41][39-offset]=1;
 
  // smaller
 //  world[22][18-offset] =1;
//  world[23][18-offset] =1;
//  world[21][18-offset] =1;
//  world[22][17-offset]=1;
 // world[21][19-offset]=1;
}



void showWorld() {
 
  color clr;
  for (int j=0; j< world.length; j++) {  // row or y
    for (int i=0; i< world[j].length; i++) { // column or x
      if (world[j][i] == 1) {
       clr = color(255, 255, 0);
      } else {
       clr = color(0);
      }
      if (j%2 == 0){
       // offset
      hexagon(i*r*sqrt(3)-r/2*sqrt(3),j*r*1.5,r,clr);
     }else{
       
      // normal spacing
      hexagon(i*r*sqrt(3),j*r*1.5,r,clr);
   }
    }
  }
}


//hexagon

void hexagon(float sx, float sy, float len, color clr){
  fill(clr);
  int outangle = 60;
  beginShape();
  // was 0 to 360 but the orientation was wrong
  // 90 to 510 0r 450 with close shape
  for (int a =90; a < 450; a+= outangle){
   float x = len * cos(radians(a))+ sx;
   float y = len * sin(radians(a))+ sy;
   vertex(x,y);
    
  }
  endShape(CLOSE);
 
}
