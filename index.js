import {NativeModules,ToastAndroid,Platform} from 'react-native';

var RCTToastModule = Platform.OS === 'android' ? ToastAndroid : NativeModules.LRDRCTSimpleToast;

var SimpleToast = {
  SHORT: RCTToastModule.SHORT,
  LONG: RCTToastModule.LONG,
  show: function (message:string, duration:number):void {
    RCTToastModule.show(message, duration === undefined ? this.SHORT : duration);
  }
};

export default SimpleToast;
