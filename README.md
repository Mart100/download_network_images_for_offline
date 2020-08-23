# download_network_images_for_offline

A flutter plugin to use Network Images and store them locally incase the user is offline.
#### In more detail:
NetworkImageForOffline will check for internet access, 
when it has internet access it will use the networkImage and download the file if it has not been downloaded yet.
If internet access is not available it will use the downloaded file, when that file was not installed yet it will show a loading placeholder.


#### Arguments:
This package provides the NetworkImageForOffline package,
It takes 3 required arguments: file, url, imageBuilder

The file arguments takes a File class, the file defines where it should download the image.

The url argument takes a simple string to where the network image is defined.

The imageBuilder takes a function that returns 2 arguments (context, ImageProvider)
You can return a widget that requires the imageProvider.




## Install:
Add to pubspec.yaml dependencies:
```yaml
dependencies:
 download_network_images_for_offline: ^0.0.4
```

## Example:

```dart
ListView(
 children: <Widget>[
  NetworkImageForOffline(
   file: File('./'),
   url: 'https://i.imgur.com/ViZKPUs.jpeg',
   imageBuilder: (BuildContext context, ImageProvider imageProvider) {
    return ListTile(
     leading: CircleAvatar(
      backgroundImage: imageProvider,
     ),
     title: Text('Hello'),
    );
   },
  ),
 ],
),
```
