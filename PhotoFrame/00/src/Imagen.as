package
{
	import com.greensock.TweenLite;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class Imagen extends MovieClip
	{
		public var mcPhotoframe:Photoframe;
		
		private var contenidoLoad:Loader = new Loader();
		private var miRuta:String;
		private var duracion:uint = 2;
		
		public function Imagen()
		{
			super();
			this.alpha = 0;
		}
		
		public function set setPhotoframe(ax:Photoframe):void
		{
			mcPhotoframe = ax;
		}
		
		public function iniCarga(ruta:String):void {
			miRuta = ruta;
			contenidoLoad.contentLoaderInfo.addEventListener(Event.OPEN, onOpen);
			contenidoLoad.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			contenidoLoad.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			contenidoLoad.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			contenidoLoad.load(new URLRequest(ruta));
			//Ruta del archivo a cargar
		}
		
		//Se Inicia la Carga
		private function onOpen(evt:Event):void{
			trace("OPEN " + miRuta);
		}
		
		//Evento desencadenado con el progreso de la carga
		private function onProgress(evt:ProgressEvent):void	{
			//trace("Progreso..");
			var porcentaje:uint = ((evt.bytesLoaded * 100) / evt.bytesTotal);	
		}
		
		//Evento desencadenado al terminar la carga
		private function onComplete(evt:Event):void {
			//trace("Completo");
			var bmp:Bitmap = contenidoLoad.content as Bitmap;
			bmp.smoothing = true;
			
			//Ajustes de tamaño
			//Revisar tamaño
			var maxW:int = 300;
			var maxH:int = 300;
			
			var r:Number;//ratio
			r = bmp.height/bmp.width;//calculation ratio
			
			//Al ancho
			/*
			if (bmp.width>maxW) 
			{
				bmp.width = maxW;
				bmp.height = Math.round(b.width*r);
			}
			*/
			//Al alto
			if (bmp.height>maxH) 
			{
				bmp.height = maxH;
				bmp.width = Math.round(bmp.height/r);
			}			
			//Ver una forma de centrar
			
			this.addChild(bmp);
			mcPhotoframe.setCargada = 1;
		}
		
		//Evento desencadenado con algún error en la carga
		private function onError(evt:IOErrorEvent):void{
			trace("Error de Carga: "+evt);
		}
		
		public function clipIN(fx:Function = null):void
		{
			trace("clipIN " + this.miRuta);
			TweenLite.to(this,duracion,{alpha:1,onComplete:fx});	
		}
		
		public function clipOUT(fx:Function = null):void
		{
			TweenLite.to(this,duracion,{alpha:0,onComplete:fx});
		}
		
	}
}