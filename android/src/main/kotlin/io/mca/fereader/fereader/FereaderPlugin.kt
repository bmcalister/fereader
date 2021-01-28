
package io.mca.fereader.fereader

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.lang.Boolean


/** EpubReaderPlugin  */
class FereaderPlugin: FlutterPlugin, MethodCallHandler {
  private var reader: Reader? = null
  private var config: ReaderConfig? = null
  private lateinit var channel : MethodChannel

  private var activity: Activity? = null
  private var context: Context? = null
  var messenger: BinaryMessenger? = null

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    if (call.method == "setConfig") {
      val arguments = call.arguments as Map<String, Any>
      val identifier = arguments["identifier"].toString()
      val themeColor = arguments["themeColor"].toString()
      val scrollDirection = arguments["scrollDirection"].toString()
      val nightMode = Boolean.parseBoolean(arguments["nightMode"].toString())
      val allowSharing = Boolean.parseBoolean(arguments["allowSharing"].toString())
      val enableTts = Boolean.parseBoolean(arguments["enableTts"].toString())
      config = ReaderConfig(context, identifier, themeColor,
              scrollDirection, allowSharing, enableTts, nightMode)
    } else if (call.method == "open") {
      val arguments = call.arguments as Map<String, Any>
      val bookPath = arguments["bookPath"].toString()
      val lastLocation = arguments["lastLocation"].toString()
      val reader = Reader(context, messenger, config)
      reader.open(bookPath, lastLocation)
    } else if (call.method == "close") {
      reader?.close()
    } else {
      result.notImplemented()
    }
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fereader")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
    messenger = flutterPluginBinding.binaryMessenger
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}


//package io.mca.fereader.fereader
//
//import androidx.annotation.NonNull
//
//import io.flutter.embedding.engine.plugins.FlutterPlugin
//import io.flutter.plugin.common.MethodCall
//import io.flutter.plugin.common.MethodChannel
//import io.flutter.plugin.common.MethodChannel.MethodCallHandler
//import io.flutter.plugin.common.MethodChannel.Result
//import io.flutter.plugin.common.PluginRegistry.Registrar
//
///** FereaderPlugin */
//class FereaderPlugin: FlutterPlugin, MethodCallHandler {
//  /// The MethodChannel that will the communication between Flutter and native Android
//  ///
//  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
//  /// when the Flutter Engine is detached from the Activity
//  private lateinit var channel : MethodChannel
//
//  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "fereader")
//    channel.setMethodCallHandler(this)
//  }
//
//  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }
//  }
//
//  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//    channel.setMethodCallHandler(null)
//  }
//}
