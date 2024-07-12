defmodule ToyRobot.Robot do
  alias ToyRobot.Robot

  defstruct [north: 0, east: 0, facing: :north]

    @doc """
  Moves the robot forward one space in the direction it is facing.

  ## Examples

      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{north: 0, facing: :north}
      %Robot{north: 0, facing: :north}
      iex> robot |> Robot.move
      %Robot{north: 1}

  """
  def move(%Robot{facing: :north} = robot) do
    robot |> move_north
  end

  def move(%Robot{facing: :east} = robot) do
    robot |> move_east
  end

  def move(%Robot{facing: :south} = robot) do
    robot |> move_south
  end

  def move(%Robot{facing: :west} = robot) do
    robot |> move_west
  end

      @doc """
  Turns the robot left.

  ## Examples

      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{north: 0, facing: :north}
      %Robot{north: 0, facing: :north}
      iex> robot |> Robot.turn_left
      %Robot{facing: :west}

  """
  def turn_left(%Robot{facing: facing} = robot) do
    case facing do
      :north -> %Robot{robot | facing: :west}
      :east -> %Robot{robot | facing: :north}
      :south -> %Robot{robot | facing: :east}
      :west -> %Robot{robot | facing: :south}
    end
  end

        @doc """
  Turns the robot right.

  ## Examples

      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{north: 0, facing: :north}
      %Robot{north: 0, facing: :north}
      iex> robot |> Robot.turn_right
      %Robot{facing: :east}

  """
  def turn_right(%Robot{facing: facing} = robot) do
    case facing do
      :north -> %Robot{robot | facing: :east}
      :east -> %Robot{robot | facing: :south}
      :south -> %Robot{robot | facing: :west}
      :west -> %Robot{robot | facing: :north}
    end
  end

  defp move_east(robot) do
    %Robot{robot | east: robot.east + 1}
  end

  defp move_west(robot) do
    %Robot{robot | east: robot.east - 1}
  end

  defp move_north(robot) do
    %Robot{robot | north: robot.north + 1}
  end

  defp move_south(robot) do
    %Robot{robot | north: robot.north - 1}
  end
end
