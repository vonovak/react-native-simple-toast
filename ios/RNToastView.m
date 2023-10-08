#import "RNToastView.h"

@implementation RNToastView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  id hitView = [super hitTest:point withEvent:event];
  if (hitView == self) return nil;
  else return hitView;
}

@end
