class Camera{
  boolean scattata = false; //per il controllo se la foto e' stata scattata
  
  public Camera(){
    click = minim.loadFile("camera_click.mp3");
    cam.start(); //accendo la webcam
  }
  
  void cameraStart(){
    //se la webcam è disponibile mi legge i frame
    if(cam.available()){
        cam.read();
    }
    
    /*
    i frame della webcam sono visualizzati al contrario quindi vengono
    ruotati di 180 gradi per rendere la visualizzazione a specchio
    */
    pushMatrix();
    translate(width, 0);
    rotateY(PI);
    image(cam, 0, 0, width, height);
    popMatrix();
    
    /*
    quando viene premuta la barra spaziatrice viene riprodotto il sonoro della
    macchina fotografica e richiamato il metodo salvaFrame
    */
    if(keyPressed && key == ' '){
      click.setGain(20);
      click.play();
      salvaFoto();
    }
  }
  
  //salva il frame e chiude la webcam, imposta scattata a true
  public void salvaFoto(){
    saveFrame("myCapture.png");
    cam.stop();
    scattata = true;
  }
  
  //ritorna true se la foto è stata scattata, false altriemnti
  public boolean isScattata(){
    return scattata;
  }
}