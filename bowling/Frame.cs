using System.Collections.Generic;
using System;
using System.Linq;

namespace Bowling
{
    public class Frame
    {
        private List<int> _rolls;

        public Frame()
        {
            _rolls = new List<int>();
        }

        public void AddRoll(int roll)
        {
            if (IsFull())
            {
                throw new Exception("Can't add roll to a full frame!");
            }

            _rolls.Add(roll);

            if (TotalRollsMoreThan10())
            {
                throw new Exception("You knocked down more than 10 pins in this frame!");
            }
        }

        public bool IsStrike()
        {
            return _rolls.Count == 1 && _rolls.Sum(roll => roll) == 10;
        }

        public bool IsFull()
        {
            return _rolls.Count == 2 || FirstRoll() == 10;
        }

        private bool TotalRollsMoreThan10()
        {
            return _rolls.Sum(roll => roll) > 10;
        }

        public bool IsSpare()
        {
            return _rolls.Count == 2 && _rolls.Sum(roll => roll) == 10;
        }

        public int FirstRoll()
        {
            if (_rolls.Count == 0)
            {
                return 0;
            } else
            {
                return _rolls[0];
            }
        }

        public int Score()
        {
            // only the total pins knocked down, no bonuses involved
            return _rolls.Sum(roll => roll);
        }
    }
}
