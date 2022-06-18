package studio.techpro.is_safe

class Native {

    companion object {

        external fun detectFrida(): Boolean
        external fun isSu(): Int

        init {
            try {
                System.loadLibrary("native-lib")
            } catch (e: Exception){
                print("Error $e");
            }
        }
    }
}