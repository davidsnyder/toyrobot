defmodule ToyRobot.CommandInterpreter do

  @doc """
  Interprets commands from a commands list in preparation for running them.

  ## Examples

  iex> alias ToyRobot.CommandInterpreter
  ToyRobot.CommandInterpreter
  iex> commands = ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
  ["PLACE 1,2,NORTH", "MOVE", "LEFT", "RIGHT", "REPORT"]
  iex> commands |> CommandInterpreter.interpret()
  [
    {:place, %{north: 2, east: 1, facing: :north}},
    :move,
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

  defp do_interpret("MOVE" <> _), do: :move
  defp do_interpret("LEFT" <> _), do: :turn_left
  defp do_interpret("RIGHT" <> _), do: :turn_right
  defp do_interpret("REPORT" <> _), do: :report
  defp do_interpret(command), do: {:invalid, command}
end
