import { NativeModules, ToastAndroid, Platform } from 'react-native'

declare var SimpleToast: {
  // Toast duration constants
  SHORT: number,
  LONG: number,

  // Toast gravity constants
  TOP: number,
  BOTTOM: number,
  CENTER: number,

  show: (message: string, duration?: number) => void,

  showWithGravity: (message: string, duration: number, gravity: number) => void
}

export default SimpleToast
