//
// Created by Oleksii Moisieienko on 13.06.2022.
//

#include <jni.h>
#include <unistd.h>

#include "fcntl.h"
#include "native-lib.h"

#if __cplusplus
extern "C" {
#endif


bool detect_frida();

static jint su = -1;

__attribute__((__constructor__, __used__))
static void before_load() {
    char *path = getenv("PATH");
    char *p = strtok(path, ":");
    char supath[PATH_MAX];
    do {
        sprintf(supath, "%s/su", p);
        if (access(supath, F_OK) == 0) {
            LOGI("DETECTED su path %s", supath);
            su = 0;
        }
    } while ((p = strtok(NULL, ":")) != NULL);
}

JNIEXPORT jint JNICALL
Java_studio_techpro_is_1safe_Native_00024Companion_isSu(JNIEnv *env, jobject thiz) {
    return su;
}

JNIEXPORT jboolean JNICALL
Java_studio_techpro_is_1safe_Native_00024Companion_detectFrida(JNIEnv *env, jobject thiz) {
    return detect_frida();
}

#if __cplusplus
}
#endif


