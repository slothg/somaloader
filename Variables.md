### Introduction ###

You can easily use SomaLoader to send and get variables to a server.

### Send and load data ###

```
var loader:SomaLoader = new SomaLoader();
loader.addEventListener(SomaLoaderEvent.COMPLETE, requestComplete);
var item:SomaLoaderItem = loader.add("http://www.domain.com/file.php");
item.variables = new URLVariables();
item.variables.day = "Monday";
item.variables.year = "2009";
item.request.method = URLRequestMethod.POST;
// you can specify that you will receive url-encoded variables:
// item.dataFormat = URLLoaderDataFormat.VARIABLES;
// the default is URLLoaderDataFormat.TEXT (to receive xml, string, etc)

function requestComplete(event:SomaLoaderEvent):void {
    // the result is event.item.file as usual
    // the result can be anything that the server will send
    // if the dataFormat of the item has been set to URLLoaderDataFormat.VARIABLES
    // event.item.data will be an instance of URLVariables
}
```