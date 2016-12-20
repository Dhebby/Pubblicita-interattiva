class Tree{
  int x, y; //coordinate dell'albero
  float hue = random(0, 360); //tinta inizialmente random
  
  Eye e1, e2; 
  Chioma f;
  
  public Tree(int posX, int posY){
    x = posX;
    y = posY;
    f = new Chioma(x+30, y-60, hue);
  }
  
  //cambia la posizione dell'albero assieme a quella della chioma
  public void setPosition(int a, int b){
    x = a;
    y = b;
    f.changePosition(a+30, b-60);
  }
  
  //cambia il colore della chioma
  public void setColor(){
    hue = random(0, 360);
    f.changeColor(hue);
  }
  
  public void draw(){
    noStroke();
    
    //disegno il tronco
    fill(21, 94, 45);
    rect(x, y, 60, 110);
    
    //disegno il vaso
    fill(30, 100, 90);
    rect(x-5, y+110, 70, 20);
    quad(x, y+130, x+60, y+130, x+50, y+160, x+10, y+160);
    
    //disegno la chioma
    f.display();
    
    //disegno i due occhi (con bordo)
    strokeWeight(2);
    stroke(0);
    e1 = new Eye(x+15, y+60, 30);
    e2 = new Eye(x+45, y+60, 30);
    e1.update(); //aggiorno la posizione degli occhi
    e2.update();
    e1.display(true); //true perche' metto i bordi
    e2.display(true);
  }
}