PVector newPosition = new PVector(0.f, -3.f, 10.f);
PShape goat, podium, ground;
PImage image, snow ;
boolean discoMode = false;
float dephasage = 0;
int rayon = 20;

void setup() {
  //ajustement de la taille de l'ecran
  size(1080, 720, P3D);
  
  //declaration du constructeur
  Camera cam = new Camera(this);
  //ajustement de la position de la camera
  cam.setPosition(newPosition);
  
  //declaration de l'objet de la chevre
  goat = loadShape("goat.obj");
  goat.scale(2);
  goat.rotateY(PI);
  goat.translate(0, 1.2, 0);
  goat.rotate(PI);
  
  //declaration de l'objet de podium
  podium = loadShape("podium.obj");
  
  //declaration de la texture de la chevre
  image = loadImage("goat_texture.png");
  
  //declaration de l'objet de la terre
  ground = loadShape("ground.obj");
  ground.scale(30);
  
  //declaration de la texture de la terre
  snow = loadImage("snow_texture.png");
  
  goat.setTexture(image);
  ground.setTexture(snow);
  
}


void draw() {
  background(0);
  if (!discoMode) {
    directionalLight(255, 255, 255, -2, 3, -2);
    ambientLight(50, 50, 50);
  } else {
    dephasage=dephasage + 0.05;//pour fair tourner les spotlights
    itsDiscoTime();
  }

  //le show podium
  
  shape(podium);

  //le show chevre


  shape(goat);



  //le show terre
  
  shape(ground);
}

//fonction responsable de changement de couleur
void itsDiscoTime() {
  //creation de la cercle de spotlights de coordonné y=-20
  //1er spotlight rouge
  spotLight(255, 0, 0, rayon * cos(0+dephasage), -20, rayon * sin(0+dephasage), -rayon * cos(0+dephasage), 20, -rayon * sin(0+dephasage), PI/4, 400);
  //2eme spotlight vert
  spotLight(0, 255, 0, rayon * cos(PI/3+dephasage), -20, rayon * sin(PI/3+dephasage), -rayon * cos(PI/3+dephasage), 20, -rayon * sin(PI/3+dephasage), PI/4, 400);
  //3eme spotlight blue
  spotLight(0, 0, 255, rayon * cos(2*PI/3+dephasage), -20, rayon * sin(2*PI/3+dephasage), -rayon * cos(2*PI/3+dephasage), 20, -rayon * sin(2*PI/3+dephasage), PI/4, 400);
  //4eme spotlight jaune
  spotLight(255, 255, 0, rayon * cos(PI+dephasage), -20, rayon * sin(PI+dephasage), -rayon * cos(PI+dephasage), 20, -rayon * sin(PI+dephasage), PI/4, 400);
  //5eme spotlight maginta
  spotLight(255, 0, 255, rayon * cos(4*PI/3+dephasage), -20, rayon * sin(4*PI/3+dephasage), -rayon * cos(4*PI/3+dephasage), 20, -rayon * sin(4*PI/3+dephasage), PI/4, 400);
  //6eme spotlight cyan
  spotLight(0, 255, 255, rayon * cos(5*PI/3+dephasage), -20, rayon * sin(5*PI/3+dephasage), -rayon * cos(5*PI/3+dephasage), 20, -rayon * sin(5*PI/3+dephasage), PI/4, 400);
}
/*il y a 6 spotlights donc j'ai deviser la ccercle en 6 parties 0,pi/3,2pi/3/pi,4pi/3rt 5pi/3 j'ai ytiliser la trigonometré (opposé=hypotinus*sin(alpha),adjacent=hypotinus*cos(alpha))pour avoir la valeur exacte de x et z puis j'ai choisi la direction des lumiere l'iverse de ses coordonnés pour que les lumiere vise le centre (0,0,0)*/



//lorsque M/m est pressé
void keyPressed() {
  if (key == 'M'|| key == 'm' ) {
    discoMode=!discoMode;
    /*on a ajouter ces lignes de code afin de ne pas maintenir sur
     le button M pour avoir le disco il suffit un simple press*/
  }
}
