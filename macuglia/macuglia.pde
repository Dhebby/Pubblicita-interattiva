import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import processing.video.*;

Capture cam;
Camera c;

Minim minim;

//audio dello sketch
AudioPlayer song1, song2, click, mouse1, mouse2, mouse3;

//immagini dello sketch
PImage imgBW, imgRGB, imgUser, imgUserBW, imgS, imgTree, imgLogo, imgLogoMini;

Tree tree;
Eye e1, e2;

PVector pTree; //vettore per le posizioni dell'albero

PFont font;

boolean clicked = false; //per gestire l'alternanza dei click del mouse sinstro
boolean end = false; //per l'accesso alla scena finale
boolean photo = false; //per entrare/uscire dalla scena di interazione tramite webcam
boolean enableMouse = false; //per abilitare o meno l'interazione col mouse

int m = 0; //variabile utilizzata per il conteggio dei millisecondi


 
void setup(){
  size(900, 650, P3D); //per il rotateY che è una rotazione 3D
  colorMode(HSB, 360, 100, 100);
  
  font = createFont("Arcon-Rounded-Regular.otf", 42);
  
  imgRGB = loadImage("color.png");
  imgBW = loadImage("color.png");
  imgBW.filter(GRAY);
  imgS = loadImage("sfondo.png");
  imgLogo = loadImage("LogoArbo.png");
  imgLogoMini = loadImage("LogoArbo_small.png");
  
  tree = new Tree(420, 380);
  
  c = null;
  
  pTree = new PVector(width/2, height/2);
  
  //occhi logo
  e1 = new Eye(470, 306, 69);
  e2 = new Eye(567, 306, 69);
  
  minim = new Minim(this);
  song1 = minim.loadFile("song1.mp3");
  song2 = minim.loadFile("song2.mp3");
  mouse1 = minim.loadFile("Magic.mp3");
  mouse2 = minim.loadFile("Blop.mp3");
  mouse3 = minim.loadFile("Boing.mp3");
}

void draw(){
  background(255);
  textFont(font); //applico il font
  fill(0); //testo dello sketch color nero
  
  /*
  parte pubblicitaria di presentazione del prodotto
  */
  
  //scena in bianco e nero
  if(millis() <= 10000){
    song1.play();
    image(imgBW, 0, 0);
    if(millis() < 5000){
      String s = "Stufo della tua vita triste e cupa?";
      text(s, 45, 565, width-90, 100);
      song1.shiftGain(0, -20, 10000);
    }else{
      String s = "Rendila felice e luminosa!";
      text(s, 45, 565, width-90, 100);
    }
    
  //scena a colori
  }else if(millis() <= 15000){
    //cambio canzone
    song1.close();
    song2.play();
    
    image(imgRGB, 0, 0);
    tree.draw();
    
    //posiziono il logo nella scena
    pushMatrix();
    scale(1.2);
    image(imgLogoMini, width/3+52, height/2+85);
    popMatrix();
    
    String s = "Adotta anche tu un albero da compagnia!";
    text(s, 45, 565, width-90, 100);
  
  /*
  parte interattiva dell'utente
  */
  
  //istruzini
  }else if(millis() <= 20000){
    image(imgS, 0, 0);
    textFont(font, 36);
    String s = "Prova ora ad immaginarlo lì accanto a te ...";
    text(s, 45, 225, width-90, height);
  }else if(millis() > 20000 && !photo){
      image(imgS, 0, 0);
      textFont(font, 36);
      String s = "Scatta una foto dello spazio che ti circonda.\n\nPer proseguire premi INVIO e attendi ...\n\nBarra spaziatrice = scatta foto";
      text(s, 45, 225, width-90, height);
      
    //interazione webcam
    if(keyPressed && keyCode == ENTER && c == null){
      song2.setGain(-15); //diminuisco il volume della canzone per far sentire il suono della fotocamera
      cam = new Capture(this);
      c = new Camera();
    }
    if(c != null && !c.isScattata()){ //fino a che l'immagine non è stata scattata
      c.cameraStart();
      m = millis(); //salvo i millisecondi per utilizzarli successivamente
      photo = c.isScattata();
    }
  }
  
  //istruzioni
  if(c != null && c.isScattata() && m!=0 && millis()<=m+5000){
    song2.setGain(0); //reimposto il volume normale della canzone
    image(imgS, 0, 0);
    textFont(font, 36);
    String s = "Ora divertiti a collocare l'albero dove più ti piace.\n\nMouse click SX = sposta albero\nMouse click DX = cambia colore\nInvio = conferma la scena";
    text(s, 45, 225, width-90, height);
  }
  
  //interazione utente-immagine
  if(c != null && c.isScattata() && m!=0 && millis()>m+5000){
    
    //vengono caricate le immagini su cui interagire
    if(imgUser == null){
      enableMouse = true;
      imgUser = loadImage("myCapture.png");
      imgUserBW = loadImage("myCapture.png");
      imgUserBW.filter(GRAY); //rendo l'immagine in bianco e nero
      song2.setGain(-15); //abbasso nuovamente il volume della canzone
    }
    
    //immagine in bianco e nero
    if(clicked == false){
      image(imgUserBW, 0, 0);
      tree.setPosition(mouseX-30, mouseY);
      tree.draw();
    //immagine colorata
    } else {
      image(imgUser, 0, 0);
      tree.setPosition((int)pTree.x, (int)pTree.y);
      tree.draw();
      
      //premendo invio salvo il frame , attendo il caricamento dell'img e passo alla scena successiva
      if (keyPressed && keyCode == ENTER){ 
        saveFrame("youAndTree.png");
        song2.setGain(0);
        enableMouse = false;
        
        imgTree = loadImage("youAndTree.png"); //carico l'immagine finale
        if(imgTree != null){
          end = true;
        }
      }
    }
  }
  
  /*
  scena finale con logo
  */
  
  if(end){
    background(76, 71, 85);
    
    //posiziono logo
    pushMatrix();
    scale(0.4);
    image(imgLogo, 550, 500);
    popMatrix();
    
    //logo interattivo (occhi senza bordi)
    e1.update();
    e2.update();
    e1.display(false); //false = senza bordi
    e2.display(false);
    
    textFont(font, 36);
    String s = "Ora la tua vita è colorata!!";
    textAlign(CENTER);
    text(s, 45, 565, width-90, 100);
    
    //l'immagine si posiziona in base alle coordinate del mouse
    pushMatrix();
    scale(0.8);
    image(imgTree, 110, map(mouseX, 0, height, 0, -520));
    popMatrix();
  }
  
  //quando la canzone termina la faccio ripartire
  if(millis()>11000 && !song2.isPlaying()){
    song2.rewind();
    song2.play();
  }
}

void mousePressed(){
  /*
  funziona solo quando viene precedentemente abilitato il mouse
  per evitare che l'utente interagisca quando non deve
  */
  if(enableMouse){
    
    if(mouseButton == LEFT){
      //alterno i due suoni quando viene premuto il mouse
      if(clicked){
        mouse2.play();
        mouse2.rewind();
      }else{
        mouse1.play();
        mouse1.rewind();
      }
      
      //nuova posizione dell'albero
      pTree = new PVector(mouseX-30, mouseY);
      tree.setPosition((int)pTree.x, (int)pTree.y);
      
      clicked = !clicked;
      
    }else if(mouseButton == RIGHT){
      mouse3.play();
      mouse3.rewind();
      tree.setColor(); //modifico il colore della chioma
    }
  }
}