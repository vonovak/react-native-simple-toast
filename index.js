import { NativeModules, ToastAndroid, Platform } from 'react-native';

const RCTToast = Platform.OS === 'android' ? ToastAndroid : NativeModules.LRDRCTSimpleToast;

export default {
  // Toast duration constants
  SHORT: RCTToast.SHORT,
  LONG: RCTToast.LONG,

  // Toast gravity constants
  TOP: RCTToast.TOP,
  BOTTOM: RCTToast.BOTTOM,
  CENTER: RCTToast.CENTER,

  show: function(message, duration) {
    RCTToast.show(message, duration === undefined ? RCTToast.SHORT : duration);
  },

  showWithGravity: function(message, duration, gravity) {
    RCTToast.showWithGravity(message, duration === undefined ? RCTToast.SHORT : duration, gravity);
  },
};
