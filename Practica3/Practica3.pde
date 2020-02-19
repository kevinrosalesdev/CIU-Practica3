Controller controller;

void setup(){
  size(800, 700, P3D);
  noStroke();
  controller = new Controller();
  controller.createPlanets();
  controller.createMoons();
}

void draw(){
  controller.setBackground();
  translate(width/2, height/2, -100);
  rotateX(radians(-45));
  
  controller.drawSun();
  controller.drawAllPlanets();
  controller.drawAllMoons();
}
