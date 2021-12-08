import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

part 'util/epub_locator.dart';
part 'util/util.dart';

class Fereader {
  static const MethodChannel _channel = const MethodChannel('fereader');

  static const EventChannel _pageChannel = const EventChannel('page');

  /// Configure Viewer's with available values
  ///
  /// themeColor is the color of the reader
  /// scrollDirection uses the [EpubScrollDirection] enum
  /// allowSharing
  /// enableTts is an option to enable the inbuilt Text-to-Speech
  static void setConfig(
      {Color themeColor = Colors.blue,
      String identifier = 'book',
      bool nightMode = false,
      EpubScrollDirection scrollDirection = EpubScrollDirection.HORIZONTAL,
      bool allowSharing = false,
      bool enableTts = false}) async {
    Map<String, dynamic> agrs = {
      "identifier": identifier,
      "themeColor": Util.getHexFromColor(themeColor),
      "scrollDirection": Util.getDirection(scrollDirection),
      "allowSharing": allowSharing,
      'enableTts': enableTts,
      'nightMode': nightMode
    };
    await _channel.invokeMethod('setConfig', agrs);
  }

  /// bookPath should be a local file.
  /// Last location is only available for android.
  static void open(String bookPath, {EpubLocator? lastLocation}) async {
    Map<String, dynamic> agrs = {
      "bookPath": bookPath,
      'lastLocation':
          lastLocation == null ? '' : jsonEncode(lastLocation.toJson()),
    };
    await _channel.invokeMethod('open', agrs);
  }

  /// Stream to get EpubLocator for android and pageNumber for iOS
  static Stream get locatorStream {
    Stream pageStream = _pageChannel
        .receiveBroadcastStream()
        .map((value) => Platform.isAndroid ? value : '{}');

    return pageStream;
  }
}

enum EpubScrollDirection { HORIZONTAL, VERTICAL }
