# Fereader

Inspired by [epub_viewer](https://github.com/JideGuru/epub_viewer) I made this to fit my needs.

## Install
This plugin requires `Swift` to work on iOS.
Also, the minimum deployment target is 9.0
```
platform :ios, '9.0'
```

Import into pubspec.yaml
```
dependencies:
  fereader: 0.0.1
```

Note: Please add this to the release build type in your app build.gradle to avoid crashes on android release builds
```
minifyEnabled false
shrinkResources false
```

# Usage
```dart
Fereader.setConfig(
  themeColor: Theme.of(context).primaryColor,
  identifier: "iosBook",
  scrollDirection: EpubScrollDirection.VERTICAL,
  allowSharing: true,
  enableTts: true,
)

/**
* @bookPath
* @lastLocation (optional and only android)
*/
Fereader.open(
  '/path/to/ebook.epub',
  lastLocation: EpubLocator.fromJson({
    "bookId": "2239",
    "href": "/OEBPS/ch06.xhtml",
    "created": 1539934158390,
    "locations": {
       "cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"
    }
  }), // first page will open up if the value is null
);

// Get locator which you can save in your database
EpubViewer.locatorStream.listen((locator) {
   print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
   // convert locator from string to json and save to your database to be retrieved later
});
 ```