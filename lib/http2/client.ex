defmodule Http2.Client do

  alias __MODULE__, as: Client
  alias Http2.Connection, as: Connection

  defstruct stream_id: 1,
            state: :waiting_connection_preface,
            local_role: :local,
            remote_role: :server,
            streams: %{}

  @default_tcp_options [:binary, packet: :raw, active: true]
  defp default_tcp_options, do: @default_tcp_options

  @spec get(client :: Http2.Client, url :: String) :: tuple
  def get(client, url) do
    uri = URI.parse(url)
    # :gen_tcpには文字列ではなくてchar_listで渡さないといけない
    host = uri.host |> String.to_char_list
    case client.state do
      :waiting_connection_preface ->
        {:ok, sock} = :gen_tcp.connect(host, uri.port, default_tcp_options, :infinity)
        sock |> :gen_tcp.send Connection.connection_preface_magic
        sock |> exchange_setting_frame
        #sock |> :inet.setopts(active: false, packet: :http_bin)
        #response = sock |> :gen_tcp.recv(0)
        #IO.inspect response
    end

    {:ok, sock}
  end

  defp exchange_setting_frame(sock) do
    receive do
      {:tcp, sock, binary} ->
        IO.puts "Come frame"
        IO.inspect binary
    end
  end

  def get(url) do
    get(%Client{}, url)
  end
end
