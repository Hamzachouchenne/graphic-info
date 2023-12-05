// All public for simplicity
class Camera
{
  Camera(int p_imgWidth, int p_imgHeight, float p_fov)
  {
    _position = new PVector(0.f, 0.f, 0.f);
    // The camera coordinate system (_u, _v, _w) is fixed in this exercise!
    _u = new PVector(1.f, 0.f, 0.f);
    _v = new PVector(0.f, 1.f, 0.f);
    _w = new PVector(0.f, 0.f, -1.f);

    _aspectRatio = (float)p_imgWidth / p_imgHeight;
    _fov = p_fov;

    updateViewPort();
  }

  void updateViewPort()
  {
    float h = 2.f * tan( radians( _fov * 0.5f ) ); // height
    float w = h * _aspectRatio; // width

    _vU = PVector.mult(_u, w);
    _vV = PVector.mult(_v, h);
    _vC = PVector.sub(PVector.add(PVector.sub(_position, PVector.mult(_vU, 0.5f)), PVector.mult(_vV, 0.5f)), _w);
  }

  //==================================

  PVector _position;

  // Camera coordinate system
  PVector _u;
  PVector _v;
  PVector _w;

  // Viewport vectors
  //  _vC    _vU
  //     *---------->
  //     |
  // _vV |
  //     |
  //    V
  PVector _vU;
  PVector _vV;
  PVector _vC; // Top left corner

  float _aspectRatio; // ratio width/height
  float _fov; // field of view
  Ray generateRay(float p_x, float p_y) {
    PVector origine = _position;
    PVector p;
    p = PVector.add(PVector.mult(_vU, p_x), PVector.mult(_vV, -p_y));
    p.add(_vC);
    PVector p_direction = PVector.sub(p, origine).normalize();
    return new Ray(origine, p_direction);
  }
}
