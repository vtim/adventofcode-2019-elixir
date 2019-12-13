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
    assert capture_io(fn ->
             assert IntCode.execute_binary("4,0,99") == "4,0,99"
           end) == "4\n"
  end

  test "Support parameter modes in input" do
    assert IntCode.execute_binary("00002,1,0,3,99") == "2,1,0,2,99"
    assert IntCode.execute_binary("1002,4,3,4,33") == "1002,4,3,4,99"
  end

  test "Opcode 5 jumps to second parameter if first parameter is non-zero" do
    assert IntCode.execute_binary("5,3,1,99") == "5,3,1,99"
    assert IntCode.execute_binary("1005,99,1") == "1005,99,1"
  end

  test "Opcode 5 does nothing if first parameter is zero" do
    assert IntCode.execute_binary("5,3,1,99") == "5,3,1,99"
  end

  test "Opcode 6 jumps to second parameter if first parameter is zero" do
    assert IntCode.execute_binary("6,5,3,4,99,0") == "6,5,3,4,99,0"
    assert IntCode.execute_binary("1106,0,3,99") == "1106,0,3,99"
  end

  test "Opcode 6 does nothing if first parameter is non-zero" do
    assert IntCode.execute_binary("6,3,1,99") == "6,3,1,99"
  end

  test_with_mock "Jump test 0 using position mode", IO, [:passthrough], gets: fn _ -> "0" end do
    assert capture_io(fn ->
             IntCode.execute_binary("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
           end) == "0\n"
  end

  test_with_mock "Jump test 1 using position mode", IO, [:passthrough], gets: fn _ -> "54" end do
    assert capture_io(fn ->
             IntCode.execute_binary("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
           end) == "1\n"
  end

  test_with_mock "Jump test 0 using immediate mode", IO, [:passthrough], gets: fn _ -> "0" end do
    assert capture_io(fn ->
             IntCode.execute_binary("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
           end) == "0\n"
  end

  test_with_mock "Jump test 1 using immediate mode", IO, [:passthrough], gets: fn _ -> "54" end do
    assert capture_io(fn ->
             IntCode.execute_binary("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9")
           end) == "1\n"
  end

  test "Opcode 7 stores 1 in param3 if param1 is less than param2" do
    assert IntCode.execute_binary("1107,1,2,3,99") == "1107,1,2,1,99"
    assert IntCode.execute_binary("1107,23,86,3,99") == "1107,23,86,1,99"
  end

  test "Opcode 7 stores 0 in param3 if param1 is not less than param2" do
    assert IntCode.execute_binary("1107,2,1,3,99") == "1107,2,1,0,99"
    assert IntCode.execute_binary("1107,86,23,3,99") == "1107,86,23,0,99"
  end

  test "Opcode 8 stores 1 in param3 if param1 is equal to param2" do
    assert IntCode.execute_binary("1108,1,1,3,99") == "1108,1,1,1,99"
    assert IntCode.execute_binary("1108,23,23,3,99") == "1108,23,23,1,99"
  end

  test "Opcode 8 stores 0 in param3 if param1 is not equal to param2" do
    assert IntCode.execute_binary("1108,1,-1,3,99") == "1108,1,-1,0,99"
    assert IntCode.execute_binary("1108,23,86,3,99") == "1108,23,86,0,99"
  end
end
