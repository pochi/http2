defmodule Http2.Client do

  alias __MODULE__, as: Client
  alias Http2.Connection, as: Connection
  alias Http2.Frame, as: Frame

  defstruct stream_id: 1,
            state: :waiting_connection_preface,
            local_role: :local,
            remote_role: :server,
            streams: %{}


  @spec get(client :: Http2.Client, url :: String) :: tuple
  def get(client, url) do
    case client.state do
      :waiting_connection_preface ->
        client |> Connection.establish_connection(url)
        client = %{client | state: :connected}
    end

    [client, stream] = client |> new_stream
    IO.puts "kuroda"
    IO.inspect client
    IO.puts "pochi"
    {:ok, client}
  end

  @spec new_stream(client :: Http2.Client) :: List
  def new_stream(client) do
    stream = "hoge"#client |> Stream.new
    client = %{client | stream_id: client.stream_id + 2}
    IO.puts client.stream_id
    #client.stream_id = client.stream_id + 2
    [client, stream]
  end

  @spec get(url :: String) :: tuple
  def get(url) do
    get(%Client{}, url)
  end
end
