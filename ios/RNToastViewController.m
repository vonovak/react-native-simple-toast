
#import "RNToastViewController.h"
#import <React/RCTUtils.h>
#import "RNToastWindow.h"

@implementation RNToastViewController

- (UIWindow *)toastWindow
{
    if (_toastWindow == nil) {
        _toastWindow = [self getUIWindowFromScene];
        
        if (_toastWindow == nil) {
            UIWindow *keyWindow = RCTSharedApplication().keyWindow;
            if (keyWindow) {
                _toastWindow = [[RNToastWindow alloc] initWithFrame:keyWindow.bounds];
            } else {
                // keyWindow is nil, so we cannot create and initialize _toastWindow
                NSLog(@"Unable to create alert window: keyWindow is nil");
            }
        }
    }
    
    return _toastWindow;
}

- (void)show {
    [self.toastWindow setHidden:NO];
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
                return [[RNToastWindow alloc] initWithWindowScene:(UIWindowScene *)scene];
            }
        }
    }
    return nil;
}

@end
