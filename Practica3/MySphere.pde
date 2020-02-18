class MySphere{
  
  float radius, translateX, translateY, rotationY, rotationX, drotationY;
  PImage texture;
  
  MySphere(float radius, PImage texture, float translateX, float translateY, float drotationY){
    this.radius = radius;
    this.texture = texture;
    this.translateX = width/2*translateX;
    this.translateY = height/2*translateY;
    this.rotationY = 0;
    this.rotationX = 20;
    this.drotationY = drotationY;
  }

}
