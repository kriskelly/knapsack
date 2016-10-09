defmodule Knapsack.Knapsack01Test do
  use ExUnit.Case
  doctest Knapsack

  alias Knapsack.Knapsack01
  alias Knapsack.Knapsack01.Item

  test "knapsack packing algorithm" do
    items = [
      %Item{ weight: 20, value: 5},
      %Item{ weight: 1, value: 1},
      %Item{ weight: 2, value: 2}
    ]

    total_weight = 20

    packed_items = Knapsack01.pack(items, total_weight)

    assert length(packed_items) == 1
    [first_item | _] = packed_items
    assert first_item.weight == 20
  end

  test "knapsack packing algorithm (choose 2)" do
    small = %Item{ weight: 5, value: 1}
    medium = %Item{ weight: 10, value: 2}
    large = %Item{ weight: 100, value: 5}
    items = [small, medium, large]

    total_weight = 95

    packed_items = MapSet.new(Knapsack01.pack(items, total_weight))
    assert MapSet.size(packed_items) == 2
    assert MapSet.member?(packed_items, small)
    assert MapSet.member?(packed_items, medium)
  end

  test "knapsack algorithm (choose highest value)" do
    items = [
      %Item{ weight: 100, value: 5},
      %Item{ weight: 5, value: 1},
      %Item{ weight: 10, value: 2}
    ]

    total_weight = 10
    packed_items = Knapsack01.pack(items, total_weight)
    assert length(packed_items) == 1
    [first_item] = packed_items
    assert first_item.weight == 10
  end

  test "choose higher value combination" do
    items = [
      %Item{ weight: 20, value: 5},
      %Item{ weight: 1, value: 3, metadata: 1},
      %Item{ weight: 1, value: 2, metadata: 2},
      %Item{ weight: 1, value: 1, metadata: 3},
      %Item{ weight: 1, value: 1, metadata: 4},
      %Item{ weight: 1, value: 1, metadata: 5},
      %Item{ weight: 1, value: 1, metadata: 6},
      %Item{ weight: 1, value: 1, metadata: 7},
      %Item{ weight: 1, value: 1, metadata: 8},
      %Item{ weight: 1, value: 1, metadata: 9},
    ]

    total_weight = 21

    packed_items = MapSet.new(Knapsack01.pack(items, total_weight))
    assert MapSet.size(packed_items) == 9
    # assert MapSet.member?(packed_items, high_value_mid)
  end
end
