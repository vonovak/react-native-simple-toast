# react-native-simple-toast [![npm version](https://badge.fury.io/js/react-native-simple-toast.svg)](https://badge.fury.io/js/react-native-simple-toast) 
React Native Toast component for both Android and iOS. It just lets iOS users have the same toast experience as on Android. Using [scalessec/Toast](https://github.com/scalessec/Toast) on iOS and the standard [ToastAndroid](http://facebook.github.io/react-native/docs/toastandroid.html) on Android;

This is based on work at https://github.com/xgfe/react-native-simple-toast which is no longer maintained.

## Install

```bash
npm install react-native-simple-toast --save
react-native link react-native-simple-toast // only RN < 0.60
```
then rebuild your project

## Usage

```javascript
import Toast from 'react-native-simple-toast';

Toast.show('This is a toast.');
Toast.show('This is a long toast.', Toast.LONG);

Toast.showWithGravity('This is a long toast at the top.', Toast.LONG, Toast.TOP)
```

## License

MIT
