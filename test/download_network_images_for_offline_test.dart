import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:download_network_images_for_offline/download_network_images_for_offline.dart';

void main() {
  testWidgets('NetworkImageForOffline Runs', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: <Widget>[
              NetworkImageForOffline(
                file: File('./'),
                url: 'https://i.imgur.com/5o2jOe0.png',
                imageBuilder:
                    (BuildContext context, ImageProvider imageProvider) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                    title: Text('Test-Text'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    final titleFinder = find.text('Test-Text');
    final circleAvatarFinder = find.byType(CircleAvatar);
    final networkImageForOfflineFinder = find.byType(NetworkImageForOffline);

    expect(titleFinder, findsOneWidget);
    expect(circleAvatarFinder, findsOneWidget);
    expect(networkImageForOfflineFinder, findsOneWidget);
  });
}
