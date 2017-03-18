defmodule Monitor do
  use GenServer

  # API

  def start_link() do
    GenServer.start_link(__MODULE__, [:input, :output], name: __MODULE__)
  end

  def update(action) do
    GenServer.cast(__MODULE__, {:update, action})
  end

  def stop do
    GenServer.stop(__MODULE__)
  end

  # CALLBACKS

  def init(actions) do
    time = get_time()
    {files, counter} = initialize(actions, {%{}, %{}})

    {:ok, {time, files, counter}}
  end

  def handle_cast({:update, action}, {time, files, counter}) do
    count = counter[action] + 1
    action_time = get_time() - time
    write_to_file(files[action], action_time, count)

    {:noreply, {time, files, %{counter | action => count}}}
  end

  # HELPERS

  defp initialize([], result) do
    result
  end

  defp initialize([action | actions], {files, counter}) do
    file = File.open!("monitor-#{action}.log", [:write])
    write_to_file(file, 0, 0)

    files = Map.put(files, action, file)
    counter = Map.put(counter, action, 0)

    initialize(actions, {files, counter})
  end

  defp get_time do
    :os.system_time(:millisecond)
  end

  defp write_to_file(file, time, count) do
    IO.write(file, "#{time}\t#{count}\n")
  end
end
