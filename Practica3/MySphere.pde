class MySphere{
  
  PShape sphereShape;
  float rotationY, translateX, translateY, drotationY;
  
  MySphere(float radius, PImage texture, float translateX, float translateY, float drotationY){
    this.sphereShape = createShape(SPHERE, radius);
    sphereShape.setTexture(texture);
    this.rotationY = 0;
    this.translateX = width/2*translateX;
    this.translateY = height/2*translateY;
    this.drotationY = drotationY;
  }

}
