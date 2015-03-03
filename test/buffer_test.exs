defmodule HTTP2.Buffer.Test do
  use ExUnit.Case
  alias HTTP2.Buffer, as: Buffer

  test 'it should be binary' do
    assert %Buffer{ data: "hoge" } |> Buffer.binary? == true
  end

  test 'it should return bytesize of the buffer' do
    assert %Buffer{ data: "hoge" } |> Buffer.size == 5
  end

  test 'it should read single byte at a time' do
    buffer = %Buffer{ data: "hoge" }
    Enum.map(1..5, fn _ ->
      buffer = buffer |> Buffer.read(1)
      assert buffer.data != nil
    end)
  end

end
