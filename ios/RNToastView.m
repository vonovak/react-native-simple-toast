#import "RNToastView.h"

@implementation RNToastView {
    CGRect originalFrame;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  id hitView = [super hitTest:point withEvent:event];
  if (hitView == self) return nil;
  else return hitView;
}

- (instancetype)initWithFrame:(CGRect)frame kbdHeight: (CGFloat)kbdHeight kbdAvoidEnabled: (BOOL)kbdAvoidEnabled {
    originalFrame = frame;
    if (kbdAvoidEnabled) {
        frame.size.height -= kbdHeight;
    }
    if (self = [super initWithFrame:frame]) {
        if (kbdAvoidEnabled) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillShow:)
                                                         name:UIKeyboardWillShowNotification
                                                       object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(keyboardWillHide:)
                                                         name:UIKeyboardWillHideNotification
                                                       object:nil];
        }
    }
    return self;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat height = keyboardSize.height;
    CGRect frame = originalFrame;
    frame.size.height -= height;
    [self setFrame: frame];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self setFrame: originalFrame];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillShowNotification
                                                      object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

@end
