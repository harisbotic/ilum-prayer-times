part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  final double latitude;
  final double longitude;
  final String city;
  final LocalFailure? failure;

  const LocationState(
    this.latitude,
    this.longitude,
    this.city, {
    this.failure,
  });
}

class LocationInitial extends LocationState {
  const LocationInitial(
      double latitude, double longitude, String city, LocalFailure failure)
      : super(latitude, longitude, city, failure: failure);

  @override
  List<Object> get props => [latitude, longitude, city];
}

class LocationLoading extends LocationState {
  const LocationLoading(double latitude, double longitude, String city)
      : super(latitude, longitude, city);

  @override
  List<Object> get props => [latitude, longitude, city];
}

class LocationSuccess extends LocationState {
  const LocationSuccess(double latitude, double longitude, String city)
      : super(latitude, longitude, city);

  @override
  List<Object> get props => [latitude, longitude, city];
}

class LocationFailed extends LocationState {
  const LocationFailed(
      double latitude, double longitude, String city, LocalFailure failure)
      : super(latitude, longitude, city, failure: failure);

  @override
  List<Object> get props => [latitude, longitude, city];
}
