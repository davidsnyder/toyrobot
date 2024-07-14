defmodule ToyRobot.CommandRunnerTest do
  use ExUnit.Case, async: true
  doctest ToyRobot.CommandRunner

  alias ToyRobot.{CommandRunner, Simulation}

  test "handles a valid place command" do
    %Simulation{robot: robot} = CommandRunner.run([{:place, %{east: 1, north: 2, facing: :north}}])

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "handles an invalid place command" do
    simulation = CommandRunner.run([{:place, %{east: 10, north: 10, facing: :north}}])
    assert simulation == nil
  end

  test "ignores commands until a valid placement" do
    %Simulation{robot: robot} = CommandRunner.run([:move, {:place, %{east: 1, north: 2, facing: :north}}])

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "handles a valid place + move command" do
    %Simulation{robot: robot} = CommandRunner.run([{:place, %{east: 1, north: 2, facing: :north}}, :move])

    assert robot.east == 1
    assert robot.north == 3
    assert robot.facing == :north
  end

  test "handles a place + invalid move command" do
    %Simulation{robot: robot} = CommandRunner.run([{:place, %{east: 1, north: 4, facing: :north}}, :move])

    assert robot.east == 1
    assert robot.north == 4
    assert robot.facing == :north
  end
end
