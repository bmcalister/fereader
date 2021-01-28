import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fereader/fereader.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();

    Fereader.setConfig(
        nightMode: true,
        themeColor: Color.fromRGBO(102, 199, 173, 1),
        scrollDirection: EpubScrollDirection.HORIZONTAL);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Open Book'),
              onPressed: () async {
                String filename = "1book.epub";
                String dir = (await getApplicationDocumentsDirectory()).path +
                    "/" +
                    filename;

                final file = File(dir);
                final a = Directory(dir);
                if (file.existsSync()) {
                  file.deleteSync(recursive: true);
                }
                if (a.existsSync()) {
                  a.deleteSync(recursive: true);
                }

                String url =
                    "https://standardebooks.org/ebooks/f-scott-fitzgerald/the-great-gatsby/downloads/f-scott-fitzgerald_the-great-gatsby.epub";
                downloadFile(url, dir, (fp) {
                  Fereader.open(dir);
                }, () {});
              },
            )
          ],
        )),
      ),
    );
  }

  downloadFile(
      String url, String filepath, Function(String) success, Function error) {
    Dio dio = new Dio();
    dio.download(url, filepath)
      ..then((value) {
        success(filepath);
      })
      ..catchError((e) {
        print(e);
        error();
      });
  }
}
