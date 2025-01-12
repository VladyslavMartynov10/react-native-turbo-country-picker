import { useState } from 'react';
import { Text, View, StyleSheet, Button } from 'react-native';
import { openPicker } from 'react-native-turbo-country-picker';

export default function App() {
  const [country, setCountry] = useState<string>('');

  const open = () => {
    openPicker((selectedCountry: string) => {
      setCountry(selectedCountry);
    });
  };

  return (
    <View style={styles.container}>
      <Button title="Open" onPress={open} />
      <Text style={{ color: 'white' }}>Result: {country}</Text>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
});
