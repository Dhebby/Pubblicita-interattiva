class Chioma{
  int x, y; //coordinate del centro della chioma
  float hue;
  
  int k = 800; //numero di palline nella chioma
  int rp = 30; //raggio max delle palline
  int rc = 90; //raggio della chioma
  
  // gli array di angoli e raggi servono a distribuire le palline all'interno di un cerchio
  
  float[] size = new float[k]; //array dei diametri delle palline
  float[] angle = new float[k]; //array degli angoli
  float[] radius = new float[k]; //array dei raggi
  color[] c = new color[k]; //array dei colori delle palline
  float[] t = new float[k]; //array della trasparenza delle palline
  
  public Chioma(int px, int py, float pc){
    x = px;
    y = py;
    hue = pc;
    
    //riempio gli array con numeri casuali
    for(int i=0; i<k; i++){
      size[i] = random(1, rp); //il primo valore e' 1 perche' le palline con raggio 0 non vengono disegnate
      angle[i] = random(0, 2*(float)Math.PI);
      radius[i] = random(0, rc);
      c[i] = color(hue, random(20, 100), 100); 
      t[i] = random(0, 255);
    }
  }
  
  //cambia la posizione dell'intera chioma
  public void changePosition(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  //cambia la tinta (hue) delle palline, reimpostando le saturazioni
  public void changeColor(float h){
    for(int i=0; i<k; i++)
      c[i] = color(h, random(20, 100), 100);
  }
  
  // disegno le palline all'interno del cerchio per creare la chioma
  void display(){
    for(int i=0; i<k; i++){
      fill(c[i], t[i]);
      ellipse(x + radius[i]*sin(angle[i]), y + radius[i]*cos(angle[i]), size[i], size[i]);
    }
  }
}