defmodule MagicNumber do
  import ExProf.Macro
  alias MagicNumber.Constant
  alias MagicNumber.Variable
  @list (1..1_000)

  def get_v1 do
    @list
    |> Enum.map(&(Variable.calculate(&1, Constant.calculate())))
    |> Enum.reduce(0, &(&1 + &2))
  end

  def get_v2 do
    constant = Constant.calculate()
    @list
    |> Enum.map(&(Variable.calculate(&1, constant)))
    |> Enum.reduce(0, &(&1 + &2))
  end

  def get_v3 do
    constant = Constant.calculate()
    @list
    |> Enum.map(&Task.async(Variable, :calculate, [&1, constant]))
    |> Enum.map(&Task.await(&1, :infinity))
    |> Enum.reduce(0, &(&1 + &2))
  end

  def get_v4 do
    constant = Constant.calculate()
    @list
    |> Task.async_stream(Variable, :calculate, [constant], timeout: :infinity, max_concurrency: 50)
    |> Stream.map(fn({:ok, result}) -> result end)
    |> Enum.to_list()
    |> Enum.reduce(0, &(&1 + &2))
  end

  def benchmark do
    Benchee.run(
      %{
        "get_v3" => fn -> get_v3() end,
        "get_v4" => fn -> get_v4() end,
      }, time: 10
    )
  end

  def profiler do
    profile do
      get_v3()
    end
  end

end
