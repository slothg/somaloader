### Introduction ###

In some cases you might have tons of pictures to load, for a portfolio, for backgrounds or whatever. When you use the built-in class flash.display.Loader to load items, it can be quite CPU intensive as the Loader will instantiate a Bitmap (or a MovieClip) for each item loaded.

If you are not displaying all the images straight away, or if you are loading a kind of "library" for a later use in a site, it might be efficient to proceed in another way.

The idea behind "silent loading" is loading the images without instantiating a Bitmap each time, load them as Binary file (ByteArray) and create a Bitmap (or MovieClip) only when you need to show one. Loading a lot of images in a binary way to show all of them once loaded is not making sense, a basic loading will do the same.

SomaLoader is making your life easier to load items in this way.

### Load binary data ###

Here is how to load binary data and store them as ByteArray in a SomaLoaderItem (item.fileBinary), this example load a bunch of images for later use:

```
var loader:SomaLoader = new SomaLoader();
loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
for (var i:int=0; i<50; i++) {
    var item:SomaLoaderItem = loader.add("photo" + i + ".jpg");
    item.dataFormat = URLLoaderDataFormat.BINARY;
    // or:
    // loader.add("photo" + i + ".jpg", null, null, null, URLLoaderDataFormat.BINARY);
}
loader.start();

function itemComplete(event:SomaLoaderEvent):void {
    trace("binary data: ", event.item.fileBinary);
}
```

Nothing is displayed at this moment but the data are loaded and stored in the SomaLoader instance if the cache is enabled (true by default). If the cache is not enabled, you can still store the SomaLoaderItem items yourself.

The process to show a Bitmap (or MovieClip) when you have an item containing a ByteArray looks like another loading as it is done with the SomaLoader instance, but this process is taking no time (the data are already loaded).

Here is how to show an item from Binary data:

```
loader.addBinary(item);
loader.start();

function itemComplete(event:SomaLoaderEvent):void {
    var bitmap:Bitmap = event.item.file as Bitmap;
    addChild(bitmap);
}
```