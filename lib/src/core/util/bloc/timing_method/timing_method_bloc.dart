import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'timing_methods.dart';

part 'timing_method_event.dart';
part 'timing_method_state.dart';

class TimingMethodBloc
    extends HydratedBloc<TimingMethodEvent, TimingMethodState> {
  TimingMethodBloc()
      : super(
          TimingMethodInitial(
            TimingMethod.isna,
            TimingMethod.muslim_world_league,
            false,
          ),
        );

  @override
  Stream<TimingMethodState> mapEventToState(
    TimingMethodEvent event,
  ) async* {
    if (event is InitTimingMethod) {
      yield TimingMethodSuccess(
        state.primaryTimingMethod,
        state.secondaryTimingMethod,
        state.isSecondaryEnabled,
      );
    } else if (event is SetPrimaryTimingMethod) {
      yield TimingMethodSuccess(event.primaryTimingMethod,
          state.secondaryTimingMethod, state.isSecondaryEnabled);
    } else if (event is SetSecondaryTimingMethod) {
      yield TimingMethodSuccess(state.primaryTimingMethod,
          event.secondaryTimingMethod, event.isSecondaryEnabled);
    }
  }

  @override
  TimingMethodState? fromJson(Map<String, dynamic> json) {
    try {
      return TimingMethodSuccess(
        TimingMethodExtension.fromString(json['primaryTimingMethod']),
        TimingMethodExtension.fromString(json['secondaryTimingMethod']),
        json['isSecondaryEnabled'] as bool,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(TimingMethodState state) {
    try {
      return {
        'primaryTimingMethod': state.primaryTimingMethod.name,
        'secondaryTimingMethod': state.secondaryTimingMethod.name,
        'isSecondaryEnabled': state.isSecondaryEnabled,
      };
    } catch (e) {
      return null;
    }
  }
}
