defmodule Http2.Frame.Test do
  use ExUnit.Case
  alias Http2.Frame, as: Frame

  test "Header frame has common 9 byte header" do
    expected_bytes = << 0, 0x04, 0x01, 0x5, 0x0000000F >>
    assert Frame.default_header == expected_bytes
  end

end
