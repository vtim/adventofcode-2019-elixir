defmodule IntCodeTest do
  use ExUnit.Case

  import Mock
  import ExUnit.CaptureIO

  doctest IntCode

  test "Simplest add operation" do
    assert IntCode.execute_binary("1,1,1,3,99") == "1,1,1,2,99"
  end

  test "Two add operations" do
    assert IntCode.execute_binary("1,1,1,3,1,1,8,7,99") == "1,1,1,2,1,1,8,100,99"
  end

  test "Simplest multiply operation" do
    assert IntCode.execute_binary("2,1,1,3,99") == "2,1,1,1,99"
  end

  test "Basic programs" do
    assert IntCode.execute_binary("1,9,10,3,2,3,11,0,99,30,40,50") ==
             "3500,9,10,70,2,3,11,0,99,30,40,50"

    assert IntCode.execute_binary("1,0,0,0,99") == "2,0,0,0,99"
    assert IntCode.execute_binary("2,3,0,3,99") == "2,3,0,6,99"
    assert IntCode.execute_binary("2,4,4,5,99,0") == "2,4,4,5,99,9801"
    assert IntCode.execute_binary("1,1,1,4,99,5,6,0,99") == "30,1,1,4,2,5,6,0,99"
  end

  test_with_mock "Opcode 3 takes input", IO, gets: fn _ -> "5" end do
    assert IntCode.execute_binary("3,0,99") == "5,0,99"
    assert IntCode.execute_binary("3,1,99") == "3,5,99"
  end

  test "Opcode 4 outputs a value" do
    execute = fn ->
      assert IntCode.execute_binary("4,0,99") == "4,0,99"
    end

    assert capture_io(execute) == "4\n"
  end
end
