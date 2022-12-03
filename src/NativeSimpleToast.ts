import type { TurboModule, ColorValue } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export type StylesIOS = {
  textColor?: ColorValue;
  backgroundColor?: ColorValue;
};

type NativeStyles = {
  messageColor?: number;
  backgroundColor?: number;
};

export interface Spec extends TurboModule {
  getConstants: () => {
    SHORT: number;
    LONG: number;
    TOP: number;
    BOTTOM: number;
    CENTER: number;
  };
  show: (message: string, duration: number, styles: NativeStyles) => void;
  showWithGravity: (
    message: string,
    duration: number,
    gravity: number,
    styles: NativeStyles,
  ) => void;
  showWithGravityAndOffset: (
    message: string,
    duration: number,
    gravity: number,
    xOffset: number,
    yOffset: number,
    styles: NativeStyles,
  ) => void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('RNSimpleToast');
