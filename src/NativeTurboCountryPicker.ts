import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  openPicker: (onCountrySelect: (selectedCountry: string) => void) => void;
}

export default TurboModuleRegistry.getEnforcing<Spec>('TurboCountryPicker');
