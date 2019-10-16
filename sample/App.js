/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, {Component} from 'react';
import {
  AppRegistry,
  StyleSheet,
  TouchableHighlight,
  Text,
  View,
} from 'react-native';
import Toast from 'react-native-simple-toast';

export default class samples extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>This is the sample of Simple Toast.</Text>
        <Text style={styles.instructions}>
          Press Cmd+R to reload,{'\n'}
          Cmd+D or shake for dev menu
        </Text>
        <TouchableHighlight
          onPress={() => {
            Toast.show('This is a default toast');
          }}>
          <Text>Tap to show default toast!</Text>
        </TouchableHighlight>
        <TouchableHighlight
          onPress={() => {
            Toast.show('This is a long Toast', Toast.LONG);
          }}>
          <Text>Tap to show long toast!</Text>
        </TouchableHighlight>
        <TouchableHighlight
          onPress={() => {
            Toast.showWithGravity(
              'This is a long centered toast',
              Toast.LONG,
              Toast.CENTER,
            );
          }}>
          <Text>Tap to show a long centered toast!</Text>
        </TouchableHighlight>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});
