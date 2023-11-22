import * as React from 'react';

import {
  StyleSheet,
  View,
  Button,
  Alert,
  TextInput,
  ScrollView,
  Pressable,
  Modal,
  Text,
} from 'react-native';
import Toast from 'react-native-simple-toast';
import { useState } from 'react';

export default function App() {
  const [modalVisible, setModalVisible] = useState(false);

  return (
    <>
      <Modal
        animationType="slide"
        transparent={true}
        visible={modalVisible}
        onRequestClose={() => {
          Alert.alert('Modal has been closed.');
          setModalVisible(!modalVisible);
        }}
      >
        <View style={styles.centeredView}>
          <View style={styles.modalView}>
            <Text style={styles.modalText}>Hello World!</Text>
            <Pressable
              style={[styles.button, styles.buttonClose]}
              onPress={() => setModalVisible(!modalVisible)}
            >
              <Text style={styles.textStyle}>Hide Modal</Text>
            </Pressable>
          </View>
        </View>
      </Modal>

      <ScrollView
        keyboardDismissMode={'on-drag'}
        keyboardShouldPersistTaps={'always'}
        automaticallyAdjustKeyboardInsets
        style={{ backgroundColor: 'white' }}
      >
        <View style={styles.container}>
          <Button
            title={'simple toast'}
            onPress={() => {
              Toast.show('This is a toast.', Toast.SHORT);
            }}
          />
          <Button
            title={'tap to dismiss toast'}
            onPress={() => {
              Toast.show('Tap to dismiss toast.', Toast.LONG, {
                tapToDismissEnabled: true,
              });
            }}
          />
          <Button
            onPress={() => {
              setModalVisible(true);
              setTimeout(() => {
                Toast.showWithGravity(
                  'This is a toast in a modal.',
                  Toast.SHORT,
                  Toast.CENTER,
                );
              }, 500);
            }}
            title="toast on top of Modal"
          />
          {/*<Text>{JSON.stringify(Toast, null, 2)}</Text>*/}

          <Button
            title={'styled toast'}
            onPress={() => {
              Toast.show('This is a styled toast on iOS.', Toast.LONG, {
                backgroundColor: 'rgb(255, 0, 255)',
                textColor: 'black',
              });
            }}
          />
          <Button
            title={'two toasts on top'}
            onPress={() => {
              Toast.show('_____ This is a bottom toast _____', 7, {
                backgroundColor: 'rgb(255, 0, 255)',
                textColor: 'black',
              });
              Toast.show('Tap to dismiss toast on iOS.', 7, {
                tapToDismissEnabled: true,
              });
            }}
          />
          <Button
            title={'toast with offset'}
            onPress={() => {
              Toast.showWithGravityAndOffset(
                'This is a toast w/ offset.',
                Toast.LONG,
                Toast.CENTER,
                200,
                0,
              );
            }}
          />
          <Button
            title={'top toast in an alert'}
            onPress={() => {
              Alert.alert('this is an alert');
              setTimeout(() => {
                Toast.showWithGravity(
                  'This is an alert toast.',
                  5,
                  Toast.CENTER,
                );
              }, 100);
            }}
          />
          <TextInput
            style={{
              width: 200,
              height: 40,
              borderColor: 'gray',
              borderWidth: 1,
            }}
            value={'test text input'}
          />
        </View>
      </ScrollView>
    </>
  );
}

const styles = StyleSheet.create({
  container: {
    paddingTop: 100,
    alignItems: 'center',
    justifyContent: 'center',
    flexGrow: 1,
    // backgroundColor: 'lightgray',
  },
  //
  centeredView: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginTop: 22,
  },
  modalView: {
    margin: 20,
    backgroundColor: 'white',
    borderRadius: 20,
    padding: 35,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.25,
    shadowRadius: 4,
    elevation: 5,
  },
  button: {
    borderRadius: 20,
    padding: 10,
    elevation: 2,
  },
  buttonOpen: {
    backgroundColor: '#F194FF',
  },
  buttonClose: {
    backgroundColor: '#2196F3',
  },
  textStyle: {
    color: 'white',
    fontWeight: 'bold',
    textAlign: 'center',
  },
  modalText: {
    marginBottom: 15,
    textAlign: 'center',
  },
});
