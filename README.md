# react-native-simple-toast [![npm version](https://badge.fury.io/js/react-native-simple-toast.svg)](https://badge.fury.io/js/react-native-simple-toast)

React Native Toast component for both Android and iOS. It just lets iOS users have the same toast experience as on Android. Using [scalessec/Toast](https://github.com/scalessec/Toast) on iOS and the React Native's [ToastAndroid](http://facebook.github.io/react-native/docs/toastandroid.html) on Android;

## Screenshots

<table>
  <tr>
    <td><p align="center"><img src="./images/offset.png" height="400"/></p></td>
    <td><p align="center"><img src="./images/styled.png" height="400"/></p></td>
  </tr>

</table>

<details>
  <summary>Expand for more</summary>

<table>
  <tr>
    <td><p align="center"><img src="./images/alert.png" height="400"/></p></td>
    <td><p align="center"><img src="./images/modal.png" height="400"/></p></td>
  </tr>
  <tr>
    <td><p align="center"><img src="./images/keyboard.png" height="400"/></p></td>
    <td><p align="center"><img src="./images/styled-keyboard.png" height="400"/></p></td>
  </tr>
</table>

</details>

## Install

Requires React Native 0.70 or later because the lib needs new architecture support. Use version 1 if you need to use it with older versions of React Native.

```bash
npm install react-native-simple-toast
cd ios && RCT_NEW_ARCH_ENABLED=1 pod install
```

with yarn:

```bash
yarn add react-native-simple-toast
cd ios && RCT_NEW_ARCH_ENABLED=1 pod install
```

then rebuild your project

## Usage

the module exposes the following functions, same as `ToastAndroid`, with extra styling parameter for iOS only:

```ts
import Toast from 'react-native-simple-toast';

Toast.show(message, duration, styles)

Toast.showWithGravity(message, duration, gravity, styles)

Toast.showWithGravityAndOffset(message, duration, gravity, xOffset, yOffset, styles)
```

Please note that `yOffset` and `xOffset` are [ignored on Android 11 and above](https://developer.android.com/reference/android/widget/Toast#setGravity(int,%20int,%20int)).

For styling on iOS, you can pass an object with the following properties:

```ts
type StylesIOS = {
  messageColor?: ColorValue;
  backgroundColor?: ColorValue;
};
```

## Examples

```js
import Toast from 'react-native-simple-toast';

Toast.show('This is a long toast.', Toast.LONG);

Toast.showWithGravity('This is a long toast at the top.', Toast.LONG, Toast.TOP);

Toast.show('This is a styled toast on iOS.', Toast.LONG, { backgroundColor: 'blue' });
```

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
