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
        // contentContainerStyle={{ flexGrow: 1 }}
        automaticallyAdjustKeyboardInsets
      >
        <View style={styles.container}>
          <Pressable
            style={[styles.button, styles.buttonOpen]}
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
          >
            <Text style={styles.textStyle}>Show Modal</Text>
          </Pressable>
          {/*<Text>{JSON.stringify(Toast, null, 2)}</Text>*/}
          <Button
            title={'simple toast'}
            onPress={() => {
              Toast.show('This is a toast.', Toast.SHORT);
            }}
          />
          <Button
            title={'styled toast'}
            onPress={() => {
              Toast.show('This is a styled toast on iOS.', Toast.LONG, {
                backgroundColor: 'rgb(255, 0, 255)',
                textColor: 'white',
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
            title={'top toast in alert'}
            onPress={() => {
              Alert.alert('this is an alert');
              setTimeout(() => {
                Toast.showWithGravity('This is an alert toast.', 5, Toast.TOP);
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
