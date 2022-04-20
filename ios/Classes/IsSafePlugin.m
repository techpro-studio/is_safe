#import "IsSafePlugin.h"
#import "JB.h"

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
    result(@(isSecurityCheckPassed()));
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
