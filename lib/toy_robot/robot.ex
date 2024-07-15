defmodule ToyRobot.Robot do
  alias ToyRobot.Robot

  defstruct [north: 0, east: 0, facing: :north]

    @doc """
  Moves the robot forward @steps steps in the direction it is facing.

  ## Examples

      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{north: 0, facing: :north}
      %Robot{north: 0, facing: :north}
      iex> Robot.move(robot, 1)
      %Robot{north: 1}

      iex> alias ToyRobot.Robot
      ToyRobot.Robot
      iex> robot = %Robot{north: 0, facing: :north}
      %Robot{north: 0, facing: :north}
      iex> Robot.move(robot, 2)
      %Robot{north: 2}

  """
  def move(%Robot{facing: :north} = robot, steps) do
    move_north(robot, steps)
  end

  def move(%Robot{facing: :east} = robot, steps) do
    move_east(robot, steps)
  end

  def move(%Robot{facing: :south} = robot, steps) do
    move_south(robot, steps)
  end

  def move(%Robot{facing: :west} = robot, steps) do
    move_west(robot, steps)
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

  defp move_east(robot, steps) do
    %Robot{robot | east: robot.east + steps}
  end

  defp move_west(robot, steps) do
    %Robot{robot | east: robot.east - steps}
  end

  defp move_north(robot, steps) do
    %Robot{robot | north: robot.north + steps}
  end

  defp move_south(robot, steps) do
    %Robot{robot | north: robot.north - steps}
  end
end
