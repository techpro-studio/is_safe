
package studio.techpro.is_safe

class FridaDetector {
    companion object {
        init {
            System.loadLibrary("native-lib")
        }
    }

    external fun detected(): Boolean
}