### Introduction ###

The cache system in SomaLoader is a very interesting part and well-used can be very efficient for the users. The cache is by default enabled and every time an item is loaded, it will be stored in the cache.

They are different ways to handle SomaLoader instances in your application. If I take a simple example like a Flash site with pages, you could create a SomaLoader instance in each page. This is fine but you won't really use the cache feature. Instead, if you create only one loader for all your site and use it in every page, this will become very powerful.

First thing to understand, there are different behaviors depending if you deploy your application for Flash Player 9 or 10. If the same result can be reached in each version, it will require more code for the Flash Player 9 version.

Let's first talk about the benefit of the Flash Player 10 behavior.

### Flash Player 10 ###

In Flash Player 10, the cache system is easy: everything is automatic and transparent.

Here is how it works.

Let's say at some points you will load some pictures (in a page for example), you will use your global SomaLoader instance, add some URL, add some listeners and start to load.

```
loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
loader.add("photo0.jpg");
loader.add("photo1.jpg");
loader.start();

function itemComplete(event:SomaLoaderEvent):void {
   // handle my item loaded
   var bitmap:Bitmap = event.item.file as Bitmap;
}
```

The second time the user of your application comes back to this page, the same code will be executed. This second time, SomaLoader will figure out that you already have loaded the items and instead of calling the server to load again the items, SomaLoader will dispatch the same events with your item loaded. It means, the second time there is no server call at all and you will receive in you events listeners the data instantaneously. No Loading, no call server, nothing to wait and all of this without writing code to handle that.

### Flash Player 9 ###

For a Flash player 9, the loaded items will be stored in the same way. The difference is, when you load the same items a second time, SomaLoader won't use the cache on its own and dispatch the same events with the items loaded.

To reach the same result, you will have to write some conditions to test if the items exist it the cache, to load the items or use the items cached.

They are probably tons of way to write this "cache checking", here is an example how to achieve that:

```
testItemCache("photo0.jpg");
testItemCache("photo1.jpg");

if (loader.length > 0) {
    loader.addEventListener(SomaLoaderEvent.COMPLETE, queueComplete);
    loader.start();
}

function testItemCache(url:String):void {
    var cachedItem:SomaLoaderItem = loader.getLoadedItemByURL(url);
    if (cachedItem == null) loader.add("photo0.jpg"); // not cached, add to the loader
    else endLoading(cachedItem); // cached
}

function itemComplete(event:SomaLoaderEvent):void {
    endLoading(event.item);
}

function endLoading(item:SomaLoaderItem):void {
    // handle my item loaded
    var bitmap:Bitmap = item.file as Bitmap;
}
```

### Listen to changes ###

See the SomaLoaderEvent.CACHE\_CHANGED in the [Events page](http://code.google.com/p/somaloader/wiki/Events).

### Access to the cache ###

```
// get the length of the cache
loader.lengthCache;
// get all the items in the cache
loader.getLoadedItems();
// get an item in the cache by the URL
loader.getLoadedItemByURL("photo.jpg");
// get an item in the cache by your own key, example: item.data = {myID:1}
loader.getLoadedItemByOwnKey("myID", 1);
// get all the items in the cache containing binary data
loader.getBinaryLoadedItems();
// get all the items in the cache containing binary data, example here to get only items type Bitmap
loader.getBinaryLoadedItems(SomaLoader.TYPE_BITMAP);
// get an item in the cache containing binary data by URL
loader.getBinaryLoadedItemByURL("photo.jpg");
// get an item in the cache containing binary data by your own key, example: item.data = {myID:1}
loader.getBinaryLoadedItemByOwnKey("myID", 1);

// remove an item from the cache loaded
loader.removeItemLoaded(item);
// remove an item from the cache loaded by URL
loader.removeItemLoadedByURL("photo.jpg");
// remove an item from the cache loaded by your own key, example: item.data = {myID:1}
loader.removeItemLoadedByOwnKey("myID", 1);

// clear the cache
loader.clearCache(); // or: loader.dispose(true);
```

### Enable and disable the cache ###

For each item you can enable or disable the cache this way:

```
var loader:SomaLoader = new SomaLoader()
var item:SomaLoaderItem = loader.add("photo.jpg");
item.cacheEnabled = false;
// or: 
item.cacheEnabled = true;
```

You can also disable the default global setting. When you add an item to the queue, the cacheEnabled property value is set from this global value.

```
SomaLoader.DEFAULT_CACHE_ENABLED = false;
SomaLoader.DEFAULT_CACHE_ENABLED = true;
```

Note: if you change the global cache setting, it wont be applied to the items already in the queue.


