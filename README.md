# react-native-simple-toast [![npm version](https://badge.fury.io/js/react-native-simple-toast.svg)](https://badge.fury.io/js/react-native-simple-toast)

React Native Toast component for both Android and iOS. It just lets iOS users have the same toast experience as on Android. Using [scalessec/Toast](https://github.com/scalessec/Toast) on iOS and the standard [ToastAndroid](http://facebook.github.io/react-native/docs/toastandroid.html) on Android;

This is based on work at https://github.com/xgfe/react-native-simple-toast, but doesn't have much in common any more.

## Install

```bash
npm install react-native-simple-toast --save
react-native link react-native-simple-toast // only RN < 0.60
cd ios && pod install
```

then rebuild your project

## Usage

the module exposes the following functions:

```js
// duration Toast.SHORT is used by default
show: (message: string, duration?: number, viewControllerBlacklist?: Array<string>) => void,
```

```js
showWithGravity: (
message: string,
duration: number,
gravity: string,
viewControllerBlacklist?: Array<string>
) => void,
```

Note on `viewControllerBlacklist`: this is an iOS-only option, it is ignored on android.
When presenting the Toast, we need to find the presented ViewController (VC). The Toast will be presented in that VC. For Example, let's say you're showing a `ReactNative.Modal` in your app - in that case, the presented VC is a `RCTModalHostViewController`.

If you present a Toast while that `Modal` is shown, and then hide the `Modal`, the Toast will disappear together with the `Modal`.

`viewControllerBlacklist` allows to say what VCs should not be considered when Toast is shown. This is to allow to work around issues where Toast would be displayed weirdly in an `Alert` or would hide too quickly when shown in a `RCTModalHostViewController`.

The values `viewControllerBlacklist` has been tested with are:

```js
['RCTModalHostViewController', 'UIAlertController'];
```

## Examples

```js
import Toast from 'react-native-simple-toast';

Toast.show('This is a toast.');
Toast.show('This is a long toast.', Toast.LONG);

Toast.showWithGravity('This is a long toast at the top.', Toast.LONG, Toast.TOP);

Toast.show('This is nicely visible even if you call this when an Alert is shown', Toast.SHORT, [
  'UIAlertController',
]);
```

## License

MIT
