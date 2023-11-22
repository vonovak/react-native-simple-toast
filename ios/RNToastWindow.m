#import "RNToastWindow.h"

@implementation RNToastWindow

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

@end
