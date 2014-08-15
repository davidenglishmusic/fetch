defmodule FetchTest do
  use ExUnit.Case

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "gets the file body" do
    assert Fetch.getFileBody("xml/basic.xml") == "<basic>\n"
  end

  test "gets value of software" do
    assert Fetch.getValue("<software>MuseScore 1.3</software>", "software") == "MuseScore 1.3"
  end

  test "gets attribute of bar" do
    assert Fetch.getAttribute("<score-part id=\"P1\">", "id", "score-part") == "P1"
  end

end
