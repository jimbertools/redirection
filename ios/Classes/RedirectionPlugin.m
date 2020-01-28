#import "RedirectionPlugin.h"

@implementation RedirectionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"redirection"
            binaryMessenger:[registrar messenger]];
  RedirectionPlugin* instance = [[RedirectionPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"redirect" isEqualToString:call.method]) {
    Ivar sysNavIvar = class_getInstanceVariable(UIApplication.class, "_systemNavigationAction");
    UIApplication* app = UIApplication.sharedApplication;
    UISystemNavigationAction* action = object_getIvar(app, sysNavIvar);
    if (!action) {
        result(@"0");
    }
    NSUInteger destination = action.destinations.firstObject.unsignedIntegerValue;
    [action sendResponseForDestination:destination];
    result(@"1");
  }
  else {
    result(FlutterMethodNotImplemented);
  }
}

@end
