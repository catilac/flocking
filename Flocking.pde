int NUM_BOIDS = 800;
float NEIGHBORHOOD_RADIUS = 200.0;
float COHESION_WEIGHT = 0.15;
float SEPARATION_WEIGHT = 0.25;
float ALIGNMENT_WEIGHT = 0.25;

Boid[] boids = new Boid[NUM_BOIDS];

void setup() {
  fullScreen(P3D);
  initializeBoids();
}

void draw() {
  background(255);
  updateBoids();
  
}

void initializeBoids() {
  for (int i = 0; i < NUM_BOIDS; i++) {
    boids[i] = new Boid();
  }
}

void updateBoids() {
  for (int i = 0; i < NUM_BOIDS; i++) {
    Boid currBoid = boids[i];
    ArrayList<Boid> neighbors = getNeighbors(currBoid);
    
    PVector v1 = calculateCohesion(currBoid, neighbors);
    PVector v2 = calculateSeparation(currBoid, neighbors);
    PVector v3 = calculateAlignment(currBoid, neighbors);
    PVector v4 = boundToScreen(currBoid);
    
    // Apply  Weights
    v1.mult(COHESION_WEIGHT);
    v2.mult(SEPARATION_WEIGHT);
    v3.mult(ALIGNMENT_WEIGHT);
    
    currBoid.vel.add(v1);
    currBoid.vel.add(v2);
    currBoid.vel.add(v3);
    currBoid.vel.add(v4);
    
    currBoid.vel.normalize();
    currBoid.vel.mult(5);
    
    currBoid.pos.add(currBoid.vel);
    
    currBoid.render();
  }
}

ArrayList<Boid> getNeighbors(Boid b) {
  ArrayList<Boid> neighbors = new ArrayList<Boid>();  
  for (int i = 0; i < NUM_BOIDS; i++) {
    Boid boid = boids[i];
    if (b != boid && PVector.dist(b.pos, boid.pos) < NEIGHBORHOOD_RADIUS) {
      neighbors.add(boid);
    }
  }
  
  return neighbors;
}

PVector calculateCohesion(Boid b, ArrayList<Boid> neighbors) {
  PVector pc = new PVector(0, 0); // perceivedCenter
  if (neighbors.size() == 0) { return pc; }
  
  for (int i = 0; i < neighbors.size(); i++) {
    Boid boid = neighbors.get(i);
    pc.add(boid.pos);
  }
  pc.div(neighbors.size());
  pc.sub(b.pos).normalize();
  return pc;
}

PVector calculateSeparation(Boid b, ArrayList<Boid> neighbors) {
  PVector v = new PVector(0, 0);
  if (neighbors.size() == 0) { return v; }
  
  for (int i = 0; i < neighbors.size(); i++) {
    Boid boid = neighbors.get(i);
    v.add(PVector.sub(boid.pos, b.pos));
  }
  v.mult(-1);
  v.normalize();
  return v;
}

PVector calculateAlignment(Boid b, ArrayList<Boid> neighbors) {
  PVector pv = new PVector(0, 0); // Perceived Velocity
  if (neighbors.size() == 0) { return pv; }
  for (int i = 0; i < neighbors.size(); i++) {
    Boid boid = neighbors.get(i);
    pv.add(boid.vel);
  }
  
  pv.div(neighbors.size());
  pv.normalize();
  return pv;
}

PVector boundToScreen(Boid b) {
  PVector v = new PVector(0, 0);
  final float speed = 10;
  
  if (b.pos.x < 0) { v.x = speed; }
  else if (b.pos.x > width) { v.x = -speed; }
  
  if (b.pos.y < 0) { v.y = speed; }
  else if (b.pos.y > height) { v.y = -speed; }
  
  if (b.pos.z < 0) { v.z = speed; }
  else if (b.pos.z > height/2) { v.z = -speed; }
  
  return v;
}