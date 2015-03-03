defmodule HTTP2.Frame do
  defstruct header: << 0, 0x04, 0x01, 0x5, 0x0000000F >>

  def header(frame) do
    frame.header
  end
end
