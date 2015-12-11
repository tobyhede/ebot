defmodule Ebot.BotTest do
  use ExUnit.Case

  test "spawns at 0,0" do
    assert Ebot.Bot.spawn == {0 , 0}
  end
end
