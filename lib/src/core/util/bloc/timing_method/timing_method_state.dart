part of 'timing_method_bloc.dart';

abstract class TimingMethodState extends Equatable {
  final TimingMethod primaryTimingMethod;
  final TimingMethod secondaryTimingMethod;
  final bool isSecondaryEnabled;

  const TimingMethodState(this.primaryTimingMethod, this.secondaryTimingMethod,
      this.isSecondaryEnabled);
}

class TimingMethodInitial extends TimingMethodState {
  const TimingMethodInitial(TimingMethod primaryTimingMethod,
      TimingMethod secondaryTimingMethod, bool isSecondaryEnabled)
      : super(primaryTimingMethod, secondaryTimingMethod, isSecondaryEnabled);

  @override
  List<Object> get props =>
      [primaryTimingMethod, secondaryTimingMethod, isSecondaryEnabled];
}

class TimingMethodLoading extends TimingMethodState {
  const TimingMethodLoading(TimingMethod primaryTimingMethod,
      TimingMethod secondaryTimingMethod, bool isSecondaryEnabled)
      : super(primaryTimingMethod, secondaryTimingMethod, isSecondaryEnabled);

  @override
  List<Object> get props =>
      [primaryTimingMethod, secondaryTimingMethod, isSecondaryEnabled];
}

class TimingMethodSuccess extends TimingMethodState {
  const TimingMethodSuccess(TimingMethod primaryTimingMethod,
      TimingMethod secondaryTimingMethod, bool isSecondaryEnabled)
      : super(primaryTimingMethod, secondaryTimingMethod, isSecondaryEnabled);

  @override
  List<Object> get props =>
      [primaryTimingMethod, secondaryTimingMethod, isSecondaryEnabled];
}

class TimingMethodFailed extends TimingMethodState {
  const TimingMethodFailed(TimingMethod primaryTimingMethod,
      TimingMethod secondaryTimingMethod, bool isSecondaryEnabled)
      : super(primaryTimingMethod, secondaryTimingMethod, isSecondaryEnabled);

  @override
  List<Object> get props =>
      [primaryTimingMethod, secondaryTimingMethod, isSecondaryEnabled];
}
