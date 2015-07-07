### Introduction ###

You can set a custom object in a SomaLoaderItem instance to use it later, in an event listener for example, or to find an item the way you want.

This custom object can contains anything, a String, a Class, an Object, a Number, etc.

### Set a custom object ###

Here is how to set the custom object (data property of a SomaLoaderInstance):

```
var loader:SomaLoader = new SomaLoader();
var item:SomaLoaderItem = loader.add("photo.jpg");
item.data = {myID:1, whatever:"example"};
// or:
// loader.add("photo.jpg", null, null, {myID:1, whatever:"example"});
```

You can then access the data in an event listener:

```
function itemComplete(event:SomaLoaderItem):void {
    var data:Object = event.item.data;
    trace(data.myID, data.whatever);
}
```

Using an object as above (or a class), makes you able to find or remove an item from the cache easily:

```
var item:SomaLoaderItem = loader.getLoadedItemByOwnKey("myID", 1);
```
