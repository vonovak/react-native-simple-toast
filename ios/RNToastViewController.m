
#import "RNToastViewController.h"
#import <React/RCTUtils.h>

@interface RNToastViewController ()

@property(nonatomic, strong) UIWindow *toastWindow;

@end

@implementation RNToastViewController

// presenting directly from RCTSharedApplication().keyWindow won't work for Alerts
// which is why we have our own VC

- (UIWindow *)toastWindow
{
    if (_toastWindow == nil) {
        _toastWindow = [self getUIWindowFromScene];
        
        if (_toastWindow == nil) {
            UIWindow *keyWindow = RCTSharedApplication().keyWindow;
            if (keyWindow) {
                _toastWindow = [[UIWindow alloc] initWithFrame:keyWindow.bounds];
            } else {
                // keyWindow is nil, so we cannot create and initialize _toastWindow
                NSLog(@"Unable to create alert window: keyWindow is nil");
            }
        }
        
        if (_toastWindow) {
            _toastWindow.rootViewController = [UIViewController new];
            _toastWindow.windowLevel = UIWindowLevelAlert + 1;
            _toastWindow.userInteractionEnabled = NO;
        }
    }
    
    return _toastWindow;
}

- (void)show:(void (^)(void))completion {
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
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

- (UIWindow *)getUIWindowFromScene
{
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in RCTSharedApplication().connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive &&
                [scene isKindOfClass:[UIWindowScene class]]) {
                return [[UIWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
            }
        }
    }
    return nil;
}

@end
