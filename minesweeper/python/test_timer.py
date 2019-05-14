import unittest
from Timer import Timer

class TestTimer(unittest.TestCase):

    def test_timer_can_start(self):
        timer = Timer()
        timer.start()
