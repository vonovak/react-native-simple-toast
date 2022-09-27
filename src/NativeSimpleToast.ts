import type { TurboModule } from 'react-native/Libraries/TurboModule/RCTExport';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  
  show: (message: string, duration?: number, viewControllerBlacklist?: Array<string>) => void;

  showWithGravity: (
    message: string,
    duration: number,
    gravity: string,
    viewControllerBlacklist?: Array<string>
  ) => void;
}

export default TurboModuleRegistry.get<Spec>(
  'RTNSimpleToast'
) as Spec | null;