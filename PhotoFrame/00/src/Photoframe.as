package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	public class Photoframe extends MovieClip
	{
		public var main:Main;
		public var mcNido:MovieClip = new MovieClip();
		public var mcMask:MovieClip;
		
		private var misFotos:File;

		private var archivos:Array = new Array();
		private var imagenes:Array;
		private var transicionTimer:Timer;
		private var indice:uint = 0;
		
		public var totalCargadas:uint= 0;
		public function Photoframe()
		{
			super();
			this.addChild(mcNido);
			mcNido.mask = mcMask;
		}
		
		public function set setMain(ax:Main):void
		{
			main = ax;
		
			this.cargar();
		}
		
		public function cargar():void
		{
			misFotos = new File(); 
			misFotos.addEventListener(Event.SELECT, dirSelected); 
			misFotos.browseForDirectory("Selecciona la carpeta con tus imágenes"); 
		}
		
		private function dirSelected(e:Event):void 
		{ 
			trace(misFotos.nativePath); 
			archivos = new Array();
			imagenes = new Array();
			var	carpeta:Array = misFotos.getDirectoryListing();
			for(var i:uint = 0; i < carpeta.length; i++){
				var sub:File = carpeta[i];
				if(sub.isDirectory){
					trace("es carpeta");
					
				}else{
					archivos.push(sub.url);
					trace("no es carpeta, es archivo " + sub.url);
				}
			}
			
			//poner en pantalla
			for(var j:uint = 0; j < archivos.length; j++){
				var imagen:Imagen = new Imagen();
				imagen.setPhotoframe = this;
				imagen.iniCarga(archivos[j]);
				imagenes.push(imagen);
				mcNido.addChild(imagen);	
				imagen.x = imagen.width/2 - 300/2;
			}
			
		}

		public function set setCargada(ax:uint):void
		{
			this.totalCargadas += ax;
			//trace("Total Cargadas " + this.totalCargadas);
			if(this.totalCargadas == imagenes.length -1)
			{
				//iniciar
				var actual:Imagen = imagenes[0];
				actual.clipIN(this.iniciarTimer);
			}
		}
		
		public function iniciarTimer():void
		{
			//trace("iniciarTimer");
			this.transicionTimer = new Timer(1000*5,1);	
			this.transicionTimer.addEventListener(TimerEvent.TIMER_COMPLETE,timerComplete);
			this.transicionTimer.start();
		}
		
		private function timerComplete(e:TimerEvent):void
		{
			//trace("timerComplete");
			var actual:Imagen = imagenes[indice];
			actual.clipOUT();
			//en orden
			indice++;
			if(indice>imagenes.length-1){
				indice = 0;
			}
			//en desorden
			//indice = rangoRandom(0,imagenes.length-1);
			var siguiente:Imagen = imagenes[indice];
			siguiente.clipIN(this.iniciarTimer);
		}
		
		private function rangoRandom(low:uint,high:uint):uint {
			var numeroRandom:uint = Math.floor(Math.random() * (high - low)) + low;
			//trace("Numero Random: " + numeroRandom);
			return numeroRandom;
		}

		
	}
}