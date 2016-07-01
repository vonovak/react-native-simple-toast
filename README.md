# react-native-simple-toast
React Native Toast component for both Android and iOS. It just let iOS have the same toast performance with Android. Using [scalessec/Toast](https://github.com/scalessec/Toast) for iOS;

## Install
You can use [rnpm](https://github.com/rnpm/rnpm) to install native component easily;

```bash
npm install react-native-simple-toast --save
rnpm link
```

## Usage

It's just the same as [ToastAndroid](http://facebook.github.io/react-native/docs/toastandroid.html)

```javascript
import Toast from 'react-native-simple-toast';

Toast.show('This is a toast.');
Toast.show('This is a long toast.',Toast.LONG);
```