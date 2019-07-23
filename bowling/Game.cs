using System;
using System.Collections.Generic;

namespace Bowling
{   
    public class Game
    {
        private int _currentFrameNumber;
        private List<Frame> _frames;

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
            // To calculate the score, we get the score of each frame.
            // To get the score of each frame, we add its pins, and we add bonus points.
            // To get spare bonus points, we add the first roll of the next frame.
            // To get strike bonus points, if the next frame is a strike, we add that frame's score
            // and the next next frame's first roll
            // else we just add the next frame's score.
            int pinPoints = 0;
            int sparePoints = 0;
            int strikePoints = 0;

            int framesToScore = Math.Min(_frames.Count, 10); // Don't score bonus frames

            for (int i = 0; i < framesToScore; i++)
            {
                pinPoints += _frames[i].Score();
                if (_frames[i].IsSpare())
                {
                    sparePoints += CalculateSpareBonusPoints(i);
                } 
                else if (_frames[i].IsStrike())
                {
                    strikePoints += CalculateStrikeBonusPoints(i);
                }
            }
            return pinPoints + sparePoints + strikePoints;
        }

        private int CalculateSpareBonusPoints(int frameIndex)
        {
            return _frames[frameIndex+ 1].FirstRoll();
        }

        private int CalculateStrikeBonusPoints(int frameIndex)
        {
            int strikeBonusForFrame = 0;

            if (_frames[frameIndex + 1].IsStrike())
            {
                strikeBonusForFrame += _frames[frameIndex + 1].Score();
                strikeBonusForFrame += _frames[frameIndex + 2].FirstRoll();
            }
            else
            {
                strikeBonusForFrame += _frames[frameIndex + 1].Score();
            }

            return strikeBonusForFrame; 
        }
    }
}
