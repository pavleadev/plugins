#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// Regression test for https://github.com/flutter/flutter/issues/10106
- (BOOL)application:(UIApplication *)application
              openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication
           annotation:(id)annotation {
  return [super application:application
                    openURL:url
          sourceApplication:sourceApplication
                 annotation:annotation];
}
@end
