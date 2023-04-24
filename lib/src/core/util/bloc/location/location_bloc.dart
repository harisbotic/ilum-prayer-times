import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../error/failures.dart';
import '../../controller/location_controller.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends HydratedBloc<LocationEvent, LocationState> {
  /// max latitude is 90 and max longitude is 180
  LocationBloc()
      : super(
          LocationInitial(
            91,
            181,
            '',
            LocalFailure(
              error: 0,
              message: 'initializing',
            ),
          ),
        );

  Stream<LocationState> _fetchLocationState() async* {
    final position = await getCurrentPosition();

    yield* position.fold((l) async* {
      yield LocationFailed(state.latitude, state.longitude, '', l);
    }, (p) async* {
      final city = await getCityFromCoordinates(p.latitude, p.longitude);

      yield LocationSuccess(p.latitude, p.longitude, city);
    });
  }

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is InitLocation) {
      if (state.latitude > 90 && state.longitude > 180) {
        yield LocationLoading(state.latitude, state.longitude, '');
        yield* _fetchLocationState();
      }
    } else if (event is ResetLocation) {
      yield* _fetchLocationState();
    } else if (event is SetLocation) {
      yield LocationSuccess(event.latitude, event.longitude, event.city);
    }
  }

  @override
  LocationState? fromJson(Map<String, dynamic> json) {
    try {
      LocalFailure? failure;
      if ((json['error'] as int?) != null) {
        failure = LocalFailure(
          error: json['error'] as int,
          message: json['message'].toString(),
          extraInfo: json['extraInfo']?.toString(),
        );
        return LocationFailed(
          json['latitude'] as double,
          json['longitude'] as double,
          json['city'] as String,
          failure,
        );
      } else {
        return LocationSuccess(
          json['latitude'] as double,
          json['longitude'] as double,
          json['city'] as String,
        );
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(LocationState state) {
    try {
      return {
        'latitude': state.latitude,
        'longitude': state.longitude,
        'city': state.city,
        'error': state.failure?.error,
        'message': state.failure?.message,
        'extraInfo': state.failure?.extraInfo,
      };
    } catch (e) {
      return null;
    }
  }
}
