class Boid {
  PVector pos;
  PVector vel;
  Boid() {
    float dx = random(0, width);
    float dy = random(0, height);

    pos = new PVector(dx, dy);
    vel = new PVector(random(0, 5), random(0, 5));
  }
  
  void render() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading());
    drawBoid();
    popMatrix();
  }
  
  private void drawBoid() {
    beginShape(TRIANGLES);
    vertex(5, 0);
    vertex(0, 10);
    vertex(10, 10);
    endShape();
  }
  
}