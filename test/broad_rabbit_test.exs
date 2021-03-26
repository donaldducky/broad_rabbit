defmodule BroadRabbitTest do
  use ExUnit.Case
  doctest BroadRabbit

  test "greets the world" do
    assert BroadRabbit.hello() == :world
  end
end
