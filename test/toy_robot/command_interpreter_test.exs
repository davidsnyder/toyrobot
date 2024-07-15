defmodule ToyRobot.CommandInterpreterTest do
  use ExUnit.Case, async: true
  doctest ToyRobot.CommandInterpreter

  alias ToyRobot.CommandInterpreter

  test "handles all commands" do
    commands = ["PLACE 1,2,NORTH", "MOVE", "MOVE 2", "LEFT", "RIGHT", "REPORT"]
    commands |> CommandInterpreter.interpret()
  end

  test "marks invalid commands as invalid" do
    commands = ["SPIN", "TWIRL", "EXTERMINATE", "PLACE 1, 2, NORTH", "MOVE A", "move", "moVe"]
    output = commands |> CommandInterpreter.interpret()
    assert output == [
      {:invalid, "SPIN"},
      {:invalid, "TWIRL"},
      {:invalid, "EXTERMINATE"},
      {:invalid, "PLACE 1, 2, NORTH"},
      {:invalid, "MOVE A"},
      {:invalid, "move"},
      {:invalid, "moVe"}
    ]
  end
end
