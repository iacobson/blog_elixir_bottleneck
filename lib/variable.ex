defmodule MagicNumber.Variable do
  @interval (1..500_000)

  def calculate(var, constant) do
    Monitor.update(:input)
    result =
      @interval
      |> Enum.filter(&(rem(&1, var) == 0))
      |> constant_divisors(constant)
      |> average_restult()
    Monitor.update(:output)
    result
  end

  def benchmark(var, constant) do
    Benchee.run(
      %{
        "calculate" => fn -> calculate(var, constant) end
      }, time: 10
    )
  end

  defp constant_divisors([], _constant), do: []

  defp constant_divisors(list, constant) do
    list
    |> Enum.filter(&(rem(constant, &1) == 0))
  end

  defp average_restult([]), do: 0

  defp average_restult(list) do
    result = Enum.sum(list) / Enum.count(list)
    Float.round(result)
  end
end
