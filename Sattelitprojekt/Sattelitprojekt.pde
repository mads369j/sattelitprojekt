// 3D Earthquake Data Visualization
// The Coding Train / Daniel Shiffman
// https://thecodingtrain.com/CodingChallenges/058-earthquakeviz3d.html
// https://youtu.be/dbs4IYGfAXc
// https://editor.p5js.org/codingtrain/sketches/tttPKxZi

float x;
float y;
float z;

float angle;

Table table;
float r = 200;

PImage earth;
PShape globe;

void setup() {
  size(600, 600, P3D);
  earth = loadImage("earth.jpg");

  noStroke();
  globe = createShape(SPHERE, r);
  globe.setTexture(earth);

  JSONObject j = loadJSONObject("https://api.n2yo.com/rest/v1/satellite/positions/25544/41.702/-76.014/0/2/&apiKey=GUEEAL-Z7MBKJ-CPLJWD-4SOY");
  JSONArray positionsJson = j.getJSONArray("positions");


  JSONObject pos1 = positionsJson.getJSONObject(0);
  JSONObject pos2 = positionsJson.getJSONObject(1);

  float sat1Lon = pos1.getFloat("satlongitude");
  float sat1Lat = pos1.getFloat("satlatitude");

  float sat2Lon = pos2.getFloat("satlongitude");
  float sat2Lat = pos2.getFloat("satlatitude");

  println(sat1Lon, sat1Lat);
  println(sat2Lon, sat2Lat);

  float theta = radians(sat1Lat);
  float phi = radians(sat1Lon) + PI;

  // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
  x = (r+20) * cos(theta) * cos(phi);
  y = -(r+20) * sin(theta);
  z = -(r+20) * cos(theta) * sin(phi);
}

void draw() {
  background(51);
  translate(width*0.5, height*0.5);
  rotateY(angle);
  angle += 0.05;

  lights();
  fill(200);
  noStroke();
  //sphere(r);
  shape(globe);
  /*
  for (TableRow row : table.rows()) {
   float lat = row.getFloat("latitude");
   float lon = row.getFloat("longitude");
   float mag = row.getFloat("mag");
   
   // original version
   // float theta = radians(lat) + PI/2;
   
   // fix: no + PI/2 needed, since latitude is between -180 and 180 deg
   float theta = radians(lat);
   
   float phi = radians(lon) + PI;
   
   // original version
   // float x = r * sin(theta) * cos(phi);
   // float y = -r * sin(theta) * sin(phi);
   // float z = r * cos(theta);
   
   // fix: in OpenGL, y & z axes are flipped from math notation of spherical coordinates
   float x = r * cos(theta) * cos(phi);
   float y = -r * sin(theta);
   float z = -r * cos(theta) * sin(phi);
   
   PVector pos = new PVector(x, y, z);
   
   float h = pow(10, mag);
   float maxh = pow(10, 7);
   h = map(h, 0, maxh, 10, 100);
   PVector xaxis = new PVector(1, 0, 0);
   float angleb = PVector.angleBetween(xaxis, pos);
   PVector raxis = xaxis.cross(pos);
   
   
   
   pushMatrix();
   translate(x, y, z);
   rotate(angleb, raxis.x, raxis.y, raxis.z);
   fill(255);
   box(h, 5, 5);
   popMatrix();
   }*/

  //  pushMatrix();
  translate(x, y, z);
  //rotate(angleb, raxis.x, raxis.y, raxis.z);
  fill(255);
  box(10);
  //popMatrix();
}
