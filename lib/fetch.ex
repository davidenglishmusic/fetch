defmodule Fetch do

  def fetch(filename) do
    getFileBody(filename) |> IO.puts()
  end

  def getFileBody(filename) do
    File.open filename
    {:ok, body} = File.read filename
    File.close filename
    body
  end

  def getValue(fileBody, element) do
    [[source, value]] = Regex.scan(~r/<#{element}>(.*?)<\/#{element}>/, fileBody)
    value
  end
  
end
