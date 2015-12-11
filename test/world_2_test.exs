defmodule Ebot.World2Test do
  use ExUnit.Case

  # The world now is a bit more open. Instead of a corridor, it's a room.
  # There's two new directions in this test: "left" and "right"
  # The bot starts out looking "east".

  # "left" means rotate left 90 degrees.
  # From the starting position, a "left" rotation means the bot will face "north". 

  # "right" means rotate right 90 degrees
  # From the starting position, a "right" rotation means the bot will face "south". 

  setup do
    world = [
      [ :space, :space, :space, :space ],
      [ :space, :space, :space, :door ]
    ]
    bot = Ebot.Bot.spawn

    { :ok, [world: world, bot: bot] }
  end

  test "with the right instructions", context do
    instructions = """
    forward
    forward
    forward
    right
    forward
    """

    world = context[:world]
    bot = context[:bot]
    { bot, finished } = Ebot.Bot.run(world, bot, instructions)
    assert bot == { 3, 1 }
    assert finished == true
  end

  test "an alternate path", context do
    instructions = """
    right
    forward
    left
    forward
    forward
    forward
    """

    world = context[:world]
    bot = context[:bot]
    { bot, finished } = Ebot.Bot.run(world, bot, instructions)
    assert bot == { 3, 1 }
    assert finished == true
  end

  test "wandering almost aimlessly", context do
    instructions = """
    forward
    right
    forward
    left
    forward
    left
    forward
    right
    forward
    right
    forward
    """

    world = context[:world]
    bot = context[:bot]
    { bot, finished } = Ebot.Bot.run(world, bot, instructions)
    assert bot == { 3, 1 }
    assert finished == true
  end

  test "does not fall off the world", context do
    instructions = """
    forward
    left
    forward
    forward
    """

    world = context[:world]
    bot = context[:bot]
    { bot, finished } = Ebot.Bot.run(world, bot, instructions)
    assert bot == { 1, 0 }
    assert finished == false
  end
end
