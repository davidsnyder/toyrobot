defmodule ToyRobot.RobotTest do
  use ExUnit.Case
  doctest ToyRobot.Robot
  alias ToyRobot.Robot

  describe "when the robot is facing north" do
    setup do
      {:ok, %{robot: %Robot{north: 0, facing: :north}}}
    end

    test "it moves one space north", %{robot: robot} do
      robot = Robot.move(robot, 1)
      assert robot.north == 1
    end

    test "it moves two spaces north", %{robot: robot} do
      robot = Robot.move(robot, 2)
      assert robot.north == 2
    end

    test "it turns left to face west", %{robot: robot} do
      robot = robot |> Robot.turn_left
      assert robot.facing == :west
    end

    test "it turns right to face east", %{robot: robot} do
      robot = robot |> Robot.turn_right
      assert robot.facing == :east
    end
  end

  describe "when the robot is facing east" do
    setup do
      {:ok, %{robot: %Robot{east: 0, facing: :east}}}
    end

    test "it moves one space east", %{robot: robot} do
      robot = Robot.move(robot, 1)
      assert robot.east == 1
    end

    test "it turns left to face north", %{robot: robot} do
      robot = robot |> Robot.turn_left
      assert robot.facing == :north
    end

    test "it turns right to face south", %{robot: robot} do
      robot = robot |> Robot.turn_right
      assert robot.facing == :south
    end
  end

  describe "when the robot is facing south" do
    setup do
      {:ok, %{robot: %Robot{north: 0, facing: :south}}}
    end

    test "it moves one space south", %{robot: robot} do
      robot = Robot.move(robot, 1)
      assert robot.north == -1
    end

    test "it turns left to face east", %{robot: robot} do
      robot = robot |> Robot.turn_left
      assert robot.facing == :east
    end

    test "it turns right to face west", %{robot: robot} do
      robot = robot |> Robot.turn_right
      assert robot.facing == :west
    end
  end

  describe "when the robot is facing west" do
    setup do
      {:ok, %{robot: %Robot{east: 0, facing: :west}}}
    end

    test "it moves one space west", %{robot: robot} do
      robot = Robot.move(robot, 1)
      assert robot.east == -1
    end

    test "it turns left to face south", %{robot: robot} do
      robot = robot |> Robot.turn_left
      assert robot.facing == :south
    end

    test "it turns right to face north", %{robot: robot} do
      robot = robot |> Robot.turn_right
      assert robot.facing == :north
    end
  end

  describe "when the robot is facing north after it has moved forward a space" do
    setup do
      {:ok, %{robot: %Robot{north: 1, facing: :north}}}
    end

    test "turns right to face east", %{robot: robot} do
      robot = robot |> Robot.turn_right
      assert robot.facing == :east
      assert robot.north == 1
    end

    test "turns left to face west", %{robot: robot} do
      robot = robot |> Robot.turn_left
      assert robot.facing == :west
      assert robot.north == 1
    end
  end

  describe "when the robot is facing east and it has moved north once" do
    setup do
      {:ok, %{robot: %Robot{north: 1, facing: :east}}}
    end

    test "moves east one space", %{robot: robot} do
      robot = Robot.move(robot, 1)
      assert robot.north == 1
      assert robot.east == 1
      assert robot.facing == :east
    end

  end
end
