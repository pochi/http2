defmodule Http2.Connection do

  alias Http2.Frame, as: Frame

  @remote_default_connection_settings %{
    settings_header_table_size: 4096,
    settings_enable_push: 1,
    settings_max_concurrent_streams: 0x7fffffff,
    settings_initial_window_size: 65536,
    settings_max_frame_size: 16384,
    settings_max_header_list_size: :math.pow(2, 31) - 1
  }
  def remote_default_connection_settings, do: @remote_default_connection_settings

  @default_connection_settings %{
    settings_header_table_size:       4096,
    settings_enable_push:             1,
    settings_max_concurrent_streams:  100,
    settings_initial_window_size:     65535,
    settings_max_frame_size:          16384,
    settings_max_header_list_size:    :math.pow(2, 31) - 1
  }
  def default_connection_settings, do: @default_connection_settings

  @default_weight 16
  def default_weight, do: @default_weight

  @connection_preface_magic "PRI * HTTP/2.0\r\n\r\nSM\r\n\r\n"
  def connection_preface_magic, do: @connection_preface_magic

  @default_tcp_options [:binary, packet: :raw, active: true]
  defp default_tcp_options, do: @default_tcp_options

  def establish_connection(client, url) do
    uri = URI.parse(url)
    # :gen_tcp need char_list, not string
    host = uri.host |> String.to_char_list
    {:ok, sock} = :gen_tcp.connect(host, uri.port, default_tcp_options, :infinity)
    sock |> :gen_tcp.send connection_preface_magic
    pending_frame = sock |> exchange_setting_frame
    local_settings = sock |> connection_setting(pending_frame)
  end


  defp exchange_setting_frame(sock) do
    receive do
      {:tcp, sock, response} ->
        response |> debug
        frame = Frame.parse response
        case frame |> Frame.type do
          :settings ->
            sock |> :gen_tcp.send Frame.to_binary(frame)
          _ ->
            IO.puts "Received frame is not setting"
        end
    end
    frame
  end

  defp connection_setting(sock, pending_frame) do
    receive do
      {:tcp, sock, response} ->
        response |> debug
        frame = Frame.parse response
        case frame |> Frame.type do
          :settings ->
            if frame |> Frame.ack? do
              IO.inspect pending_frame
              IO.puts "This is ack frame"
            end
          _ ->
            IO.puts "Received frame is not setting"
        end
    end
    pending_frame
  end

  defp debug(something) do
    IO.puts "----------"
    IO.inspect something
    IO.puts "========="
  end
end
