class Eye {
  int x, y; //coordinate occhio
  int size; //raggio occhio
  float angle = 0.0;
  float xp, yp; //coordinate pupille
  
  Eye(int tx, int ty, int ts) {
    x = tx;
    y = ty;
    size = ts;
  }
  
  /*
  Se col mouse si entra all'interno dell'occhio, la pupilla segue la
  posizione del mouse; altrimenti ruota sui bordi nella direzione in
  cui si trova il mouse.
  */
  void update() {
    
    //mouse interno all'occhio
    if(mouseX>x-size/4 && mouseX<x+size/4 && mouseY>y-size/4 && mouseY<y+size/4){
      xp = mouseX-x;
      yp = mouseY-y;
      angle = 0;
      
    //mouse esterno all'occhio
    }else{
      xp = size/4;
      yp = 0;
      angle = atan2(mouseY-y, mouseX-x);
    }
  }
  
  /*
  Permette di disegnare l'occhio in due modi diversi:
  true = con i bordi
  false = senza bordi(quindi con la pupilla ingrandita a colmare lo spazio del bordo mancante)
  */
  void display(boolean s) {
    
    //con bordi
    if(s){
      pushMatrix();
      translate(x, y); //traslo l'occhio nella posizione passata dal costruttore
      fill(0, 0, 100);
      ellipse(0, 0, size, size);
      rotate(angle); //ruoto la pupilla attorno al centro
      fill(0);
      ellipse(xp, yp, size/2, size/2);
      popMatrix();
      
    //senza bordi
    }else{
      pushMatrix();
      noStroke();
      translate(x, y);
      fill(0, 0, 100);
      ellipse(0, 0, size, size);
      rotate(angle);
      fill(0);
      ellipse(xp, yp, size/2+5, size/2+5);
      popMatrix();
    }
  }
}