#import <UIKit/UIKit.h>

@interface RNToastViewController : UIViewController

- (void)show:(void (^)(void))completion;
- (void)hide;

@end
