void setup() {
  PVector p_light = new PVector(-1, 2, -0.5);
  Camera cam = new Camera(width, height, 90);
  size(500, 500);
  /*loadPixels();
   
   for (int i = 0; i < width; i++) {
   for (int j = 0; j < height; j++) {
   int index = i * width + j;  //from chat gbt 2D->1d
   float h = j / float(height - 1);
   float w = i / float(width - 1);
   Ray ray =cam.generateRay(w, h);
   pixels[index] = color( ((ray.direction.x + 1.f)*0.5f)* 255, ((ray.direction.y +1.f)*0.5f) * 255, ((ray.direction.z+1.f)*0.5)*255);
   }
   }
   
   updatePixels();*/
  /*Sphere s1 = new Sphere(new PVector(0,0,3), 1 ,new PVector(255,255,255));
   
   
   loadPixels();
   
   for (int i = 0; i < width; i++) {
   for (int j = 0; j < height; j++) {
   int index = j * width + i;  //from chat gbt 2D->1d
   float h = j / float(height - 1);
   float w = i / float(width - 1);
   Ray ray =cam.generateRay(w, h);
   float intersect =  s1.intersect(ray,0.001,1000);
   if (intersect != -1){
   pixels[index] = color(s1.couleur_sphere.x,s1.couleur_sphere.y,s1.couleur_sphere.z);}
   else {
   pixels[index] = color(0.8*255,0.8*255,0.8*255);}
   }
   }
   
   updatePixels();*/
  ArrayList<Sphere> arry = new ArrayList<Sphere>();
  arry.add(new Sphere(new PVector( -505, 0, 0 ), 500, new PVector( 255, 0, 0 )));//rouge
  arry.add(new Sphere(new PVector( 505, 0, 0 ), 500, new PVector( 0, 0, 255 )));//blue
  arry.add(new Sphere(new PVector( 0, -505, 0 ), 500, new PVector( 255, 0, 255 )));//magenta
  arry.add(new Sphere(new PVector( 0, 505, 0 ), 500, new PVector( 255, 255, 0 )));//jaune
  arry.add(new Sphere(new PVector( 0, 0, -510 ), 500, new PVector( 0, 255, 255 )));//cyan
  arry.add(new Sphere(new PVector( 0, 0, 510 ), 500, new PVector(0, 255, 0 )));//vert
  arry.add(new Sphere(new PVector( 0, 0, 3 ), 1, new PVector( 255, 255, 255)));//blanc
  loadPixels();


  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
      int index = i * width + j;  //from chat gbt 2D->1D
      float w = j / float(height - 1);
      float h = i / float(width - 1);
      Ray ray =cam.generateRay(w, h);
      float d_min=100;//distance minimale a comparer avec la distance d'intersection pour etirer la plus proche distance d'intersection
      for (int x = 0; x < 7; x++) {
        float intersect =  arry.get(x).intersect(ray, 0.1, 1000);
        if (intersect!=-1) {
          if (intersect<=d_min) {
            PVector pt_intersection = PVector.add(ray.centre, PVector.mult( ray.direction, intersect ));//cration du poit d'intersection entre la lumiere et la surface du sphere
            PVector normal_sphere = PVector.sub(pt_intersection, arry.get(x).centre_sphere).normalize();
            PVector DL = PVector.sub(p_light, pt_intersection).normalize();
            float cos_angle=PVector.dot(normal_sphere, DL);


            Ray r = new Ray(pt_intersection, PVector.sub(p_light, pt_intersection).normalize());//cration de rayon dans la position de pt d'intersection et derigé vers la lumiere
            for (int y = 0; y < 7; y++) {
              float intersect_shadow = arry.get(y).intersect(r, 0.1, 1000);
              if (intersect_shadow != -1.0) {
                pixels[index]=color(0);//pour faire le shadowing
              } else {
                pixels[index] = color(arry.get(x).couleur_sphere.x * cos_angle, arry.get(x).couleur_sphere.y * cos_angle, arry.get(x).couleur_sphere.z * cos_angle);
              }
            }
            d_min=intersect;
          }
        }
      }
    }
  }
  updatePixels();
}
