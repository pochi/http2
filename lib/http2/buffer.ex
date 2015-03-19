defmodule HTTP2.Buffer do
  defstruct data: ""
  alias HTTP2.Buffer, as: Buffer

  def binary?(buffer) do
    buffer |> Buffer.binary |> is_binary
  end

  def binary(buffer) do
    buffer.data <> <<0>>
  end

  def size(buffer) do
    buffer |> Buffer.binary |> byte_size
  end

  def read(buffer, s) do
    << head :: size(s)-binary, _rest :: binary >> = buffer.data
    %Buffer{ data: head }
  end
end
