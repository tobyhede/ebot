defmodule Ebot.BotTest do
  use ExUnit.Case

  test "spawns at 0,0 and faces east" do
    assert Ebot.Bot.spawn == {0 , 0, :east}
  end
end
