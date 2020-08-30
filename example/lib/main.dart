import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:download_network_images_for_offline/download_network_images_for_offline.dart';

String externalStorageDir;
void main() async {
  Directory dir = await getExternalStorageDirectory();
  externalStorageDir = dir.path;

  // ensure file dir exists
  final offlineImagesDir = Directory(externalStorageDir + '/offlineImages');
  bool offlineImagesDirExists = await offlineImagesDir.exists();
  if (!offlineImagesDirExists) offlineImagesDir.create();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> images = ["WTlQ0sW", "ViZKPUs", "7saRqmV", "mUbOPfz"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: ListView.builder(
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            String imageID = images[index];

            return NetworkImageForOffline(
              file: File('$externalStorageDir/offlineImages/$imageID.jpeg'),
              url: 'https://i.imgur.com/$imageID.png',
              imageBuilder: (BuildContext context, ImageProvider imageProvider) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: imageProvider,
                  ),
                  title: Text('Test-Text'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
