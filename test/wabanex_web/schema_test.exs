defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "Users' queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "breno@mail.com", name: "brenu", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
      {
        getUser(id: "#{user_id}") {
          name,
          email
        }
      }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)


      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "breno@mail.com",
            "name" => "brenu"
          }
        }
      }

      assert expected_response == response
    end
  end

  describe "users mutations" do
    test "Case when all params are valid, should create the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(
            input: {
                    name:"teste",
                    email: "teste@gmail.com",
                    password: "123456"
            })
          {
            id,
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)



      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "teste"}}} = response
    end
  end
end
