import type { TurboModule, ColorValue } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export type OptionsIOS = {
  textColor?: ColorValue;
  backgroundColor?: ColorValue;
  tapToDismissEnabled?: boolean;
};

// type NativeStyles = {
//   messageColor?: number;
//   backgroundColor?: number;
// };

export interface Spec extends TurboModule {
  getConstants: () => {
    SHORT: number;
    LONG: number;
    TOP: number;
    BOTTOM: number;
    CENTER: number;
  };
  show: (message: string, duration: number, options: Object) => void;
  showWithGravity: (
    message: string,
    duration: number,
    gravity: number,
    options: Object,
  ) => void;
  showWithGravityAndOffset: (
    message: string,
    duration: number,
    gravity: number,
    xOffset: number,
    yOffset: number,
    options: Object,
  ) => void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('RNSimpleToast');
