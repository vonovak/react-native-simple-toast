#ifdef RCT_NEW_ARCH_ENABLED
#import "RTNSimpleToastSpec.h"   //----
#endif

#import "RTNSimpleToast.h"
#import <UIKit/UIKit.h>
#import <React/RCTBridgeModule.h>
#import "UIView+Toast.h"
#import <React/RCTUtils.h>

NSInteger const RTNSimpleToastBottomOffset = 40;
double const RTNSimpleToastShortDuration = 3.0;
double const RTNSimpleToastLongDuration = 5.0;

@implementation RTNSimpleToast {
    CGFloat _kbdHeight;
}

- (instancetype)init {
    if (self = [super init]) {
        _kbdHeight = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)keyboardDidShow:(NSNotification *)notification {
    CGSize keyboardSize = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    int height = MIN(keyboardSize.height, keyboardSize.width);
    
    _kbdHeight = height;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _kbdHeight = 0;
}


RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport {
    return @{
             @"SHORT": @(RTNSimpleToastShortDuration),
             @"LONG": @(RTNSimpleToastLongDuration),
             @"BOTTOM": CSToastPositionBottom,
             @"CENTER": CSToastPositionCenter,
             @"TOP": CSToastPositionTop
             };
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

RCT_EXPORT_METHOD(show:(NSString *)msg
                  duration:(double)duration
                  viewControllerBlacklist:(nullable NSArray<NSString*>*) viewControllerBlacklist {
  [self _show:msg duration:duration gravity:(NSString *)CSToastPositionBottom viewControllerBlacklist:viewControllerBlacklist];

});

RCT_EXPORT_METHOD(showWithGravity:(NSString *)msg
                  duration:(double)duration
                  gravity:(nonnull NSString *)gravity
                  viewControllerBlacklist: (nullable NSArray<NSString*>*) viewControllerBlacklist {
  [self _show:msg duration:duration gravity:gravity viewControllerBlacklist:viewControllerBlacklist];
});

- (void)_show:(NSString *)msg
     duration:(NSTimeInterval)duration
      gravity:(nonnull NSString *)gravity
viewControllerBlacklist:(nullable NSArray<NSString*>*) viewControllerBlacklist {
    dispatch_async(dispatch_get_main_queue(), ^{
      UIViewController* presentedViewController = [self getViewControllerBlacklisted: viewControllerBlacklist];
      UIView * view = [self getToastView:presentedViewController];
        UIView __weak *blockView = view;
        [view makeToast:msg
               duration:duration
               position:gravity
                  title:nil
                  image:nil
                  style:nil
             completion:^(BOOL didTap) {
                 [blockView removeFromSuperview];
             }];
    });
}

- (UIViewController*) getViewControllerBlacklisted: (nullable NSArray<NSString*>*) viewControllerBlacklist {
  if (RCTRunningInAppExtension()) {
    return nil;
  }

  UIViewController *controller = RCTKeyWindow().rootViewController;
  UIViewController *presentedController = controller.presentedViewController;
  while (presentedController && ![presentedController isBeingDismissed]
         && ![RTNSimpleToast isBlacklisted:presentedController blacklist:viewControllerBlacklist]) {
    controller = presentedController;
    presentedController = controller.presentedViewController;
  }

  return controller;
}

+(BOOL) isBlacklisted: (UIViewController*) ctrl blacklist:(nullable NSArray<NSString*>*) viewControllerBlacklist {
  if (!viewControllerBlacklist) {
    return NO;
  }
  for (NSString* className in viewControllerBlacklist) {
    Class blacklistedClass = NSClassFromString(className);
    if ([ctrl isKindOfClass:blacklistedClass]) {
      return YES;
    }
  }
  return NO;
}

- (UIView *)getToastView: (UIViewController*) ctrl {
    UIView *root = [ctrl view];
    CGRect bound = root.bounds;
    bound.size.height -= self->_kbdHeight;
    if (bound.size.height > RTNSimpleToastBottomOffset*2) {
        bound.origin.y += RTNSimpleToastBottomOffset;
        bound.size.height -= RTNSimpleToastBottomOffset*2;
    }
    UIView *view = [[UIView alloc] initWithFrame:bound];
    view.userInteractionEnabled = NO;
    [root addSubview:view];
    return view;
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule: //----
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeSimpleToastSpecJSI>(params);
}
#endif

@end