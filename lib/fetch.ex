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
    results = Regex.scan(~r/<#{element}>(.*?)<\/#{element}>/, fileBody)
    do_getValue(results)
  end

  defp do_getValue(results) when length(results) >= 2 do
    getValues(results, [])
  end

  defp do_getValue(results) do
    List.flatten(results) |> tl()
  end

  defp getValues(results, acc) when results == [] do
    Enum.reverse(acc)
  end

  defp getValues(results, acc) do
    value = Enum.at(results, 0) |> tl()
    newAcc = value ++ acc
    getValues(tl(results), newAcc)
  end

  def getAttribute(fileBody, attribute, element) do
    result = Regex.scan(~r/<#{element}(.*?)>/, fileBody)
    do_getAttribute(attribute, result)
  end

  defp do_getAttribute(attribute, result) do
    [[source, elementLine]] = result
    [[source, attribute]] = Regex.scan(~r/#{attribute}="(.*?)"/, elementLine)
    attribute
  end

end
