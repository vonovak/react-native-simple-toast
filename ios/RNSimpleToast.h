
#ifdef RCT_NEW_ARCH_ENABLED
  #import "RNSimpleToastSpec.h"
#else
  #import <React/RCTBridgeModule.h>
#endif

@interface RNSimpleToast : NSObject <
#ifdef RCT_NEW_ARCH_ENABLED
NativeSimpleToastSpec
#else
RCTBridgeModule
#endif
>

@property (nonatomic, strong) UIWindow *toastWindow;

@end
