using Xunit;
using Bowling;
using System;

namespace UnitTests
{
    public class GameTests
    {
        [Fact]
        public void TestGameCanRoll()
        { 
            Game game = new Game();
            game.Roll(5);
        }

        [Fact]
        public void TestGameCanScoreRolls()
        {
            Game game = new Game();
            Assert.Equal(0, game.Score());
            game.Roll(5);
            Assert.Equal(5, game.Score());
        }

        [Fact]
        public void TestGameCanScoreTwoRolls()
        {
            Game game = new Game();
            game.Roll(9);
            game.Roll(1);
            Assert.Equal(10, game.Score());
        }

        [Fact]
        public void TestGameCanScoreSpares()
        {
            Game game = new Game();
            game.Roll(7);
            game.Roll(3);
            game.Roll(4);
            game.Roll(2);
            Assert.Equal(20, game.Score());
        }
    }

    public class FrameTests
    {
        [Fact]
        public void TestFrameCanAddRolls()
        {
            Frame frame = new Frame();
            frame.AddRoll(5);
        }

        [Fact]
        public void TestFrameCannotAddMoreThanTwoRolls()
        {
            Frame frame = new Frame();
            frame.AddRoll(5);
            frame.AddRoll(5);
            var exception = Assert.Throws<Exception>(() => frame.AddRoll(5));
            Assert.Equal("Can't add roll to a full frame!", exception.Message);
        }

        [Fact]
        public void TestFrameCannotHaveTotalRollsAbove10()
        {
            Frame frame = new Frame();
            frame.AddRoll(5);
            var exception = Assert.Throws<Exception>(() => frame.AddRoll(6)); // Impossible to have 11 pins!
            Assert.Equal("You knocked down more than 10 pins in this frame!", exception.Message);
        }

        [Fact]
        public void TestFrameCannotAddSecondRollIfFirstRollIsStrike()
        {
            Frame frame = new Frame();
            frame.AddRoll(10);
            var exception = Assert.Throws<Exception>(() => frame.AddRoll(0));
            Assert.Equal("You cannot add a second roll to a frame containing a strike!", exception.Message);
        }

        [Fact]
        public void TestFrameCanQueryIfItIsAStrike()
        {
            Frame frame = new Frame();
            frame.AddRoll(10);
            Assert.True(frame.IsStrike());
        }

        [Fact]
        public void TestFrameCanQueryIfItIsASpare()
        {
            Frame frame = new Frame();
            frame.AddRoll(5);
            frame.AddRoll(5);
            Assert.False(frame.IsStrike()); // A strike is not a spare
            Assert.True(frame.IsSpare());
        }

        [Fact]
        public void TestFrameCanQueryFirstRoll()
        {
            Frame frame = new Frame();
            Assert.Equal(0, frame.FirstRoll()); // Defaults to 0 if no rolls yet
            frame.AddRoll(5);
            Assert.Equal(5, frame.FirstRoll());
        }

        [Fact]
        public void TestFrameCanQueryScore()
        {
            Frame frame = new Frame();
            frame.AddRoll(5);
            frame.AddRoll(3);
            Assert.Equal(8, frame.Score());
        }

        // is spare
        // is strike
        // frame number #?
        // test coverage?
        // 3 rolls for last frame if double strikes
    }
}