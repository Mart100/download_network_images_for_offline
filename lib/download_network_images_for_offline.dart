library download_network_images_for_offline;

import 'dart:io';
import 'package:http/http.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

/// The main class for using download_network_images_for_offline
class NetworkImageForOffline extends StatefulWidget {
  /// Takes a File class, the file defines where it should download/save the image.
  final File file;

  /// Takes a simple string to the network image location. Just like the NetworkImage class.
  final String url;

  /// Takes a function that returns 2 arguments (context, ImageProvider)
  /// You can return a widget that requires the imageProvider.
  /// Take a look at the Usage in the README, Or example to see how its used
  final _ImageBuilderType imageBuilder;

  final bool debug;
  const NetworkImageForOffline({
    @required this.file,
    @required this.url,
    @required this.imageBuilder,
    this.debug = false,
  });

  @override
  _NetworkImageForOfflineState createState() => _NetworkImageForOfflineState();
}

typedef _ImageBuilderType<T>(BuildContext context, ImageProvider imageProvider);

class _NetworkImageForOfflineState extends State<NetworkImageForOffline> {
  bool isOffline;
  ImageProvider imageProvider = AssetImage('assets/placeholder.gif');

  @override
  void initState() {
    super.initState();

    _loadImage();
  }

  void _loadImage() async {
    // get connectivity
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());

    isOffline = (connectivityResult == ConnectivityResult.none);

    // when user if offline
    if (isOffline) {
      // if downloaded file is avaible
      if (await widget.file.exists()) {
        setState(() {
          imageProvider = Image.file(widget.file).image;
        });
      }

      // otherwise error
      else {
        if (widget.debug) print('ERR: Offline and file ${widget.file} not found!');
      }

      // when user is online
    } else if (!isOffline) {
      setState(() {
        imageProvider = NetworkImage(widget.url);
      });

      // download image if not downloaded yet
      if (await widget.file.exists() == false) {
        Response response = await get(Uri.parse(widget.url));
        widget.file.writeAsBytesSync(response.bodyBytes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.imageBuilder(context, imageProvider);
  }
}
