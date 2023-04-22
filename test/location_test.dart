import 'package:flutter_test/flutter_test.dart';
import 'package:sirat_e_mustaqeem/src/core/util/controller/location_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('getCityFromCoordinates is accurate', () async {
    double latitude = 43.8563;
    double longitute = 18.4131;
    String expectedCity = "Sarajevo";

    String city = await getCityFromCoordinates(latitude, longitute);

    expect(city, expectedCity);
  });

  test('getCityFromCoordinates is fast', () async {
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();

    await getCityFromCoordinates(1, 1);

    stopwatch.stop();

    // Compare the result with the expected output
    expect(stopwatch.elapsedMilliseconds, lessThan(200));
  });
}
