enum TimingMethod {
  isna,
  muslim_world_league,
  egyptian,
  karachi,
  umm_al_qura,
  dubai,
  qatar,
  kuwait,
  muhakkak,
  jafari,
}

extension TimingMethodExtension on TimingMethod {
  String get displayName {
    switch (this) {
      case TimingMethod.isna:
        return 'ISNA';
      case TimingMethod.muslim_world_league:
        return 'Muslim World League';
      case TimingMethod.egyptian:
        return 'Egyptian';
      case TimingMethod.karachi:
        return 'Karachi';
      case TimingMethod.umm_al_qura:
        return 'Umm Al-Qura';
      case TimingMethod.dubai:
        return 'Dubai';
      case TimingMethod.qatar:
        return 'Qatar';
      case TimingMethod.kuwait:
        return 'Kuwait';
      case TimingMethod.muhakkak:
        return 'Muhakkak';
      case TimingMethod.jafari:
        return 'Jafari';
      default:
        return throw Exception('Unknown timing method');
    }
  }

  String get shortDisplayName {
    switch (this) {
      case TimingMethod.isna:
        return 'ISNA';
      case TimingMethod.muslim_world_league:
        return 'MWL';
      case TimingMethod.egyptian:
        return 'Egyptian';
      case TimingMethod.karachi:
        return 'Karachi';
      case TimingMethod.umm_al_qura:
        return 'Umm Al-Qura';
      case TimingMethod.dubai:
        return 'Dubai';
      case TimingMethod.qatar:
        return 'Qatar';
      case TimingMethod.kuwait:
        return 'Kuwait';
      case TimingMethod.muhakkak:
        return 'Muhakkak';
      case TimingMethod.jafari:
        return 'Jafari';
      default:
        return throw Exception('Unknown timing method');
    }
  }

  static TimingMethod fromString(String value) {
    return TimingMethod.values.firstWhere(
      (e) =>
          e.toString().toLowerCase() == 'timingmethod.${value.toLowerCase()}',
      orElse: () => throw ArgumentError('Invalid enum value: $value'),
    );
  }

  String get name {
    return this.toString().split('.').last;
  }
}
