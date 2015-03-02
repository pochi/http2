defmodule HTTP2.Frame.Test do
  use ExUnit.Case
  alias HTTP2.Frame, as: Frame

  test "Header frame has common header" do
    expected_bytes = [0, 0x04, 0x01, 0x5, 0x0000000F]
    assert (%Frame{} |> Frame.header) == expected_bytes
  end
end
