from time import time

class Timer:

    def __init__(self):
        pass

    def start(self):
        self._start_time = time()

    def seconds_elapsed(self):
        return round(time() - self._start_time)

