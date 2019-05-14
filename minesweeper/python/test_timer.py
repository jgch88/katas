from time import sleep
import unittest
from Timer import Timer

class TestTimer(unittest.TestCase):

    def test_timer_can_start(self):
        timer = Timer()
        timer.start()

    def test_timer_can_query_seconds_elapsed_after_starting(self):
        timer = Timer()
        timer.start()
        sleep(1)
        self.assertEqual(timer.seconds_elapsed(), 1)
        sleep(2)
        self.assertEqual(timer.seconds_elapsed(), 3)
