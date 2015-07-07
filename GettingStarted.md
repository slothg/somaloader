### Introduction ###

SomaLoader has been built following a "ease-of-use" guideline. It has many features and one of them is the queue management of a list of items to load.

A cache system is included in the library not to load twice the same item. If the cache management is completely automatic and transparent if you deploy your flash file for Flash Player 10, the cache is accessible for a Flash Player 9 version but requires some more code to check and access to the "cached" items.

You can create as many SomaLoader instance as you wish but having only one instance in your application will fully use the cache functionality.

I will add tutorials for every aspects of SomaLoader, let's see some simple syntax.

### Instantiate ###

```
import com.soma.loader.SomaLoader;

var loader:SomaLoader = new SomaLoader();
```

### Load a list of items ###

You can add, remove and change the items positions added in queue even while loading, example with some pictures:

```
import com.soma.loader.SomaLoader;

var loader:SomaLoader = new SomaLoader();
loader.add("photo1.jpg");
loader.add("photo2.jpg");
loader.add("photo3.jpg");
loader.start();
```

### SomaLoaderItem ###

When you add an item to the queue, an instance of the SomaLoaderItem class is created and returned. You can access to many options through this item.

```
var item:SomaLoaderItem = loader.add("photo1.jpg");
trace(item.type);
```

The current item can be retrieve that way in the events listeners:

```
function itemComplete(event:SomaLoaderEvent):void {
   var item:SomaLoaderItem = event.item;
}
```

### Get the data ###

All the events dispatched by SomaLoader are SomaLoaderEvent instances. SomaLoader will dispatch events related to each item loaded, the queue and some other events more specific.

The files loaded will be stored in the SomaLoaderItem and can be retrieve with the untyped property "file" for most of the type of loading, "fileBinary" for binary data (ByteArray), and "fileFonts" for a SWF containing fonts.

Get the data loaded:

```
import com.soma.loader.SomaLoader;
import com.soma.loader.SomaLoaderEvent;

var loader:SomaLoader = new SomaLoader();
loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
loader.add("photo1.jpg");
loader.start();

function itemComplete(event:SomaLoaderEvent):void {
    var bitmap:Bitmap = event.item.file as Bitmap;
    addChild(bitmap);
}
```

### Queue complete ###

If you load a list of items, you can also listen to queue events:

```
import com.soma.loader.SomaLoader;
import com.soma.loader.SomaLoaderEvent;

var loader:SomaLoader = new SomaLoader();
loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
loader.addEventListener(SomaLoaderEvent.QUEUE_COMPLETE, queueComplete);
loader.add("photo1.jpg");
loader.add("photo2.jpg");
loader.add("photo3.jpg");
loader.start();

function itemComplete(event:SomaLoaderEvent):void {
    var bitmap:Bitmap = event.item.file as Bitmap;
    addChild(bitmap);
}

function queueComplete(event:SomaLoaderEvent):void {
    trace("All the items have been loaded");
}
```

### Types ###

SomaLoader understand will most of the time what you're loading (with the file extension of the URL) and set the "type" property of the SomaLoaderItem on its own. This type property can also be manually set.

The following example set the bitmap type of the item, only as an example as it is unnecessary in this case. Setting a wrong type to an item might give you errors as the Flash built-in loaders are not loading the same type of items.

```
var item:SomaLoaderItem = loader.add("photo1.jpg");
item.type = SomaLoader.TYPE_BITMAP;
```

Here is a list of the different type you can use:

```
SomaLoader.TYPE_BITMAP;
SomaLoader.TYPE_CSS;
SomaLoader.TYPE_FONT;
SomaLoader.TYPE_MP3;
SomaLoader.TYPE_SWF;
SomaLoader.TYPE_TEXT;
SomaLoader.TYPE_XML;
SomaLoader.TYPE_UNKNOWN;
```

It can be used in the events listeners to filter the items loaded, here are some examples.

```
import com.soma.loader.SomaLoader;
import com.soma.loader.SomaLoaderEvent;

var loader:SomaLoader = new SomaLoader();
loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
loader.add("photo1.jpg");
loader.add("movie.swf");
loader.add("data.xml");
loader.add("stylesheet.css");
loader.add("sound.mp3");
loader.add("info.txt");
loader.start();

function itemComplete(event:SomaLoaderEvent):void {
    var item:SomaLoaderItem = event.item;
    switch (item.type) {
        case SomaLoader.TYPE_BITMAP:
            var bitmap:Bitmap = item.file as Bitmap;
            break;
        case SomaLoader.TYPE_SWF:
            var movie:MovieClip = item.file as MovieClip;
            break;
        case SomaLoader.TYPE_XML:
            var xml:XML = new XML(item.file);
            break;
        case SomaLoader.TYPE_CSS:
            var stylesheet:StyleSheet = new StyleSheet();
            stylesheet.parseCSS(item.file);
            break;
        case SomaLoader.TYPE_MP3:
            var sound:Sound = item.file as Sound;
            break;
        case SomaLoader.TYPE_TEXT:
            var txt:String = item.file as String;
            break;
    }
}
```