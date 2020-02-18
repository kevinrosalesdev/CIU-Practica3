class Controller{
  
  ArrayList<MySphere> sphereList;
  
  Controller(){
    sphereList = new ArrayList<MySphere>();
  }
  
  void createSpheres(){
    sphereList.add(new MySphere(75.0, null, 0, 0, 0.05));
    sphereList.add(new MySphere(20.0, null, 0.8, 0.4, 0.1));
    sphereList.add(new MySphere(40.0, null, -0.6, 0.4, 0.4));
    sphereList.add(new MySphere(30.0, null, -0.5, -0.5, 0.6));
  }
  
  void drawAllSpheres(){
    for(MySphere sphere: sphereList){
      println("Dibujando esfera con radio ", sphere.radius, " situado en ", sphere.translateX, " y ", sphere.translateY); 
      updateRotation(sphere);
      drawSphere(sphere);
    }
  }
  
    
  void drawSphere(MySphere sphere){
    pushMatrix();
    rotateX(radians(sphere.rotationX));
    rotateY(radians(sphere.rotationY));
    translate(sphere.translateX, sphere.translateY, 0);
    sphere(sphere.radius);
    popMatrix();
  }
  
  void updateRotation(MySphere sphere){
    sphere.rotationY += sphere.drotationY;
    if(sphere.rotationY > 360) sphere.rotationY = 0;
    rotateY(radians(sphere.rotationX));
  }  
}
