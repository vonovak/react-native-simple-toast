#import <UIKit/UIKit.h>

@interface RNToastViewController : NSObject

@property(nonatomic, strong) UIWindow *toastWindow;

- (void)show;
- (void)hide;

@end
