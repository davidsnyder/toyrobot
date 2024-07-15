defmodule ToyRobot.CommandRunnerTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
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
    %Simulation{robot: robot} = CommandRunner.run([{:place, %{east: 1, north: 2, facing: :north}}, {:move, 1}])

    assert robot.east == 1
    assert robot.north == 3
    assert robot.facing == :north
  end

  test "handles a valid place + move N command" do
    %Simulation{robot: robot} = CommandRunner.run([{:place, %{east: 1, north: 2, facing: :east}}, {:move, 2}])

    assert robot.east == 3
    assert robot.north == 2
    assert robot.facing == :east
  end

  test "handles a place + invalid move command" do
    %Simulation{robot: robot} = CommandRunner.run([{:place, %{east: 1, north: 4, facing: :north}}, {:move, 1}])

    assert robot.east == 1
    assert robot.north == 4
    assert robot.facing == :north
  end

  test "handles a place + invalid command" do
    %Simulation{robot: robot} = CommandRunner.run([
      {:place, %{east: 1, north: 2, facing: :north}},
    {:invalid, "EXTERMINATE"}
    ])

    assert robot.east == 1
    assert robot.north == 2
    assert robot.facing == :north
  end

  test "handles a place + report command" do
    commands = [{:place, %{east: 1, north: 2, facing: :north}}, :report]

    output = capture_io fn ->
      CommandRunner.run(commands)
    end

    assert output |> String.trim == "The robot is at (1, 2) and is facing NORTH"
  end
end
