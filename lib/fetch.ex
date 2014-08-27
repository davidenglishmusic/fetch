defmodule Fetch do

  def getFileBody(filename) do
    File.open filename
    body = File.read! filename
    File.close filename
    String.replace(body, "\n", "")
  end

  def getValue(fileBody, element) do
    valuePairs = Regex.scan(~r/<#{element}.*?>(.*?)<\/#{element}>/, fileBody)
    do_getValue(valuePairs, [])
  end

  defp do_getValue(valuePairs, acc) when length(valuePairs) == 0 do
    Enum.reverse(acc)
  end

  defp do_getValue(valuePairs, acc) do
    newValue = hd(valuePairs) |> tl()
    do_getValue(tl(valuePairs), newValue ++ acc)
  end

  def getAttribute(fileBody, attribute, element) do
    result = Regex.scan(~r/<#{element}(.*?)>/, fileBody)
    do_getAttribute(attribute, result)
  end

  defp do_getAttribute(attribute, result) do
    elementLine = hd(result) |> tl() |> List.to_string()
    Regex.scan(~r/#{attribute}="(.*?)"/, elementLine) |> hd() |> tl() |> List.to_string()
  end

end
