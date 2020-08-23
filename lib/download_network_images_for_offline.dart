library download_network_images_for_offline;

import 'dart:io';
import 'package:http/http.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkImageForOffline extends StatefulWidget {
  final File file;
  final String url;
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

    loadImage();
  }

  void loadImage() async {
    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isOffline = true;
    } else {
      isOffline = false;
    }

    if (isOffline) {
      if (await widget.file.exists()) {
        setState(() {
          imageProvider = Image.file(widget.file).image;
        });
      } else {
        if (widget.debug) print('ERR: Offline and file ${widget.file} not found!');
      }
    } else if (!isOffline) {
      setState(() {
        imageProvider = NetworkImage(widget.url);
      });

      if (await widget.file.exists() == false) {
        Response response = await get(widget.url);
        widget.file.writeAsBytesSync(response.bodyBytes);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.imageBuilder(context, imageProvider);
  }
}
