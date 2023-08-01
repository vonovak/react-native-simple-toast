#import "RNSimpleToast.h"

#import "UIView+Toast.h"
#import "RNToastViewController.h"
#import <React/RCTConvert.h>

static double defaultPositionId = 2.0;

static double const LRDRCTSimpleToastShortDuration = 2.0;
static double const LRDRCTSimpleToastLongDuration = 3.5;

static const NSDictionary *RNToastPositionMap = @{
        // just to conform to the same type of interface as android
        @(1): CSToastPositionTop,
        @(defaultPositionId): CSToastPositionBottom,
        @(3): CSToastPositionCenter,
};


@implementation RNSimpleToast {
    CGFloat _kbdHeight;
}

RCT_EXPORT_MODULE()

- (instancetype)init {
    if (self = [super init]) {
        _kbdHeight = 0;
        [CSToastManager setTapToDismissEnabled:NO];
        [CSToastManager setQueueEnabled:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardDidHideNotification
                                                   object:nil];
    }
    return self;
}

- (void)keyboardDidShow:(NSNotification *)notification {
    CGSize keyboardSize = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat height = keyboardSize.height;

    _kbdHeight = height;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    _kbdHeight = 0;
}

+ (BOOL)requiresMainQueueSetup {
    return NO;
}

- (NSDictionary*)constantsToExport {
    return @{
             @"SHORT": @(LRDRCTSimpleToastShortDuration),
             @"LONG": @(LRDRCTSimpleToastLongDuration),
             @"TOP": @(1),
             @"BOTTOM": @(2),
             @"CENTER": @(3),
             };
}

#ifdef RCT_NEW_ARCH_ENABLED
- (facebook::react::ModuleConstants<JS::NativeSimpleToast::Constants>)getConstants {
    return facebook::react::typedConstants<JS::NativeSimpleToast::Constants>(
            {
                .SHORT = LRDRCTSimpleToastShortDuration,
                .LONG = LRDRCTSimpleToastLongDuration,
                .TOP = 1,
                .BOTTOM = 2,
                .CENTER = 3,
            });
}
#endif

RCT_EXPORT_METHOD(show:(NSString *)message duration:(double)duration styles:(NSDictionary*)styles {
    [self _show:message duration:duration position:defaultPositionId offset:CGPointZero styles:styles];
});

RCT_EXPORT_METHOD(showWithGravity:(NSString *)message duration:(double)duration gravity:(double)gravity styles:(NSDictionary*)styles {
    [self _show:message duration:duration position:gravity offset:CGPointZero styles:styles];
});

RCT_EXPORT_METHOD(showWithGravityAndOffset:(NSString *)message duration:(double)duration gravity:(double)gravity xOffset:(double)xOffset yOffset:(double)yOffset styles:(NSDictionary*)styles {
    [self _show:message duration:duration position:gravity offset:CGPointMake(xOffset, yOffset) styles:styles];
});

- (void)_show:(NSString *)msg
     duration:(NSTimeInterval)duration
     position:(double)position
       offset:(CGPoint)offset
       styles:(NSDictionary*)styles {
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    if (styles[@"backgroundColor"]) {
        style.backgroundColor = [RCTConvert UIColor:styles[@"backgroundColor"]];
    }
    if (styles[@"messageColor"]) {
        style.messageColor = [RCTConvert UIColor:styles[@"messageColor"]];
    }


    NSString *positionString = RNToastPositionMap[@(position)] ?: CSToastPositionBottom;
    dispatch_async(dispatch_get_main_queue(), ^{
        RNToastViewController *controller = [RNToastViewController new];
        [controller show:^() {
            UIView *view = [self getToastView:controller];
            UIView __weak *weakView = view;
            RNToastViewController __weak *weakController = controller;

            UIView *toast = [view toastViewForMessage:msg title:nil image:nil style:style];

            void (^completion)(BOOL) = ^(BOOL didTap) {
                [weakView removeFromSuperview];
                [weakController hide];
            };
            if (!CGPointEqualToPoint(offset, CGPointZero)) {
                CGPoint centerWithOffset = [self getCenterWithOffset:offset view:view toast:toast position:positionString];
                [view showToast:toast duration:duration position:[NSValue valueWithCGPoint:centerWithOffset] completion:completion];
            } else {
                [view showToast:toast duration:duration position:positionString completion:completion];
            }
        }];
    });
}

- (CGPoint)getCenterWithOffset:(CGPoint)offset view:(UIView *)view toast:(UIView *)toast position:(NSString *)position {
    CGPoint toastCenter = [self rnToast_centerPointForPosition:position withToast:toast inView:view];
    toastCenter.x += offset.x;
    toastCenter.y += offset.y;
    toastCenter.x = MAX(toastCenter.x, toast.frame.size.width / 2);
    // centerCopy.x must be less than view's width minus toast's width divided by 2
    toastCenter.x = MIN(toastCenter.x, view.bounds.size.width - (toast.frame.size.width / 2));
    // centerCopy.y must be less than view's height minus toast's height divided by 2
    toastCenter.y = MIN(toastCenter.y, view.bounds.size.height - (toast.frame.size.height / 2));
    // centerCopy.y must be greater than toast's height divided by 2
    toastCenter.y = MAX(toastCenter.y, toast.frame.size.height / 2);
    return toastCenter;
}

- (CGPoint)rnToast_centerPointForPosition:(NSString *)gravity withToast:(UIView *)toast inView:(UIView *)view {
    UIEdgeInsets safeInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeInsets = view.safeAreaInsets;
    }

    if ([CSToastPositionTop isEqualToString:gravity]) {
        CGFloat topPadding = safeInsets.top;
        return CGPointMake(view.bounds.size.width / 2.0, (toast.frame.size.height / 2.0) + topPadding);
    } else if ([CSToastPositionCenter isEqualToString:gravity]) {
        return CGPointMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0);
    }

    // default to bottom
    CGFloat bottomPadding = safeInsets.bottom;
    return CGPointMake(view.bounds.size.width / 2.0, (view.bounds.size.height - (toast.frame.size.height / 2.0)) - bottomPadding);
}

- (UIView *)getToastView:(UIViewController *)ctrl {
    UIView *rootView = ctrl.view;
    CGRect bounds = rootView.bounds;
    bounds.size.height -= _kbdHeight;

    UIView *view = [[UIView alloc] initWithFrame:bounds];
    view.userInteractionEnabled = NO;
    [rootView addSubview:view];
    return view;
}

#ifdef RCT_NEW_ARCH_ENABLED
- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
        (const facebook::react::ObjCTurboModule::InitParams &)params {
    return std::make_shared<facebook::react::NativeSimpleToastSpecJSI>(params);
}
#endif

@end
