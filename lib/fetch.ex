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
    [[source, value]] = results
    value
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

  def getListLength(list) do
    do_getListLength(list, 0)
  end

  defp do_getListLength(list, acc) when list == [] do
    acc
  end

  defp do_getListLength(list, acc) do
    newList = tl(list)
    do_getListLength(newList, acc + 1)
  end

end
