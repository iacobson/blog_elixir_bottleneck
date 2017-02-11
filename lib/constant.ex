defmodule MagicNumber.Constant do
  @number 30

  def calculate(number \\ @number) do
    fibonacci(number)
  end

  def benchmark do
    Benchee.run(
      %{
        "calculate" => fn -> calculate() end
      }, time: 10
    )
  end

  defp fibonacci(0), do: 0
  defp fibonacci(1), do: 1
  defp fibonacci(n), do: fibonacci(n - 1) + fibonacci(n - 2)
end
