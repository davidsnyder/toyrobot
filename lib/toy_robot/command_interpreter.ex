defmodule ToyRobot.CommandInterpreter do

  @doc """
  Interprets commands from a commands list in preparation for running them.

  ## Examples

  iex> alias ToyRobot.CommandInterpreter
  ToyRobot.CommandInterpreter
  iex> commands = ["PLACE 1,2,NORTH", "MOVE", "MOVE 2", "LEFT", "RIGHT", "REPORT"]
  ["PLACE 1,2,NORTH", "MOVE", "MOVE 2", "LEFT", "RIGHT", "REPORT"]
  iex> commands |> CommandInterpreter.interpret()
  [
    {:place, %{north: 2, east: 1, facing: :north}},
    {:move, 1},
    {:move, 2},
    :turn_left,
    :turn_right,
    :report
  ]
  """
  def interpret(commands) do
    commands |> Enum.map(&do_interpret/1)
  end

  defp do_interpret(("PLACE " <> _rest) = command) do
    place_format = ~r/\APLACE (\d+),(\d+),(NORTH|EAST|SOUTH|WEST)\z/
   case Regex.run(place_format, command) do
      [_command, east, north, facing] ->
        {:place, %{
          north: String.to_integer(north),
        east: String.to_integer(east),
        facing: facing |> String.downcase |> String.to_atom}}
        nil -> {:invalid, command}
    end
  end

  defp do_interpret(("MOVE " <> _rest) = command) do
    move_format = ~r/\AMOVE (\d+)\z/
    case Regex.run(move_format, command) do
      [_command, num_spaces] ->
      {:move, String.to_integer(num_spaces)}
      nil -> {:invalid, command}
    end
  end

  defp do_interpret("MOVE" <> _), do: {:move, 1}
  defp do_interpret("LEFT" <> _), do: :turn_left
  defp do_interpret("RIGHT" <> _), do: :turn_right
  defp do_interpret("REPORT" <> _), do: :report
  defp do_interpret(command), do: {:invalid, command}
end
