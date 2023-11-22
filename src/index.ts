import { Platform, processColor } from 'react-native';
import type { Spec, StylesIOS } from './NativeSimpleToast';

const unsupportedPlatform = 'RNSimpleToast: unsupported platform';

const RCTToast = Platform.select<() => Spec>({
  ios: () => require('./NativeSimpleToast').default,
  android: () => require('react-native').ToastAndroid,
  default: () => {
    throw new Error(unsupportedPlatform);
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
    throw new Error(unsupportedPlatform);
  },
})();

export default {
  SHORT: constantsSource.SHORT,
  LONG: constantsSource.LONG,

  TOP: constantsSource.TOP,
  BOTTOM: constantsSource.BOTTOM,
  CENTER: constantsSource.CENTER,

  show(message: string, duration: number, options?: StylesIOS) {
    RCTToast.show(
      message,
      duration ?? constantsSource.SHORT,
      processColors(options),
    );
  },

  showWithGravity(
    message: string,
    duration: number,
    gravity: number,
    options?: StylesIOS,
  ) {
    RCTToast.showWithGravity(
      message,
      duration ?? constantsSource.SHORT,
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
    options?: StylesIOS,
  ) {
    RCTToast.showWithGravityAndOffset(
      message,
      duration ?? constantsSource.SHORT,
      gravity,
      xOffset,
      yOffset,
      processColors(options),
    );
  },
};

function processColors(options?: StylesIOS) {
  if (Platform.OS === 'android' || !options) {
    return undefined;
  }
  return {
    // the types are not 100% correct
    ...options,
    messageColor: processColor(options.textColor) as number | undefined,
    backgroundColor: processColor(options.backgroundColor) as
      | number
      | undefined,
  };
}
