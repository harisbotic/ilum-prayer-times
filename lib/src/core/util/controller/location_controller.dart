import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import 'package:geolocator/geolocator.dart';

import '../../error/error_code.dart';
import '../../error/failures.dart';

/// Function to get current position of user
Future<Either<LocalFailure, Position>> getCurrentPosition() async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    /// if user is not enabling the location service
    // await Geolocator.openLocationSettings();
    return Left(
      LocalFailure(
        message: kLocationDisable['message'],
        error: kLocationDisable['errorCode'] as int,
      ),
    );
  }

  /// get the current permission for location service
  final LocationPermission permission = await Geolocator.checkPermission();
  LocationPermission newPermission = LocationPermission.denied;

  if (permission == LocationPermission.denied && Platform.isAndroid) {
    newPermission = await Geolocator.requestPermission();

    if (newPermission == LocationPermission.deniedForever) {
      return Left(
        LocalFailure(
          message: kLocationDisableForever['message'],
          error: kLocationDisableForever['errorCode'] as int,
        ),
      );
    }
  }

  /// catch second dialog dismissed
  if (permission == LocationPermission.denied &&
      newPermission == LocationPermission.denied &&
      Platform.isAndroid) {
    return Left(
      LocalFailure(
        message: kLocationDisable['message'],
        error: kLocationDisable['errorCode'] as int,
      ),
    );
  }

  if (permission == LocationPermission.denied && Platform.isIOS) {
    /// when first time using the app or allow once
    /// prompt user to select
    newPermission = await Geolocator.requestPermission();

    if (newPermission == LocationPermission.deniedForever) {
      return Left(
        LocalFailure(
          message: kLocationDisableForever['message'],
          error: kLocationDisableForever['errorCode'] as int,
        ),
      );
    }
  }

  if (permission == LocationPermission.deniedForever && Platform.isIOS) {
    /// happen in ios only when user click on deny
    /// allow user to go to setting and enable back
    // await Geolocator.openLocationSettings();
    return Left(
      LocalFailure(
        message: kLocationDisableForever['message'],
        error: kLocationDisableForever['errorCode'] as int,
      ),
    );
  }

  final Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.medium,
  );

  return Right(position);
}

Future<void> openLocationSetting() async {
  await Geolocator.openLocationSettings();
}

Future<String> getCityFromCoordinates(double latitude, double longitude) async {
  try {
    final csv = await rootBundle.loadString('assets/csv/city_list.csv');
    final cities = CsvToListConverter().convert(csv, eol: '\n');

    var nearestCity = {"name": "", "country_code": ""};
    double nearestCityDistance = double.maxFinite;
    cities.skip(1).forEach((c) {
      final distance = LocationDistanceCalculatorService.distanceFromDegrees(
        latitude,
        longitude,
        c[1] as double,
        c[2] as double,
      );

      if (distance < nearestCityDistance) {
        nearestCityDistance = distance;
        nearestCity = {
          "name": c[0],
          "country_code": c[3].toString().trimRight()
        };
      }
    });
    return nearestCity["name"]!;
  } catch (e) {
    return 'Failed to get city name';
  }
}

class LocationDistanceCalculatorService {
  static double distanceFromDegrees(
          double lat1, double lon1, double lat2, double lon2) =>
      distanceFromRadians(_radiansFromDegrees(lat1), _radiansFromDegrees(lon1),
          _radiansFromDegrees(lat2), _radiansFromDegrees(lon2));

  static double distanceFromRadians(
      double lat1, double lon1, double lat2, double lon2) {
    // Implementation of the Haversine formula to calculate geographic distance on earth
    // see https://en.wikipedia.org/wiki/Haversine_formula
    // Accuracy: This offer calculations on the basis of a spherical earth (ignoring ellipsoidal effects)

    var earthRadius = 6378137.0; // WGS84 major axis
    double distance = 2 *
        earthRadius *
        asin(sqrt(pow(sin(lat2 - lat1) / 2, 2) +
            cos(lat1) * cos(lat2) * pow(sin(lon2 - lon1) / 2, 2)));

    return distance;
  }

  static double _radiansFromDegrees(final double degrees) =>
      degrees * (pi / 180.0);
}
