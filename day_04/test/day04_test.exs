defmodule Day04Test do
  use ExUnit.Case
  doctest Day04
end


defmodule PasswordTest do
  use ExUnit.Case
  doctest Password

  test "Password must be 6 digits" do
    assert Password.validate("12345x") == false
    assert Password.validate(34445) == false
    assert Password.validate(344446)
    assert Password.validate(3234567) == false
  end

  test "Password must be in given range" do
    # 264360..746325
    assert Password.validate(123456) == false
    assert Password.validate(266660) == false
    assert Password.validate(266667)
    assert Password.validate(555555)
    assert Password.validate(666777)
    assert Password.validate(77888) == false
    assert Password.validate(888888) == false
  end

  test "Two adjacent digits must be the same" do
    assert Password.validate(555555)
    assert Password.validate(345677)
    assert Password.validate(345678) == false
  end

  test "Going from left to right, the digits never decrease" do
    assert Password.validate(555555)
    assert Password.validate(554555) == false
    assert Password.validate(556789)
    assert Password.validate(556798) == false
  end

  test "the two adjacent matching digits are not part of a larger group of matching digits" do
    assert Password.validate_part2(123444) == false
    assert Password.validate_part2(123456) == false
    assert Password.validate_part2(111122)
    assert Password.validate_part2(112112)
    assert Password.validate_part2(112222)
  end
end
