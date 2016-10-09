defmodule Knapsack.Knapsack01 do
  defmodule Item do
    defstruct value: 0, weight: 0, metadata: nil
  end

  # 0/1 Knapsack bin-packing Algorithm
  #
  # See for details: https://en.wikipedia.org/wiki/Knapsack_problem#0.2F1_knapsack_problem
  #
  # Packs as many items into the bin as possible.
  #
  # Algorithm works like this:
  # - Initialize solution matrix
  #   - m[0, j] = 0
  # - Populate solution matrix
  #   - m[i, j] = m[i - 1, j] for w[i] > j
  #   - m[i, j] = max(m[i - 1, j], m[i - 1, j - w[i]] + v[i]) for w[i] < j
  #   - keep[i, j] = 1 for new value > old value
  #   - keep[i, j] = 0 for new value <= old value
  # - Calculate solution from matrix

  def pack(items, capacity) do
    # Construct the solution matrix
    first_row = for _ <- 0..capacity, do: { 0, false }
    # We don't actually need the 'solution', which is the optimal value
    # for the knapsack. We need the list of items to fit in the knapsack.
    solution_matrix = populate_solution_matrix(items, capacity, first_row)

    # Reverse the lists so that we can iterate backwards to find the solution
    find_solution(Enum.reverse(items), Enum.reverse(solution_matrix), capacity)
  end

  defp populate_solution_matrix([], _capacity, _prev_row), do: []

  defp populate_solution_matrix([current_item | rest], capacity, prev_row) do
    row = build_row(current_item, prev_row, capacity)
    [row | populate_solution_matrix(rest, capacity, row)]
  end

  # Recursively build the row in the matrix
  #
  # Each entry in the matrix is actually a tuple of "max value" and "keep"
  defp build_row(item, prev_row, capacity, j \\ 0)

  defp build_row(_item, _prev_row, capacity, j) when j == capacity + 1, do: []

  defp build_row(%Item{weight: weight} = item, prev_row, capacity, j) when weight > j do
    #   - m[i, j] = m[i - 1, j] for w[i] > j
    # Elem.at is not great because it executes O(n)
    { prev_value, _ } = Enum.at(prev_row, j)
    keep_flag = false
    entry = { prev_value, keep_flag }
    [ entry | build_row(item, prev_row, capacity, j + 1) ]
  end

  defp build_row(item, prev_row, capacity, j) do
    #   - m[i, j] = max(m[i - 1, j], m[i - 1, j - w[i]] + v[i]) for w[i] < j
    # m[i - 1, j]
    { prev_value, _ } = Enum.at(prev_row, j)

    # m[i - 1, j - w[i]] + v[i]

    { older_value, _ } = Enum.at(prev_row, j - item.weight)
    potential_new_value = older_value + item.value
    keep_flag = potential_new_value > prev_value
    new_value = Enum.max([prev_value, potential_new_value])
    [ { new_value, keep_flag } | build_row(item, prev_row, capacity, j + 1) ]
  end

  defp find_solution(items, _solution_matrix, _capacity) when items == [], do: []

  defp find_solution([ item | rest_items ], [ solution_row | rest_solution ], capacity) do
    { _, keep_flag } = Enum.at(solution_row, capacity)
    if keep_flag do
      [ item | find_solution(rest_items, rest_solution, capacity - item.weight) ]
    else
      find_solution(rest_items, rest_solution, capacity)
    end
  end
end
