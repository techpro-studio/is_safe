package studio.techpro.is_safe

import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.ServiceConnection
import android.os.IBinder
import androidx.annotation.NonNull
import com.scottyab.rootbeer.RootBeer
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result


/** IsSafePlugin */
class IsSafePlugin: FlutterPlugin, MethodCallHandler, ServiceConnection{

  private var service: IRemoteService?=null
  private var result: Result?=null
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  lateinit var context: Context
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "is_safe")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
    val intent = Intent(context, RemoteService::class.java)
    context.bindService(intent, this, Context.BIND_AUTO_CREATE)
  }

  private fun getResult(): Boolean {
    val frida = Native.detectFrida();
    val isSu = service!!.haveSu();
    val rootBeer = RootBeer(context);
    val beerDetection = rootBeer.isRootedWithBusyBoxCheck;
    return !frida && !isSu && !beerDetection;
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "isSafe") {
      if (service == null) {
        this.result = result;
      } else {
        result.success(getResult())
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onServiceConnected(componentName: ComponentName?, binder: IBinder?) {
    service = IRemoteService.Stub.asInterface(binder)
    if (result != null) {
      result!!.success(getResult());
      result = null;
    }
  }

  override fun onServiceDisconnected(p0: ComponentName?) {
    service = null;
  }
}
