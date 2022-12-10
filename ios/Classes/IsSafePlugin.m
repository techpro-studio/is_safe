#import <TargetConditionals.h>

#import "IsSafePlugin.h"
#if defined(__arm64__)
#import "JB.h"
#endif

@implementation IsSafePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"is_safe"
            binaryMessenger:[registrar messenger]];
  IsSafePlugin* instance = [[IsSafePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"isSafe" isEqualToString:call.method]) {
    // since it is ios 11 + it should be fine
    #if defined(__arm64__)
        result(@(isSecurityCheckPassed()));
    #else
        result(@(YES));
    #endif
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end

