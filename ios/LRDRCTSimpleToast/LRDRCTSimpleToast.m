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

NSInteger const LRDRCTSimpleToastBottomOffset = 40;
double const LRDRCTSimpleToastShortDuration = 3.0;
double const LRDRCTSimpleToastLongDuration = 5.0;
NSInteger const LRDRCTSimpleToastGravityBottom = 1;
NSInteger const LRDRCTSimpleToastGravityCenter = 2;
NSInteger const LRDRCTSimpleToastGravityTop = 3;

@interface LRDRCTSimpleToast : NSObject <RCTBridgeModule>
@end

@implementation LRDRCTSimpleToast {
    CGFloat _keyOffset;
}

- (instancetype)init {
    if (self = [super init]) {
        _keyOffset = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHiden:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)keyboardWasShown:(NSNotification *)notification {
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    int height = MIN(keyboardSize.height,keyboardSize.width);
    int width = MAX(keyboardSize.height,keyboardSize.width);
    
    _keyOffset = height;
}

- (void)keyboardWillHiden:(NSNotification *)notification {
    _keyOffset = 0;
}


RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport {
    return @{
             @"SHORT": [NSNumber numberWithDouble:LRDRCTSimpleToastShortDuration],
             @"LONG": [NSNumber numberWithDouble:LRDRCTSimpleToastLongDuration],
             @"BOTTOM": [NSNumber numberWithInteger:LRDRCTSimpleToastGravityBottom],
             @"CENTER": [NSNumber numberWithInteger:LRDRCTSimpleToastGravityCenter],
             @"TOP": [NSNumber numberWithInteger:LRDRCTSimpleToastGravityTop]
             };
}

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

RCT_EXPORT_METHOD(show:(NSString *)msg duration:(double)duration {
    [self _show:msg duration:duration gravity:LRDRCTSimpleToastGravityBottom];
});

RCT_EXPORT_METHOD(showWithGravity:(NSString *)msg duration:(double)duration gravity:(nonnull NSNumber *)gravity{
    [self _show:msg duration:duration gravity:gravity.intValue];
});

- (UIViewController *)visibleViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil)
    {
        return rootViewController;
    }
    if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        
        return [self visibleViewController:lastViewController];
    }
    if ([rootViewController.presentedViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController.presentedViewController;
        UIViewController *selectedViewController = tabBarController.selectedViewController;
        
        return [self visibleViewController:selectedViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    
    return [self visibleViewController:presentedViewController];
}

- (void)_show:(NSString *)msg duration:(NSTimeInterval)duration gravity:(NSInteger)gravity {
    dispatch_async(dispatch_get_main_queue(), ^{
        //UIView *root = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
        UIViewController *ctrl = [self visibleViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
        UIView *root = [ctrl view];
        CGRect bound = root.bounds;
        bound.size.height -= _keyOffset;
        if (bound.size.height > LRDRCTSimpleToastBottomOffset*2) {
            bound.origin.y += LRDRCTSimpleToastBottomOffset;
            bound.size.height -= LRDRCTSimpleToastBottomOffset*2;
        }
        UIView *view = [[UIView alloc] initWithFrame:bound];
        view.userInteractionEnabled = NO;
        [root addSubview:view];
        UIView __weak *blockView = view;
        id position;
        if (gravity == LRDRCTSimpleToastGravityTop) {
            position = CSToastPositionTop;
        } else if (gravity == LRDRCTSimpleToastGravityCenter) {
            position = CSToastPositionCenter;
        } else {
            position = CSToastPositionBottom;
        }
        [view makeToast:msg
            duration:duration
            position:position
            title:nil
            image:nil
            style:nil
            completion:^(BOOL didTap) {
                [blockView removeFromSuperview];
            }];
    });
}

@end

