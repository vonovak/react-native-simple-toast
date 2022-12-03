import { Platform, processColor } from 'react-native';
import type { Spec, StylesIOS } from './NativeSimpleToast';

const RCTToast = Platform.select<() => Spec>({
  ios: () => require('./NativeSimpleToast').default,
  android: () => require('react-native').ToastAndroid,
  default: () => {
    throw new Error('RNSimpleToast: unsupported platform');
  },
})();

const constantsSource = Platform.select<
  () => {
    SHORT: number;
    LONG: number;
    TOP: number;
    BOTTOM: number;
    CENTER: number;
  }
>({
  ios: () => require('./NativeSimpleToast').default.getConstants(),
  android: () => require('react-native').ToastAndroid,
  default: () => {
    throw new Error('RNSimpleToast: unsupported platform');
  },
})();

export default {
  SHORT: constantsSource.SHORT,
  LONG: constantsSource.LONG,

  TOP: constantsSource.TOP,
  BOTTOM: constantsSource.BOTTOM,
  CENTER: constantsSource.CENTER,

  show(message: string, durationSeconds: number, styles: StylesIOS = {}) {
    RCTToast.show(message, durationSeconds, processColors(styles));
  },

  showWithGravity(
    message: string,
    durationSeconds: number,
    gravity: number,
    styles: StylesIOS = {},
  ) {
    RCTToast.showWithGravity(
      message,
      durationSeconds ?? constantsSource.SHORT,
      gravity,
      processColors(styles),
    );
  },

  showWithGravityAndOffset(
    message: string,
    duration: number,
    gravity: number,
    xOffset: number,
    yOffset: number,
    styles: StylesIOS = {},
  ) {
    RCTToast.showWithGravityAndOffset(
      message,
      duration,
      gravity,
      xOffset,
      yOffset,
      processColors(styles),
    );
  },
};

function processColors(styles: StylesIOS) {
  if (Platform.OS === 'ios') {
    return {
      // the types are not 100% correct
      messageColor: processColor(styles.textColor) as number | undefined,
      backgroundColor: processColor(styles.backgroundColor) as
        | number
        | undefined,
    };
  }

  return {};
}
