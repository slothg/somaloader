### Introduction ###

SomaLoader has only one event class and only one class that is dispatching them, it makes easier to use. The event class is SomaLoaderEvent.

### Events list ###

Here is a list of events type you can listen to:

```
// dispatched for a single item event
SomaLoaderEvent.START
SomaLoaderEvent.PROGRESS
SomaLoaderEvent.COMPLETE
// dispatched for the queue event
SomaLoaderEvent.QUEUE_START
SomaLoaderEvent.QUEUE_PROGRESS
SomaLoaderEvent.QUEUE_COMPLETE
// change in SomaLoader
SomaLoaderEvent.QUEUE_CHANGED
SomaLoaderEvent.STATUS_CHANGED
SomaLoaderEvent.CACHE_CHANGED
// Error
SomaLoaderEvent.ERROR
// dispatched when you load MP3
SomaLoaderEvent.ID3_COMPLETE
```

### Events use ###

Here is how to listen to the events and what the information you get:

```
// instantiate
var loader:SomaLoader = new SomaLoader();
// add events listeners:
loader.addEventListener(SomaLoaderEvent.START, itemStart);
loader.addEventListener(SomaLoaderEvent.PROGRESS, itemProgress);
loader.addEventListener(SomaLoaderEvent.COMPLETE, itemComplete);
loader.addEventListener(SomaLoaderEvent.QUEUE_START, queueStart);
loader.addEventListener(SomaLoaderEvent.QUEUE_PROGRESS, queueProgress);
loader.addEventListener(SomaLoaderEvent.QUEUE_COMPLETE, queueComplete);
loader.addEventListener(SomaLoaderEvent.QUEUE_CHANGED, queueChanged);
loader.addEventListener(SomaLoaderEvent.STATUS_CHANGED, statusChanged);
loader.addEventListener(SomaLoaderEvent.CACHE_CHANGED, cacheChanged);
loader.addEventListener(SomaLoaderEvent.ERROR, errorHandler);
loader.addEventListener(SomaLoaderEvent.ID3_COMPLETE, id3Handler);
// add items
loader.add("photo.jpg")
loader.add("movie.swf")
loader.add("sound.mp3")
// start loading
loader.start();

function itemStart(event):void {
    trace("start loading: ", event.item.url, ", type: ", event.item.type);
    trace("current SomaLoaderInstance: ", event.loader);
    trace("current built-in loader: ", event.loader.currentLoader);
}

function itemProgress(event):void {
    trace("item info: ", event.item.info());
    trace("progress: ", event.percentItem);
    trace("bytes loaded: ", event.bytesLoaded);
    trace("bytes total: ", event.bytesTotal);
}

function itemComplete(event):void {
    trace("item loaded: ", event.item.url, ", type: ", event.item.type);
    trace("current position: ", event.count);
    trace("length of the queue: ", event.length);
}

function queueStart(event):void {
    trace("start loading the queue");
}

function queueProgress(event):void {
    trace("current item: ", event.item.url);
    trace("progress: ", event.percentQueue);
}

function queueComplete(event):void {
    trace("All the items have been loaded");
    var itemsInCache:Dictionary = event.loader.getLoadedItems();
    // this is automatically done after each item complete, but you can dispose the loader:
    event.loader.dispose();
    // better to disable the cache before loading if you don't want to use it,
    // but if you want to clear it:
    event.loader.dispose(true);
    // or:
    event.loader.clearCache();
}

function queueChanged(event):void {
    trace("the queue changed");
    trace("length of the queue: ", event.length);
    var itemsInQueue:Array = event.loader.items;
}

function statusChanged(event):void {
    trace("the status of the SomaLoader instance changed");
    switch (event.loader.status) {
        case SomaLoader.STATUS_LOADING:
            trace("loading, you can use loader.pause() or loader.stop()");
            break;
        case SomaLoader.STATUS_PAUSED
            trace("paused, you can use loader.resume() or loader.stop()");
            break;
        case SomaLoader.STATUS_STOPPED:
            trace("loading, you can use loader.start()");
            break;
}

function cacheChanged(event):void {
    trace("the cache of the SomaLoader instance changed");
    trace("length of the cache: ", event.loader.cacheLength);
    var itemsInCache:Dictionary = event.loader.getLoadedItems();
}

function errorHandler(event):void {
   trace("error: ", event.errorMessage);
}

function id3Handler(event):void {
    trace("a MP3 is in the queue, ID3 received:\n");
    for (var id:String in e.id3Info) {
        trace("Tag: ", id, " = ", e.id3Info[id]); 
    }
}

```
