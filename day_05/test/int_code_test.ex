defmodule IntCodeTest do
  use ExUnit.Case
  doctest IntCode

  test "Simplest add operation" do
    assert IntCode.process("1,1,1,3,99") == "1,1,1,2,99"
  end

  test "Two add operations" do
    assert IntCode.process("1,1,1,3,1,1,8,7,99") == "1,1,1,2,1,1,8,100,99"
  end

  test "Simplest multiply operation" do
    assert IntCode.process("2,1,1,3,99") == "2,1,1,1,99"
  end

  test "Basic programs" do
    assert IntCode.process("1,9,10,3,2,3,11,0,99,30,40,50") == "3500,9,10,70,2,3,11,0,99,30,40,50"
    assert IntCode.process("1,0,0,0,99") == "2,0,0,0,99"
    assert IntCode.process("2,3,0,3,99") == "2,3,0,6,99"
    assert IntCode.process("2,4,4,5,99,0") == "2,4,4,5,99,9801"
    assert IntCode.process("1,1,1,4,99,5,6,0,99") == "30,1,1,4,2,5,6,0,99"
  end

end
