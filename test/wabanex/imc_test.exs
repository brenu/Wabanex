defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "Case when the file exists, should return user data" do
      params = %{"filename" => "students.csv"}

      response = Wabanex.IMC.calculate(params)

      expectedResponse = {:ok, %{"Dani" => 23.437499999999996, "Diego" => 23.04002019946976, "Gabul" => 22.857142857142858, "Rafael" => 24.897060231734173, "Rodrigo" => 26.234567901234566}}

      assert response == expectedResponse
    end
  end

  test "Case with wrong filename given, should return an error" do
    params = %{"filename" => "banana.csv"}

    response = Wabanex.IMC.calculate(params)

    expectedResponse = {:error, "Error while opening the file"}

    assert response == expectedResponse
  end
end
