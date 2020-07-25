defmodule RobotSimulator do

  defguard is_valid_direction(direction) when direction in [:north, :east, :south, :west]

  defguard is_valid_position(x, y) when is_integer(x) and is_integer(y)

  defmodule Robot do
    defstruct direction: :north, position: {0, 0}
  end

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction, {x, y} = position) when is_valid_direction(direction) and is_valid_position(x, y), do: %Robot{direction: direction, position: position}
  def create(direction, _) when is_valid_direction(direction), do: {:error, "invalid position"}
  def create(_, _), do: {:error, "invalid direction"}
  def create(), do: %Robot{}
  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(%Robot{} = robot, instructions) do
    instructions
      |> String.graphemes
      |> Enum.reduce(robot, &move(&2, &1) )
  end

  def move(%Robot{direction: :north} = robot, "L"), do: %{robot | direction: :west}
  def move(%Robot{direction: :south} = robot, "L"), do: %{robot | direction: :east}
  def move(%Robot{direction: :east} = robot, "L"), do: %{robot | direction: :north}
  def move(%Robot{direction: :west} = robot, "L"), do: %{robot | direction: :south}

  def move(%Robot{direction: :north} = robot, "R"), do: %{robot | direction: :east}
  def move(%Robot{direction: :south} = robot, "R"), do: %{robot | direction: :west}
  def move(%Robot{direction: :east} = robot, "R"), do: %{robot | direction: :south}
  def move(%Robot{direction: :west} = robot, "R"), do: %{robot | direction: :north}

  def move(%Robot{direction: :north, position: {x, y}} = robot, "A"), do: %{robot | position: {x, y+1}}
  def move(%Robot{direction: :south, position: {x, y}} = robot, "A"), do: %{robot | position: {x, y-1}}
  def move(%Robot{direction: :east, position: {x, y}} = robot, "A"), do: %{robot | position: {x+1, y}}
  def move(%Robot{direction: :west, position: {x, y}} = robot, "A"), do: %{robot | position: {x-1, y}}

  def move(_, _), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%Robot{direction: direction} = robot) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%Robot{position: position} = robot) do
    position
  end
end
