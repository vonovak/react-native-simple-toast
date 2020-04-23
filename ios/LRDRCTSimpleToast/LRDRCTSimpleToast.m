//
//  LRDRCTSimpleToast.m
//  LRDRCTSimpleToast
//
//  Created by luoruidong on 16/6/30.
//  Copyright © 2016年 luoruidong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RCTBridgeModule.h"
#import "UIView+Toast.h"
#import <React/RCTUtils.h>

NSInteger const LRDRCTSimpleToastBottomOffset = 40;
double const LRDRCTSimpleToastShortDuration = 3.0;
double const LRDRCTSimpleToastLongDuration = 5.0;

@interface LRDRCTSimpleToast : NSObject <RCTBridgeModule>
@end

@implementation LRDRCTSimpleToast {
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
             @"SHORT": @(LRDRCTSimpleToastShortDuration),
             @"LONG": @(LRDRCTSimpleToastLongDuration),
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
  [self _show:msg duration:duration gravity:CSToastPositionBottom viewControllerBlacklist:viewControllerBlacklist];
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
         && ![LRDRCTSimpleToast isBlacklisted:presentedController blacklist:viewControllerBlacklist]) {
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
    if (bound.size.height > LRDRCTSimpleToastBottomOffset*2) {
        bound.origin.y += LRDRCTSimpleToastBottomOffset;
        bound.size.height -= LRDRCTSimpleToastBottomOffset*2;
    }
    UIView *view = [[UIView alloc] initWithFrame:bound];
    view.userInteractionEnabled = NO;
    [root addSubview:view];
    return view;
}

@end

