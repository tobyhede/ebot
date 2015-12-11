# In this test, the bot moves along a narrow corridor.
# It can move forward and backward, and should not be able to fall off the edge of the map.
# The end result of the tests are a combination of:
# 1. The bot's position
# 2. Whether or not the bot finishes at the door

defmodule Ebot.World1Test do
  use ExUnit.Case

  setup do
    world = [ :space, :space, :space, :door ]
    bot = Ebot.Bot.spawn

    { :ok, [world: world, bot: bot] }
  end

  test "with the right instructions", context do
    instructions = """
    forward
    forward
    forward
    """

    world = context[:world]
    bot = context[:bot]
    { bot, finished } = Ebot.Bot.run(world, bot, instructions)
    assert bot == { 3, 0 }
    assert finished == true
  end

  test "two steps forward, one step backwards", context do
    instructions = """
    forward
    forward
    back
    """

    world = context[:world]
    bot = context[:bot]
    { bot, finished } = Ebot.Bot.run(world, bot, instructions)
    assert bot == { 1, 0 }
    assert finished == false
  end

  test "does not fall off the edge", context do
    instructions = """
    forward
    forward
    forward
    forward
    """

    world = context[:world]
    bot = context[:bot]
    { bot, finished } = Ebot.Bot.run(world, bot, instructions)
    assert bot == { 3, 0 }
    assert finished == true # bot bounces off the "wall" and finishes at the door
  end
end
