using System;
using System.Collections.Generic;

namespace Bowling
{   
    public class Game
    {
        private int _score;
        private int _currentFrameNumber;
        private List<Frame> _frames;

        public Game()
        {
            _score = 0;
            _currentFrameNumber = 0;
            _frames = new List<Frame>();
            _frames.Add(new Frame());
        }

        public void Roll(int score)
        {
            _score += score;
        }

        public int Score()
        {
            return _score;
        }
    }
}
