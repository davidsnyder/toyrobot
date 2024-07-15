defmodule ToyRobot.Simulation do
  alias ToyRobot.{Robot, Table, Simulation}

  defstruct [:table, :robot]

  @doc """
  Simulates placing a robot on a table.

  ## Examples

      iex> alias ToyRobot.{Robot, Table, Simulation}
      [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> Simulation.place(table, %{north: 0, east: 0, facing: :north})
      {
        :ok,
        %Simulation{
          table: table,
          robot: %Robot{north: 0, east: 0, facing: :north}
        }
      }

  When the robot is placed in an invalid position.

  ## Examples

      iex> alias ToyRobot.{Table, Simulation}
      [ToyRobot.Table, ToyRobot.Simulation]
      iex> table = %Table{north_boundary: 4, east_boundary: 4}
      %Table{north_boundary: 4, east_boundary: 4}
      iex> Simulation.place(table, %{north: 6, east: 0, facing: :north})
      {
        :error,
        :invalid_placement
      }

  """
  def place(table, placement) do
    if Table.valid_position?(table, placement) do
      {
        :ok,
        %Simulation{
          table: table,
          robot: struct(Robot, placement)
      }
      }
    else
      {:error, :invalid_placement}
    end
  end

  @doc """
  Moves the robot one step forward in the direction it is facing, while checking for out of bounds

  ## Examples
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{table: table, robot: %Robot{north: 0, east: 0, facing: :north}}
  iex> Simulation.move(simulation, 1)
  {:ok, %Simulation{
    table: table,
    robot: %Robot{north: 1, east: 0, facing: :north}
  }}

  Returns an error if moving the robot at the current heading will result in it falling off the table

  ## Examples
  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{table: table, robot: %Robot{north: 4, east: 0, facing: :north}}
  iex> Simulation.move(simulation, 1)
  {:error, :at_table_boundary}
  """
  def move(%Simulation{table: table, robot: robot} = simulation, steps) do
    with moved_robot <- robot |> Robot.move(steps),
    true <- Table.valid_position?(table, moved_robot)
    do
    {:ok, %{simulation | robot: Robot.move(robot, steps)}}
    else
      false -> {:error, :at_table_boundary}
    end
  end

  def turn_left(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: Robot.turn_left(robot)}}
  end

  def turn_right(%Simulation{robot: robot} = simulation) do
    {:ok, %{simulation | robot: Robot.turn_right(robot)}}
  end

  @doc """
  Returns the robot's current position.

  ## Examples

  iex> alias ToyRobot.{Robot, Table, Simulation}
  [ToyRobot.Robot, ToyRobot.Table, ToyRobot.Simulation]
  iex> table = %Table{north_boundary: 4, east_boundary: 4}
  %Table{north_boundary: 4, east_boundary: 4}
  iex> simulation = %Simulation{table: table, robot: %Robot{north: 0, east: 0, facing: :north}}
  iex> Simulation.report(simulation)
  %Robot{north: 0, east: 0, facing: :north}
  """
  def report(%Simulation{robot: robot}) do
    robot
  end
end
