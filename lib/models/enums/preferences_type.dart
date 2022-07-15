enum PreferencesType {
  session,
  isLoggedIn,
  enableSleepQuestionnaire,
  profile,
  plan,
  stage,
  sessions,
  bpm,
  wearableId
}

extension PreferencesHelper on PreferencesType {
  String get key {
    switch (this) {
      case PreferencesType.isLoggedIn:
        return 'isLoggedIn';
      case PreferencesType.session:
        return 'session';
      case PreferencesType.enableSleepQuestionnaire:
        return 'enableSleepQuestionnaire';
      case PreferencesType.profile:
        return 'profile';
      case PreferencesType.plan:
        return 'plan';
      case PreferencesType.stage:
        return 'stage';
      case PreferencesType.sessions:
        return 'sessions';
      case PreferencesType.bpm:
        return 'bpm';
      case PreferencesType.wearableId:
        return 'wearableId';
    }
  }

  PreferencesType toEnum(String value) {
    switch (value) {
      case 'isLoggedIn':
        return PreferencesType.isLoggedIn;
      case 'session':
        return PreferencesType.session;
      case 'enableSleepQuestionnaire':
        return PreferencesType.enableSleepQuestionnaire;
      case 'profile':
        return PreferencesType.profile;
      case 'plan':
        return PreferencesType.plan;
      case 'stage':
        return PreferencesType.stage;
      case 'sessions':
        return PreferencesType.sessions;
      case 'bpm':
        return PreferencesType.bpm;
      case 'wearableId':
        return PreferencesType.wearableId;
      default:
        return PreferencesType.isLoggedIn;
    }
  }
}
