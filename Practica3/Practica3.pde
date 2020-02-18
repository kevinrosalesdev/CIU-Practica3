//float ang, angS;

//void setup(){
//  size(500,500,P3D);
//  stroke(0);
//  fill(255);
//  ang = 0;
//  angS = 0;
//}

//void draw(){
//  background(200);
  
//  translate(width/2, height/2, 0);
//  rotateX(radians(-45));
  
//  pushMatrix();
//  rotateY(radians(ang));
//  sphere(100);
//  popMatrix();
  
//  ang+=0.25;
//  if(ang >= 360) ang = 0;
  
//  //translate(-width*0.25, 0, 0);
//  //box(10);
  
//  pushMatrix();
//  rotateY(-radians(angS));
//  translate(-width*0.25,0,0);
//  box(10);
//  popMatrix();
  
//  angS+=0.25;
//  if (angS < -360) angS = 0;
//}

Controller controller;

void setup(){
  size(750, 600, P3D);
  stroke(0);
  controller = new Controller();
  controller.createSpheres();
}

void draw(){
  background(200);
  translate(width/2, height/2, 0);
  rotateX(radians(-45));
  
  controller.drawAllSpheres();
}
