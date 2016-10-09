# Knapsack

Implementation of a solution to the 0/1 Knapsack problem. The Knapsack problem is a combinatorial optimization problem: given a set of items `I`, each represented by a weight (`w`) and a value (`v`), and a knapsack with a maximum capacity `W`, the algorithm finds the optimal subset of `I` that will maximize `sum(v)` while maintaining `sum(w) <= W`.

## Usage

```
require Knapsack.Knapsack01
alias Knapsack.Knapsack01

items = [
  %Knapsack01.Item{ weight: 10, value: 1, metadata: "any identifying data" },
  %Knapsack01.Item{ weight: 8, value: 2, metadata: "this one wins" },
]
capacity = 10
packed_items = Knapsack01.pack(items, capacity)

IO.inspect(packed_items)
[%Knapsack.Knapsack01.Item{metadata: "this one wins", value: 2, weight: 8}]

```
Note that this algorithm doesn't return the maximum value of the set, but it does return a list of items, you can get the max value like so:

```
Enum.reduce(packed_items, 0, fn(item, total) -> item.value + total end)
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `knapsack` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:knapsack, "~> 0.1.0"}]
    end
    ```

  2. Ensure `knapsack` is started before your application:

    ```elixir
    def application do
      [applications: [:knapsack]]
    end
    ```
