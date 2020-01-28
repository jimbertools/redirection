#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface RedirectionPlugin : NSObject<FlutterPlugin>
@end

@interface UISystemNavigationAction : NSObject
@property(nonatomic, readonly, nonnull) NSArray<NSNumber*>* destinations;
-(BOOL)sendResponseForDestination:(NSUInteger)destination;
@end