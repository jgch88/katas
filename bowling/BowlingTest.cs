using Xunit;
using System;
using Bowling;

namespace UnitTests
{
    public class GameTests
    {
        [Fact]
        public void TestGameCanRoll()
        { 
            Game game = new Game();
            Assert.Equal(0, game.score);
            game.roll("5");
            Assert.Equal(5, game.score);
        }
    }
}