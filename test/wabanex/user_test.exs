defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "Case when the params are valid, should return a valid changeset" do
      params = %{name: "Rafael", email: "rafael@banana.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
                valid?: true,
                changes: %{email: "rafael@banana.com", name: "Rafael", password: "123456"},
                errors: []
              } = response
    end

    test "Case when the params are invalid, should return an invalid changeset" do
      params = %{name: "R", email: "rafael@banana.com"}

      response = User.changeset(params)

      expected_error = %{name: ["should be at least 2 character(s)"], password: ["can't be blank"]}

      assert errors_on(response) == expected_error
    end
  end
end
