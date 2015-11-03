defmodule RedirectTo.TokenGeneratorTest do
  use ExUnit.Case

  alias RedirectTo.TokenGenerator

  test "generates with letters and numbers" do
    assert TokenGenerator.generate(1) == "A"
    assert TokenGenerator.generate(27) == "a"
    assert TokenGenerator.generate(53) == "0"
    assert TokenGenerator.generate(62) == "9"
    assert TokenGenerator.generate(62+1) == "AA"
    assert TokenGenerator.generate(62+62) == "A9"
    assert TokenGenerator.generate(62*62+62) == "99"
    assert TokenGenerator.generate(62*62*62+62*62+62) == "999"
    assert TokenGenerator.generate(62*62*62+62*62+62+1) == "AAAA"
  end
end
