class Controller{
  
  MySphere sun;
  ArrayList<MySphere> planetList;
  ArrayList<MySphere> moonList;
  
  Controller(){
    sun = new MySphere(75.0, loadImage("sun/2k_sun-compressor.jpg"), 0, 0, 0.1);
    planetList = new ArrayList<MySphere>();
    moonList = new ArrayList<MySphere>();
  }
  
  void createPlanets(){
    planetList.add(new MySphere(15.0, loadImage("planets/Volcanic-compressor.png"), -0.3, 0.1, 1));
    planetList.add(new MySphere(10.0, loadImage("planets/Martian-compressor.png"), 0.4, 0, -0.9));
    planetList.add(new MySphere(10.0, loadImage("planets/Alpine-compressor.png"), 0.5, 0.2, 0.8));
    planetList.add(new MySphere(13.0, loadImage("planets/Savannah-compressor.png"), 0.625, -0.05, 0.7));
    planetList.add(new MySphere(25.0, loadImage("planets/2k_blue-compressor.jpg"), -0.7, -0.1, -0.6));
    planetList.add(new MySphere(20.0, loadImage("planets/Icy-compressor.png"), -0.8, 0.2, 0.4));
    planetList.add(new MySphere(8.0, loadImage("planets/Swamp-compressor.png"), 0.9, -0, 0.25));
    planetList.add(new MySphere(12.5, loadImage("planets/Tropical-compressor.png"), 0.9, -0.2, -0.25));
  }
  
  void createMoons(){
    moonList.add(new MySphere(1.5, loadImage("moons/2k_moon-compressor.jpg"), 0.05, -0.075, 2));
    moonList.add(new MySphere(5.0, loadImage("moons/Venusian-compressor.png"), -0.04, -0.05, 3));
    moonList.add(new MySphere(2.5, loadImage("moons/2k_ceres_fictional-compressor.jpg"), -0.055, 0, 5));
    moonList.add(new MySphere(7.5, loadImage("moons/2k_makemake_fictional-compressor.jpg"), -0.085, 0, 6));
  }
  
  void drawSun(){
    updateRotation(sun);
    drawSphere(sun);
  }
  
  void drawAllPlanets(){
    for(MySphere planet: planetList){
      updateRotation(planet);
      drawSphere(planet);
    }
  }
  
  void drawAllMoons(){
    for(MySphere moon: moonList){
      updateRotation(moon);
    }
    
    drawMoon(planetList.get(0), moonList.get(0));
    drawMoon(planetList.get(0), moonList.get(1));
    drawMoon(planetList.get(2), moonList.get(2));
    drawMoon(planetList.get(4), moonList.get(3));
  }
    
  void drawSphere(MySphere sphere){
    pushMatrix();
    rotateY(radians(sphere.rotationY));
    translate(sphere.translateX, sphere.translateY, 0);
    shape(sphere.sphereShape);
    popMatrix();
  }
  
  void drawMoon(MySphere planet, MySphere moon){
    pushMatrix();
    rotateY(radians(planet.rotationY));
    translate(planet.translateX, planet.translateY, 0);
    
    pushMatrix();
    rotateY(radians(moon.rotationY));
    translate(moon.translateX, moon.translateY, 0);
    shape(moon.sphereShape);
    popMatrix();
    
    popMatrix();
  }
  
  void updateRotation(MySphere sphere){
    sphere.rotationY += sphere.drotationY;
    if(sphere.rotationY > 360) sphere.rotationY = 0;
    else if (sphere.rotationY < -360) sphere.rotationY = 0;
  }
  
  void setBackground(){
    background(loadImage("background/background.jpg"));
  }
}
