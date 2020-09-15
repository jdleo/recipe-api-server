from django.test import TestCase

from app.calc import add


class CalcTests(TestCase):
    # tests must begin with test_
    def test_add_numbers(self):
        """Test that two numbers are added properly"""
        self.assertEqual(add(3, 8), 11)
