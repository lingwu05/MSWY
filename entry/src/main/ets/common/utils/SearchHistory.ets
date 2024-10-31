import { preferences } from '@kit.ArkData';

class SearchHistory {
  dataPreferences: preferences.Preferences = {} as preferences.Preferences
  options: preferences.Options = {} as preferences.Options

  initInstance(instanceName: string) {
    this.options = { name: instanceName };
    this.dataPreferences = preferences.getPreferencesSync(getContext(), this.options);
  }

  update(key: string, value: string[]) {
    this.dataPreferences.putSync(key, value);
    this.dataPreferences.flush()
  }

  read(key: string): string[] {
    return this.dataPreferences.getSync(key, []) as string[]
  }

  delete(key: string) {
    this.dataPreferences.deleteSync(key);
    this.dataPreferences.flush()
  }

  deleteInstance() {
    preferences.deletePreferences(getContext(), this.options)
  }
}

export const searchHistory: SearchHistory = new SearchHistory()