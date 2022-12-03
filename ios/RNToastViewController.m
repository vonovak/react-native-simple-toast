
#import "RNToastViewController.h"
#import <React/RCTUtils.h>

@interface RNToastViewController ()

@property(nonatomic, strong) UIWindow *toastWindow;

@end

@implementation RNToastViewController

- (UIWindow *)toastWindow {
    if (_toastWindow == nil) {
        _toastWindow = [[UIWindow alloc] initWithFrame:RCTSharedApplication().keyWindow.bounds];
        _toastWindow.rootViewController = [UIViewController new];
        _toastWindow.windowLevel = UIWindowLevelAlert + 2;
        _toastWindow.userInteractionEnabled = NO;
    }
    return _toastWindow;
}

- (void)show:(void (^)(void))completion {
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.toastWindow setHidden:NO];
    [self.toastWindow.rootViewController presentViewController:self animated:NO completion:completion];
}

- (void)hide {
    [_toastWindow setHidden:YES];

    if (@available(iOS 13, *)) {
        _toastWindow.windowScene = nil;
    }

    _toastWindow = nil;
}

@end
