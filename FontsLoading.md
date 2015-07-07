### Introduction ###

Somaloader allows you load fonts in a SWF at run-time very easily. The behavior is slightly different depending if you release the code for Flash Player 9 or 10.

To create a SWF file containing fonts, you can either compile a small movie and use the Embed metadata tags or use Flash IDE. In Flash, you can right click on the library and "add fonts, choose one or more, export for actionscript (which will create a Class and embed it) and export your movie.

The way to load the fonts will always be the same, but the way to register them to Flash is different for Flash Player 9 or 10. If you're not sure, just use the Flash Player 9 way.

### Flash Player 10 ###

Flash Player 10 is probably the easiest way as everything is automatic. You just need to add the SWF file to a SomaLoader instance and start it. You dont even need to know what fonts you have to register or listen to a an event.

Once loaded, SomaLoader will find and register your fonts using Font.registerFont(MyFont). For an easy access if you need to access to the fonts loaded, SomaLoader is populating an array in the SomaLoaderItem (item.fileFonts).

```
import com.soma.loader.SomaLoader;
import com.soma.loader.SomaLoaderEvent;

var loader:SomaLoader = new SomaLoader();
loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
loader.add("fonts.swf");
loader.start();

function itemComplete(event:SomaLoaderEvent):void {
    var fonts:Array = e.item.fileFonts;
    for each (var font:Font in fonts) {
        trace("font available: " + font.fontName);
    }
}
```

### Flash Player 9 ###

Load fonts for Flash Player 9 is very similar, but the registration is not automatic. You will have to know what are the fonts you are loading (the class names) and use the registerFontClassName method of a SomaLoaderItem (parameter is an Array of String containing the class names of the fonts).

```
import com.soma.loader.SomaLoader;
import com.soma.loader.SomaLoaderEvent;

var loader:SomaLoader = new SomaLoader();
loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
var item:SomaLoaderItem = loader.add("fonts.swf");
item.registerFontClassName(["CourierNew", "Symbol"]);
loader.start();

function itemComplete(event:SomaLoaderEvent):void {
    var fonts:Array = e.item.fileFonts;
    for each (var font:Font in fonts) {
        trace("font available: " + font.fontName);
    }
}
```