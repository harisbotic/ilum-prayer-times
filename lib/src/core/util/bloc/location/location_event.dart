part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}

class InitLocation extends LocationEvent {
  @override
  List<Object> get props => [];
}

class ResetLocation extends LocationEvent {
  @override
  List<Object> get props => [];
}

class SetLocation extends LocationEvent {
  final double latitude;
  final double longitude;
  final String city;

  SetLocation(this.latitude, this.longitude, this.city);

  @override
  List<Object> get props => [latitude, longitude, city];
}
