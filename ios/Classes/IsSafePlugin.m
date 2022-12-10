#import <TargetConditionals.h>

#import "IsSafePlugin.h"
#if TARGET_CPU_ARM64
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
    #if TARGET_CPU_ARM64
        result(@(isSecurityCheckPassed()));
    #else
        result(@(YES));
    #endif
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end

