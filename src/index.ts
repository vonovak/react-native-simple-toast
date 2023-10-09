import { Platform, processColor } from 'react-native';
import type { Spec, OptionsIOS } from './NativeSimpleToast';

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

  show(message: string, durationSeconds: number, options: OptionsIOS = {}) {
    RCTToast.show(
      message,
      durationSeconds ?? constantsSource.SHORT,
      processColors(options),
    );
  },

  showWithGravity(
    message: string,
    durationSeconds: number,
    gravity: number,
    options: OptionsIOS = {},
  ) {
    RCTToast.showWithGravity(
      message,
      durationSeconds ?? constantsSource.SHORT,
      gravity,
      processColors(options),
    );
  },

  showWithGravityAndOffset(
    message: string,
    duration: number,
    gravity: number,
    xOffset: number,
    yOffset: number,
    options: OptionsIOS = {},
  ) {
    RCTToast.showWithGravityAndOffset(
      message,
      duration,
      gravity,
      xOffset,
      yOffset,
      processColors(options),
    );
  },
};

function processColors(options: OptionsIOS) {
  if (Platform.OS === 'ios') {
    return {
      // the types are not 100% correct
      ...options,
      messageColor: processColor(options.textColor) as number | undefined,
      backgroundColor: processColor(options.backgroundColor) as
        | number
        | undefined,
    };
  }

  return {};
}
