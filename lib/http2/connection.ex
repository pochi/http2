defmodule Http2.Connection do

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
end
