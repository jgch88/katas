using System;

namespace Bowling
{   
    public class Game
    {
        public int score { get; internal set; }

        public void roll(string score)
        {
            int s = Int32.Parse(score);
            this.score += s;
        }

        public Game()
        {
            this.score = 0;
        }
    }
}
