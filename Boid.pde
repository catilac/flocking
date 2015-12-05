class Boid {
  PVector pos;
  PVector vel;
  
  Boid() {
    float dx = random(0, width);
    float dy = random(0, height);
    float dz = random(0, height/2);

    pos = new PVector(dx, dy, dz);
    vel = new PVector(random(0, 5), random(0, 5));
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotate(vel.heading());
    drawBoid();
    popMatrix();
  }
  
  private void drawBoid() {
    box(5.0);
  }
  
}