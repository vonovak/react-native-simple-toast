#import "RNToastWindow.h"
#import <React/RCTUtils.h>

@implementation RNToastWindow

- (instancetype)init
{
    if (@available(iOS 13.0, *)) {
        for (UIScene *scene in RCTSharedApplication().connectedScenes) {
            if (scene.activationState == UISceneActivationStateForegroundActive &&
                [scene isKindOfClass:[UIWindowScene class]]) {
                self = [super initWithWindowScene:(UIWindowScene *)scene];
            }
        }
    }
    if (!self) {
        UIWindow *keyWindow = RCTSharedApplication().keyWindow;
        if (keyWindow) {
            self = [super initWithFrame:keyWindow.bounds];
        } else {
            // keyWindow is nil, so we cannot create and initialize _toastWindow
            NSLog(@"Unable to create alert window: keyWindow is nil");
        }
    }
    if (self) {
        [self setHidden:NO];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.windowLevel = UIWindowLevelAlert + 1;
    }
    return self;
}

- (instancetype)initWithWindowScene:(UIWindowScene *)windowScene {
    if (self = [super initWithWindowScene:windowScene]) {
        self.windowLevel = UIWindowLevelAlert + 1;
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  id hitView = [super hitTest:point withEvent:event];
  if (hitView == self) return nil;
  else return hitView;
}

- (void)dealloc
{
    if (@available(iOS 13, *)) {
        self.windowScene = nil;
    }
}

@end
