import 'package:test/test.dart';
import 'dart:io';
import './Timer.dart';

void main() {
  test('Timer can start', () {
    Timer timer = Timer();
    timer.start();
  });

  test('Timer can query seconds elapsed after starting', () {
    Timer timer = Timer();
    timer.start();
    sleep(const Duration(seconds:1));
    expect(timer.seconds_elapsed(), 1);
    sleep(const Duration(seconds:2));
    expect(timer.seconds_elapsed(), 3);
  });
}
