public class Sphere {
  PVector centre_sphere ;
  float  rayon_sphere ;
  PVector couleur_sphere ;
  public Sphere(PVector centre_sphere, float rayon_sphere, PVector couleur_sphere) {
    this.centre_sphere = centre_sphere;
    this.rayon_sphere = rayon_sphere;
    this.couleur_sphere = couleur_sphere;
  }


  float intersect(Ray p_ray, float p_tmin, float p_tmax) {
    /*apres l'insertion de l equoation de rayon dans l eq de sphere on a trouver une expression sous la forme At^2+Bt+C avec
     A=D^2=1 puisque le vecteur D est normalisé
     B=2DO-2DP
     C=O^2 - 2OP + P^2(prd remarquable) - r^2
     DELTA=B^2 - 4AC
     */
    float  t1=0, t2=0;
    float A = (p_ray.direction).magSq();//ou A=1

    float B = PVector.dot(PVector.mult(p_ray.direction, 2), PVector.sub(p_ray.centre, this.centre_sphere));

    float C = PVector.sub(p_ray.centre, this.centre_sphere).magSq() - this.rayon_sphere*this.rayon_sphere;

    float DELTA = B*B - 4*A*C;
    

    if (DELTA>0) {
      t1 = (-B + sqrt(DELTA))/(2*A);

      t2 = (-B - sqrt(DELTA))/(2*A);
    }
    

    
    if ((p_tmin<=t1) &&(t1<t2)&& (t1<=p_tmax))
      return t1 ;
    else if ((p_tmin<=t2) &&(t2<t1)&& (t2<=p_tmax))
      return t2 ;
    else
    return -1;
  }
  
  
}
