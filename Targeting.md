### Introduction ###

SomaLoader allows you to "target" the file you're loading and set a container (relevant for SWF and images loading), as well as setting properties on this container and the file loaded before the loading starts.

### Set a container ###

If you load an image or a SWF file, you can tell SomaLoader what to do with this file. For example you want to load an image and add this image to the display list of a Sprite container, you dont have to listen to an event to do so.

```
var loader:SomaLoader = new SomaLoader();
var spriteContainer:Sprite = new Sprite();
addChild(spriteContainer);
loader.add("photo1.jpg", spriteContainer);
// or:
var item:SomaLoader = loader.add("photo2.jpg");
item.container = spriteContainer;
loader.start();
```

Here is a shortcut:

```
loader.add("sdfasdf", addChild(new Sprite) as Sprite)
```

### Set properties ###

You can also set properties both on the container and on the file loaded before loading. Let's say you want to scale down the container of an image and set some properties straight on the file.

```
var loader:SomaLoader = new SomaLoader();
var item:SomaLoaderItem = loader.add("photo1.jpg", addChild(new Sprite) as Sprite);
// container properties
item.addContainerProperty("scaleX", .4);
item.addContainerProperty("scaleY", .4);
// bitmap properties
item.addFileProperty("alpha", .5);
item.addFileProperty("blendMode", BlendMode.MULTIPLY);
loader.start();
```