defmodule Http2.Frame do
  defstruct length: 0x0, type: 0x0, flag: 0x0, stream_identifier: 0x0, payload: 0x0
  alias __MODULE__, as: Frame

  def header(frame) do
    frame.header
  end

  @default_header << 0, 0x04, 0x01, 0x5, 0x0000000F >>
  def default_header, do: @default_header

  @spec parse(response :: Binary) :: Frame
  def parse(response) do
    # 0 means 'r'
    <<frame_length::24,
      frame_type::8,
      frame_flag::8,
      0::1,
      frame_stream_identifier::31,
      frame_payload::binary >> = response

    %Frame{length: frame_length,
           type: frame_type,
           flag: frame_flag,
           stream_identifier: frame_stream_identifier,
           payload: frame_payload}
  end

  @spec to_binary(frame :: Frame) :: Binary
  def to_binary(frame) do
    <<frame.length::24,
      frame.type::8,
      frame.flag::8,
      0::1,
      frame.stream_identifier::31,
      frame.payload::binary>>
  end
end
