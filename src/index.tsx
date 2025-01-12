import TurboCountryPicker from './NativeTurboCountryPicker';

export function openPicker(callback: (selectedCountry: string) => void): void {
  return TurboCountryPicker.openPicker(callback);
}
