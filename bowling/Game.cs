using System;
using System.Collections.Generic;

namespace Bowling
{   
    public class Game
    {
        private int _currentFrameNumber;
        private List<Frame> _frames;
        private enum BonusPointStatuses { None, Spare, Strike };

        public Game()
        {
            _currentFrameNumber = 0;
            _frames = new List<Frame>();
            _frames.Add(new Frame());
        }

        public void Roll(int score)
        {
            if (!_frames[_currentFrameNumber].IsFull())
            {
                _frames[_currentFrameNumber].AddRoll(score);
            }
            else
            {
                _frames.Add(new Frame());
                _currentFrameNumber += 1;
                _frames[_currentFrameNumber].AddRoll(score);
            }
        }

        public int Score()
        {
            int pinPoints = 0; // number of pins that were knocked down
            int bonusPoints = 0; // extra points from spares/strikes
            BonusPointStatuses previousFrameBonusPointStatus = BonusPointStatuses.None;
            foreach (Frame frame in _frames)
            {
                pinPoints += frame.Score();
                bonusPoints += CalculateBonusPoints(frame, previousFrameBonusPointStatus);
                // refactor to use explicit classes!
                if (frame.IsSpare())
                {
                    previousFrameBonusPointStatus = BonusPointStatuses.Spare;
                }
                else
                {
                    previousFrameBonusPointStatus = BonusPointStatuses.None;
                }
            }
            return pinPoints + bonusPoints;
        }

        private int CalculateBonusPoints(Frame frame, BonusPointStatuses previousFrame)
        {
            // base case (no bonus): 0
            // spare: add only first roll
            // strike: add next two rolls
            if (previousFrame == BonusPointStatuses.Spare)
            {
                return frame.FirstRoll();
            }

            return 0;
        }
    }
}
