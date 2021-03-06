defmodule FetchTest do
  use ExUnit.Case

  test "gets the file body" do
    assert Fetch.getFileBody("xml/basic.xml") == "<basic>"
  end

  test "gets value of software" do
    assert Fetch.getValue("<software>MuseScore 1.3</software>", "software") == ["MuseScore 1.3"]
  end

  test "gets value of two notes" do
    assert Fetch.getValue("<note>A</note><note>B</note>", "note") == ["A", "B"]
  end

  test "gets value of three notes" do
    assert Fetch.getValue("<note>A</note><note>B</note><note>C</note>", "note") == ["A", "B", "C"]
  end

  test "gets attribute of bar" do
    assert Fetch.getAttribute("<score-part id=\"P1\">", "id", "score-part") == "P1"
  end

end
