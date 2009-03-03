package {	import caurina.transitions.properties.DisplayShortcuts;		import fl.controls.Button;	import fl.controls.CheckBox;	import fl.controls.LabelButton;	import fl.controls.TextArea;		import com.soma.loader.ILoading;	import com.soma.loader.SomaLoader;	import com.soma.loader.SomaLoaderEvent;	import com.soma.loader.SomaLoaderItem;	import com.soundstep.utils.FPS;		import flash.display.DisplayObject;	import flash.display.DisplayObjectContainer;	import flash.display.Sprite;	import flash.events.MouseEvent;	import flash.net.URLLoaderDataFormat;	import flash.text.AntiAliasType;	import flash.text.Font;	import flash.text.TextField;	import flash.text.TextFieldAutoSize;	import flash.text.TextFormat;		/**	 * <b>Author:</b> Romuald Quantin - <a href="http://www.soundstep.com/" target="_blank">www.soundstep.com</a><br />	 * <b>Class version:</b> 1.0<br />	 * <b>Actionscript version:</b> 3.0<br />	 * <b>Copyright:</b> 	 * <br />	 * <b>Date:</b> 20 Feb 2009<br />	 * <b>Usage:</b>	 * @example	 * <listing version="3.0"></listing>	 */		public class Main extends Sprite {		//------------------------------------		// private, protected properties		//------------------------------------				private var _loader:SomaLoader;		private var _loading:ILoading;				private var _container:Sprite;
		//------------------------------------		// public properties		//------------------------------------				public var textNumItems:TextField;		public var textNumCache:TextField;		public var textStatus:TextField;		public var log:TextArea;				public var btStart:Button;		public var btStop:Button;		public var btPause:Button;		public var btResume:Button;		public var btRemoveItem:Button;		public var btRemoveAll:Button;		public var btAddImage:Button;		public var btAddXML:Button;		public var btAddCSS:Button;		public var btAddTXT:Button;		public var btAddSWF:Button;		public var btAddMP3:Button;		public var btAddFont:Button;		public var btDisposeLoader:Button;		public var btDisposeHolder:Button;				public var btCreateImgFromBinary:Button;		public var btCreateSwfFromBinary:Button;				public var selAssetsBinary:CheckBox;
		//------------------------------------		// constructor		//------------------------------------				public function Main() {			init();		}		//		// PRIVATE, PROTECTED		//________________________________________________________________________________________________				private function init():void {			DisplayShortcuts.init();			var tf:TextFormat = new TextFormat();			tf.color = 0xFFFFFF;			tf.font = "Arial";			tf.size = 12;			selAssetsBinary.setStyle("textFormat", tf);			_container = addChildAt(new Sprite, 0) as Sprite;			_container.name = "container";			_loader = new SomaLoader();			_loading = addChild(new Loading) as ILoading;			Loading(_loading).x = 10;			Loading(_loading).y = (stage.stageHeight) - (Loading(_loading).height + 10);			_loader.loading = _loading;			textStatus.text = String(_loader.status);			textNumItems.text = String(_loader.length);			textNumCache.text = String(_loader.lengthCache);			// listeners			btStart.addEventListener(MouseEvent.CLICK, start);			btStop.addEventListener(MouseEvent.CLICK, stop);			btPause.addEventListener(MouseEvent.CLICK, pause);			btResume.addEventListener(MouseEvent.CLICK, resume);			btRemoveItem.addEventListener(MouseEvent.CLICK, removeItem);			btRemoveAll.addEventListener(MouseEvent.CLICK, removeAll);			btAddImage.addEventListener(MouseEvent.CLICK, addAsset);			btAddXML.addEventListener(MouseEvent.CLICK, addAsset);			btAddCSS.addEventListener(MouseEvent.CLICK, addAsset);			btAddTXT.addEventListener(MouseEvent.CLICK, addAsset);			btAddSWF.addEventListener(MouseEvent.CLICK, addAsset);			btAddMP3.addEventListener(MouseEvent.CLICK, addAsset);			btAddFont.addEventListener(MouseEvent.CLICK, addAsset);			btDisposeLoader.addEventListener(MouseEvent.CLICK, disposeLoader);			btDisposeHolder.addEventListener(MouseEvent.CLICK, disposeHolder);			btCreateImgFromBinary.addEventListener(MouseEvent.CLICK, createImageFromBinaryHandler);			btCreateSwfFromBinary.addEventListener(MouseEvent.CLICK, createSwfFromBinaryHandler);			// loader listeners			_loader.addEventListener(SomaLoaderEvent.QUEUE_CHANGED, queueChangedHandler);			_loader.addEventListener(SomaLoaderEvent.QUEUE_START, queueStartHandler);			_loader.addEventListener(SomaLoaderEvent.QUEUE_PROGRESS, queueProgressHandler);			_loader.addEventListener(SomaLoaderEvent.QUEUE_COMPLETE, queueCompleteHandler);			_loader.addEventListener(SomaLoaderEvent.START, startHandler);			_loader.addEventListener(SomaLoaderEvent.PROGRESS, progressHandler);			_loader.addEventListener(SomaLoaderEvent.COMPLETE, completeHandler);			_loader.addEventListener(SomaLoaderEvent.ERROR, errorHandler);			_loader.addEventListener(SomaLoaderEvent.ID3_COMPLETE, id3CompleteHandler);			_loader.addEventListener(SomaLoaderEvent.STATUS_CHANGED, statusChangedHandler);			_loader.addEventListener(SomaLoaderEvent.CACHE_CHANGED, cacheChangedHandler);			// FPS			addChild(new FPS);		}		private function start(e:MouseEvent):void {			_loader.start();		}				private function stop(e:MouseEvent):void {			_loader.stop();		}				private function pause(e:MouseEvent):void {			_loader.pause();		}		private function resume(e:MouseEvent):void {			_loader.resume();		}				private function disposeLoader(e:MouseEvent):void {			_loader.dispose(true);			btCreateImgFromBinary.visible = false;			btCreateSwfFromBinary.visible = false;		}		private function disposeHolder(e:MouseEvent):void {			while (_container.numChildren > 0) {				var target:DisplayObject = getChildAt(0);				_container.removeChildAt(0);				target = null;			}		}				private function addAsset(e:MouseEvent):void {			if (e.currentTarget == btAddImage) {				for (var i:int=0; i<20; i++) {					var sprite:Sprite = _container.addChild(new Sprite) as Sprite;					var item:SomaLoaderItem;					if (!selAssetsBinary.selected) {						item = _loader.add("assets/images/photo" + i + ".jpg", sprite, null, {id:i});					}					else {						item = _loader.add("assets/images/photo" + i + ".jpg", null, null, {id:i}, URLLoaderDataFormat.BINARY);					}					if (item != null) {						addLog("add image: " + item.url);						if (!selAssetsBinary.selected) {							item.addContainerProperty("scaleX", .4);							item.addContainerProperty("scaleY", .4);							item.addContainerProperty("x", Math.random() * (stage.stageWidth * .4));							item.addContainerProperty("y", Math.random() * (stage.stageHeight * .4));						}						break;					}				}				return;			}			if (e.currentTarget == btAddSWF) {				for (var g:int=0; g<10; g++) {					var sprite2:Sprite = _container.addChild(new Sprite) as Sprite;					var item2:SomaLoaderItem;					if (!selAssetsBinary.selected) {						item2 = _loader.add("assets/swf/sample" + g + ".swf", sprite2);					}					else {						item2 = _loader.add("assets/swf/sample" + g + ".swf", null, null, null, URLLoaderDataFormat.BINARY);					}					if (item2 != null) {						addLog("add SWF: " + item2.url);						if (!selAssetsBinary.selected) {							item2.addContainerProperty("x", Math.random() * (stage.stageWidth * .4));							item2.addContainerProperty("y", Math.random() * (stage.stageHeight * .4));						}						break;					}				}				return;			}			if (e.currentTarget == btAddFont) {				for (var f:int=0; f<5; f++) {					var item3:SomaLoaderItem = _loader.add("assets/fonts/sample" + f + ".swf");					if (item3 != null) {						item3.type = SomaLoader.TYPE_FONT;						addLog("add Fonts: " + item3.url);						if (_loader.playerVersion < 10) {							// this is not necessary with flash player 10 (the SWF is automatically parsed)							if (f == 0) item3.registerFontClassName(["BrushScriptStd", "RosewoodStd"]);							if (f == 1) item3.registerFontClassName(["PalatinoLinotype", "ChaparralPro"]);							if (f == 2) item3.registerFontClassName(["LithosPro", "StencilStd"]);							if (f == 3) item3.registerFontClassName(["CourierNew", "Symbol"]);							if (f == 4) item3.registerFontClassName(["Webdings", "Wingdings3"]);						}						break;					}				}				return;			}			var fileType:String;			var fileMessage:String;			switch (e.currentTarget) {				case btAddXML:					fileType = "xml";					fileMessage = "add XML: ";					break;				case btAddCSS:					fileType = "css";					fileMessage = "add CSS: ";					break;				case btAddTXT:					fileType = "txt";					fileMessage = "add Text: ";					break;				case btAddMP3:					fileType = "mp3";					fileMessage = "add audio: ";					break;			}			for (var j:int=0; j<10; j++) {				var itemDefault:SomaLoaderItem = _loader.add("assets/" + fileType + "/sample" + j + "." + fileType);				if (itemDefault != null) {					addLog(fileMessage + itemDefault.url);					break;				}			}		}				private function createImageFromBinaryHandler(e:MouseEvent):void {			var arrBinaryAvailable:Array = _loader.getBinaryLoadedItems(SomaLoader.TYPE_BITMAP);			if (arrBinaryAvailable.length > 0) {				for (var g:int=0; g<arrBinaryAvailable.length; g++) {					var sprite:Sprite = _container.addChild(new Sprite) as Sprite;					var item:SomaLoaderItem = _loader.addBinary(arrBinaryAvailable[g], sprite);					if (item != null) {						item.addContainerProperty("scaleX", .4);						item.addContainerProperty("scaleY", .4);						item.addContainerProperty("x", Math.random() * (stage.stageWidth * .4));						item.addContainerProperty("y", Math.random() * (stage.stageHeight * .4));						addLog("add Binary Data loaded from: " + arrBinaryAvailable[g].url);						break;					}				}			}		}				private function createSwfFromBinaryHandler(e:MouseEvent):void {			var arrBinaryAvailable:Array = _loader.getBinaryLoadedItems(SomaLoader.TYPE_SWF);			if (arrBinaryAvailable.length > 0) {				for (var g:int=0; g<arrBinaryAvailable.length; g++) {					var sprite:Sprite = _container.addChild(new Sprite) as Sprite;					var item:SomaLoaderItem = _loader.addBinary(arrBinaryAvailable[g], sprite);					if (item != null) {						item.addContainerProperty("x", Math.random() * (stage.stageWidth * .4));						item.addContainerProperty("y", Math.random() * (stage.stageHeight * .4));						addLog("add Binary Data loaded from: " + arrBinaryAvailable[g].url);						break;					}				}			}		}				private function removeItem(e:MouseEvent):void {			if (_loader.status == SomaLoader.STATUS_LOADING && _loader.length == 1) return;			var startIndex:int = (_loader.status == SomaLoader.STATUS_LOADING) ? 1 : 0;			var num:int = Math.floor(Math.random() * (_loader.length - 1)) + startIndex;			if (_loader.items[num] != null) addLog("remove item: " + _loader.items[num].url);			_loader.removeAt(num);		}		private function removeAll(e:MouseEvent):void {			if (_loader.removeAll()) addLog("remove all");		}				private function queueChangedHandler(e:SomaLoaderEvent):void {			textNumItems.text = String(_loader.length);		}				private function statusChangedHandler(e:SomaLoaderEvent):void {			addLog("status changed: " + _loader.status);			textStatus.text = String(_loader.status);		}				private function cacheChangedHandler(e:SomaLoaderEvent):void {			textNumCache.text = String(_loader.lengthCache);		}				private function queueStartHandler(e:SomaLoaderEvent):void {			addLog("--- queue start ---");		}				private function queueProgressHandler(e:SomaLoaderEvent):void {					}				private function queueCompleteHandler(e:SomaLoaderEvent):void {			addLog("--- queue end ---");		}		private function startHandler(e:SomaLoaderEvent):void {					}				private function progressHandler(e:SomaLoaderEvent):void {					}		private function completeHandler(e:SomaLoaderEvent):void {			textNumItems.text = String(_loader.length);			switch (e.item.type) {				case SomaLoader.TYPE_BITMAP:					//var bitmap:Bitmap = e.item.file as Bitmap;					//var container:Sprite = e.item.container as Sprite;					if (_loader.playerVersion <= 10) {						if (_loader.getBinaryLoadedItems(SomaLoader.TYPE_BITMAP).length > 0) btCreateImgFromBinary.visible = true;					}					else {						if (_loader.lengthCache > 0) btCreateImgFromBinary.visible = true;					}					break;				case SomaLoader.TYPE_XML:					//var xml:XML = new XML(e.item.file);					break;				case SomaLoader.TYPE_CSS:					//var css:StyleSheet = new StyleSheet();					//css.parseCSS(e.item.file);					break;				case SomaLoader.TYPE_TEXT:					//var txt:String = e.item.file as String;					break;				case SomaLoader.TYPE_SWF:					//var movie:MovieClip = e.item.file as MovieClip;					//var container:Sprite = e.item.container as Sprite;					if (_loader.playerVersion <= 10) {						if (_loader.getBinaryLoadedItems(SomaLoader.TYPE_SWF).length > 0) btCreateSwfFromBinary.visible = true;					}					else {						if (_loader.lengthCache > 0) btCreateSwfFromBinary.visible = true;					}					break;				case SomaLoader.TYPE_MP3:					//var sound:Sound = e.item.file as Sound;				case SomaLoader.TYPE_FONT:					var fonts:Array = e.item.fileFonts;					for each (var font:Font in fonts) {						addLog("     font available: " + font.fontName + ", " + font.fontStyle);						createTextField(font.fontName);					}					break;				case SomaLoader.TYPE_UNKNOWN:					break;			}			addLog("file loaded: " + e.item.url);		}				private function createTextField(fontName:String):void {			var txt:TextField = new TextField();			txt.autoSize = TextFieldAutoSize.LEFT;			txt.width = 150;			txt.antiAliasType = AntiAliasType.ADVANCED;			txt.multiline = true;			txt.wordWrap = true;			txt.embedFonts = true;			txt.defaultTextFormat = new TextFormat(fontName, 16);			txt.text = "Lorem ipsum dolor sit amet";			txt.x = Math.random() * (stage.stageWidth - 150);			txt.y = Math.random() * (stage.stageHeight * .5) + 160;			_container.addChild(txt);		}				private function errorHandler(e:SomaLoaderEvent):void {			addLog("error: " + e.errorMessage);			trace(e.errorMessage);		}				private function id3CompleteHandler(e:SomaLoaderEvent):void {//			trace("ID3 received:\n");//			for (var id:String in e.id3Info) {//				trace("Tag: ", id, " = ", e.id3Info[id]); //			}		}				private function addLog(str:String):void {			log.text = str + "\n" + log.text;		}				// PUBLIC		//________________________________________________________________________________________________							}}