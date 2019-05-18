class Timer {
  DateTime _start_time;

  Timer() {}

  void start() {
    _start_time = new DateTime.now();
  }

  int seconds_elapsed() {
    Duration timeDifference = new DateTime.now().difference(_start_time);
    return timeDifference.inSeconds;
  }
}
