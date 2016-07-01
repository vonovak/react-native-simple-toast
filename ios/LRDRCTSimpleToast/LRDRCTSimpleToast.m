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

NSInteger const LRDRCTSimpleToastBottomOffset = 28;
double const LRDRCTSimpleToastShortDuration = 3.0;
double const LRDRCTSimpleToastLongDuration = 5.0;

@interface LRDRCTSimpleToast : NSObject <RCTBridgeModule>
@end

@implementation LRDRCTSimpleToast

RCT_EXPORT_MODULE()

- (NSDictionary *)constantsToExport {
    return @{
             @"SHORT": [NSNumber numberWithDouble:LRDRCTSimpleToastShortDuration],
             @"LONG": [NSNumber numberWithDouble:LRDRCTSimpleToastLongDuration]
             };
}

RCT_EXPORT_METHOD(show:(NSString *)msg duration:(double)duration {
    [self _show:msg duration:duration];
});

- (void)_show:(NSString *)msg duration:(NSTimeInterval)duration {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *root = [[[[[UIApplication sharedApplication] delegate] window] rootViewController] view];
        CGRect bound = root.bounds;
        if (bound.size.height > LRDRCTSimpleToastBottomOffset) {
            bound.size.height -= LRDRCTSimpleToastBottomOffset;
        }
        UIView *view = [[UIView alloc] initWithFrame:bound];
        view.userInteractionEnabled = NO;
        [root addSubview:view];
        UIView __weak *blockView = view;
        [view makeToast:msg
            duration:duration
            position:[CSToastManager defaultPosition]
            title:nil
            image:nil
            style:nil
            completion:^(BOOL didTap) {
                [blockView removeFromSuperview];
            }];
    });
}

@end

