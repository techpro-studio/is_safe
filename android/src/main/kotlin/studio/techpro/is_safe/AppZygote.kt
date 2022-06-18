package studio.techpro.is_safe

import android.annotation.TargetApi
import android.app.ZygotePreload
import android.content.pm.ApplicationInfo
import android.os.Build

@TargetApi(Build.VERSION_CODES.Q)
class AppZygote : ZygotePreload {
    override fun doPreload(appInfo: ApplicationInfo) {
        System.loadLibrary("native-lib")
    }
}
