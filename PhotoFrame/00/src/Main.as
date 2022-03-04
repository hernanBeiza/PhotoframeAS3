package
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;

	public class Main extends MovieClip
	{
		public var mcArea:MovieClip;
		public var mcPhotoframe:Photoframe;
		
		
		public function Main()
		{
			trace("Photoframe v0.01");
			mcArea.alpha = 0;
			mcArea.addEventListener(MouseEvent.MOUSE_DOWN,mouseDOWN);
			mcArea.addEventListener(MouseEvent.MOUSE_DOWN,mouseUP);
			mcPhotoframe.setMain = this;
		}
		
		
		
		private function mouseDOWN(e:MouseEvent):void
		{
			stage.nativeWindow.startMove();			
		}
		
		private function mouseUP(e:MouseEvent):void
		{
			
		}
	}
}