# react-native-simple-toast [![npm version](https://badge.fury.io/js/react-native-simple-toast.svg)](https://badge.fury.io/js/react-native-simple-toast)

React Native Toast component for both Android and iOS. It just lets iOS users have the same toast experience as on Android. Using [scalessec/Toast](https://github.com/scalessec/Toast) on iOS and the React Native's [ToastAndroid](http://facebook.github.io/react-native/docs/toastandroid.html) on Android.

## Summary

- extremely simple fire-and-forget api, same as `ToastAndroid`
- renders on top of `Modal`s and `Alert`s
- customizable styling

## Screenshots

<table>
  <tr>
    <td><p align="center"><img src="./images/offset.png" height="400"/></p></td>
    <td><p align="center"><img src="./images/styled.png" height="400"/></p></td>
  </tr>

</table>

<details>
  <summary>Expand for more screenshots</summary>

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

Requires React Native 0.70 or later because the lib needs new architecture enabled. Version 2 will not work with old architecture. Use version 1 if you need to use it with the old architecture.

Please [read more about the new architecture here](https://reactnative.dev/docs/next/the-new-architecture/use-app-template#enable-the-new-architecture).

```bash
yarn add react-native-simple-toast
cd ios && RCT_NEW_ARCH_ENABLED=1 pod install
```

then rebuild your project

## Usage

the module exposes the following functions, same as `ToastAndroid`, with extra styling parameter for iOS only:

```ts
import Toast from 'react-native-simple-toast';

Toast.show(message, duration, styles);

Toast.showWithGravity(message, duration, gravity, styles);

Toast.showWithGravityAndOffset(
  message,
  duration,
  gravity,
  xOffset,
  yOffset,
  styles,
);
```

exported duration and positioning constants:

```ts
import Toast from 'react-native-simple-toast';

Toast.LONG;
Toast.SHORT;
Toast.TOP;
Toast.BOTTOM;
Toast.CENTER;
```

Please note that `yOffset` and `xOffset` are [ignored on Android 11 and above](<https://developer.android.com/reference/android/widget/Toast#setGravity(int,%20int,%20int)>).

For styling on iOS, you can pass an object with the following properties:

```ts
type StylesIOS = {
  textColor?: ColorValue;
  backgroundColor?: ColorValue;
};
```

## Examples

```js
import Toast from 'react-native-simple-toast';

Toast.show('This is a short toast');

Toast.show('This is a long toast.', Toast.LONG);

Toast.showWithGravity(
  'This is a long toast at the top.',
  Toast.LONG,
  Toast.TOP,
);

Toast.show('This is a styled toast on iOS.', Toast.LONG, {
  backgroundColor: 'blue',
});
```

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
