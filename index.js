import { NativeModules, Platform } from 'react-native';

const RCTToast = Platform.select({
  ios: NativeModules.LRDRCTSimpleToast,
  android: require('react-native').ToastAndroid,
});

export default {
  // Toast duration constants
  SHORT: RCTToast.SHORT,
  LONG: RCTToast.LONG,

  // Toast gravity constants
  TOP: RCTToast.TOP,
  BOTTOM: RCTToast.BOTTOM,
  CENTER: RCTToast.CENTER,

  show(message, duration, viewControllerBlacklist) {
    this.showWithGravity(message, duration, RCTToast.BOTTOM, viewControllerBlacklist);
  },

  showWithGravity(message, duration, gravity, viewControllerBlacklist) {
    RCTToast.show(
      message,
      duration === undefined ? RCTToast.SHORT : duration,
      gravity,
      viewControllerBlacklist
    );
  },
};
