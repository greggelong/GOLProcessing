// arrays in processing
// declare, create array (how long is it),initalize and use
// declae name and type

// init and create
int[][] world = new int [80][80];
int[][] newWorld = new int[80][80];


float sz = 10;

void setup() {
  size(800, 800);
  background(255);
  makeRndStart();
  //makeglide();
  showWorld();
  frameRate(10);
  println(newWorld[3][2]);
}


void draw() {
  showWorld();
  update();
  if(mousePressed){
    makeRndStart();
  }
}

int getNeighbors(int j, int i) {  // y and x coorodinate of the two dim array
  int total =0;
  total += world[j-1][i-1];
  total += world[j-1][i];
  total += world[j-1][i+1];
  total += world[j][i-1]; // skip out 0,0
  total += world[j][i+1];
  total += world[j+1][i-1];
  total += world[j+1][i];
  total += world[j+1][i+1];

  return total;
}


void update() {

  for (int j=1; j< world.length-1; j++) {  // row or y   ignore edge
    for (int i=1; i< world[j].length-1; i++) { // column or x  ignore edge
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

  // arrayCopy(newWorld,world); this does not work

  for (int j=0; j< world.length; j++) {  // row or y   ignore edge
    for (int i=1; i< world[j].length; i++) {
      world[j][i] = newWorld[j][i];
    }
  }
}


void makeRndStart() {
  int perChance = int(random(3,10));
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

  world[5][5] =1;
  world[5][6]=1;
  world[5][7]=1;
}

void showWorld() {
  for (int j=0; j< world.length; j++) {  // row or y
    for (int i=0; i< world[j].length; i++) { // column or x
      if (world[j][i] == 1) {
        fill(0,255,0);
      } else {
        fill(0);
      }
      rect(i*sz, j*sz, sz, sz); // sz maps to display
    }
  }
}
