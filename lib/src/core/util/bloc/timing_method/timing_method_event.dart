part of 'timing_method_bloc.dart';

abstract class TimingMethodEvent extends Equatable {
  const TimingMethodEvent();
}

class InitTimingMethod extends TimingMethodEvent {
  @override
  List<Object> get props => [];
}

class SetPrimaryTimingMethod extends TimingMethodEvent {
  final TimingMethod primaryTimingMethod;

  SetPrimaryTimingMethod(this.primaryTimingMethod);

  @override
  List<Object> get props => [primaryTimingMethod];
}

class SetSecondaryTimingMethod extends TimingMethodEvent {
  final TimingMethod secondaryTimingMethod;
  final bool isSecondaryEnabled;

  SetSecondaryTimingMethod(this.secondaryTimingMethod, this.isSecondaryEnabled);

  @override
  List<Object> get props => [secondaryTimingMethod, isSecondaryEnabled];
}
