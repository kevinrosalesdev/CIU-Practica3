class MyShip{
  
  PShape model;
  float rotationZ, drotationZ;
  
  MyShip(PShape model, PImage texture, float drotationZ){
    this.model = model;
    model.setTexture(texture);
    this.drotationZ = drotationZ;
    this.rotationZ = 0;
  }
  
}
