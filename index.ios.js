import {NativeModules} from 'react-native';

var RCTToastModule = NativeModules.LRDRCTSimpleToast;

var SimpleToast = {
  SHORT: RCTToastModule.SHORT,
  LONG: RCTToastModule.LONG,
  show: function (message:string, duration:number):void {
    RCTToastModule.show(message, duration === undefined ? this.SHORT : duration);
  }
};

export default SimpleToast;
