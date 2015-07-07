### Introduction ###

SomaLoader allows you to easily manage the queue even if the status of the loader is SomaLoader.STATUS\_LOADING.

If the loader is currently loading, you wont be able to remove or change the item position that is at the index 0, you'll need to pause the loader to do so.

### Listen to changes ###

See the SomaLoaderEvent.QUEUE\_CHANGED in the [Events page](http://code.google.com/p/somaloader/wiki/Events).

### Access to the queue ###

You can change the queue by accessing it with some properties and methods of the SomaLoader instance:

```
// get the item that is currently loading
loader.currentItem;
// get all the items in the queue (copy)
loader.items;
// get the length of the queue
loader.length;

// add an item at the end of the queue:
loader.add("photo.jpg");
// add an item at a position:
loader.addAt("photo.jpg", 2); // constrained in the queue length
// add a binary item
loader.addBinary(item);
// add a binary item at a position
loader.addBinaryAt(item, 2);

// find if an item is in the queue, based on the url
loader.contains("photo.jpg");
// get the position of an item based on the url (-1 if not found)
loader.getIndex("photo.jpg");
// set a new position for an item based on the url
loader.setIndex("photo.jpg", 2);
// get an item based on the url
loader.getItem("photo.jpg");
// get an item at a specific position
loader.getItemAt(0);
// get the last item added to the queue
loader.getLastItem();

// remove an item based on the url
loader.remove("photo.jpg");
// remove all the items (if the loader is currently loading one, this item won't be removed)
loader.removeAll();
// remove an item based on the url at a specific position
loader.removeAt(2);
```