library download_network_images_for_offline;

import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class NetworkImageForOffline extends StatefulWidget {
  final File file;
  final String url;

  final bool debug;
  const NetworkImageForOffline({
    @required this.file,
    @required this.url,
    this.debug = false,
  });

  @override
  _NetworkImageForOfflineState createState() => _NetworkImageForOfflineState();
}

class _NetworkImageForOfflineState extends State<NetworkImageForOffline> {
  bool isOffline;
  dynamic element;

  @override
  void initState() async {
    super.initState();

    ConnectivityResult connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      isOffline = true;
    } else {
      isOffline = false;
    }

    if (isOffline) {
      if (await widget.file.exists()) {
        setState(() {
          element = new Image.file(widget.file);
        });
      } else {
        if (widget.debug) print('ERR: Offline and file ${widget.file} not found!');
      }
    } else if (!isOffline) {
      setState(() {
        element = NetworkImage(widget.url);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return element == null ? CircularProgressIndicator() : element;
  }
}
