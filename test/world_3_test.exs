defmodule Ebot.World3Test do
  use ExUnit.Case

  import ExUnit.CaptureIO

  # There are walls this time.
  # If a bot encounters a wall, they should "BONK" off the wall and not move.

  setup do
    world = [
      [ :space, :wall, :space, :space, :space, :space ],
      [ :space, :wall, :door, :wall, :wall, :space ],
      [ :space, :wall, :wall, :wall, :wall, :space ],
      [ :space, :space, :space, :space, :space, :space]
    ]
    bot = Ebot.Bot.spawn

    { :ok, [world: world, bot: bot] }
  end

  test "with the right instructions", context do
    instructions = """
    right
    forward
    forward
    forward
    left
    forward
    forward
    forward
    forward
    forward
    left
    forward
    forward
    forward
    left
    forward
    forward
    forward
    left
    forward
    """

    world = context[:world]
    bot = context[:bot]
    { bot, finished } = Ebot.Bot.run(world, bot, instructions)
    assert bot == { 2, 1 }
    assert finished == true
  end

  test "bumps into walls", context do
    instructions = """
    forward
    """

    world = context[:world]
    bot = context[:bot]
    assert capture_io(fn ->
      Ebot.Bot.run(world, bot, instructions)
    end) == "BONK! Hit wall at (1, 0)"

    { bot, finished } = Ebot.Bot.run(world, bot, instructions)

    assert bot == { 0, 0 }
    assert finished == false
  end
end


