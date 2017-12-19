defmodule TwitterSimulator.UserController do
    use TwitterSimulator.Web, :controller
  
    alias TwitterSimulator.User

    def index(conn, _params) do
      render conn, "index.html"
    end

    def register_user(conn, %{"username" => username, "password" => password}) do
      returnValue = :ets.insert_new(:user_table, {username, password});
      json conn, %{username: username, password: password, returnValue: returnValue}
    end

    def login_user(conn, %{"username" => username, "password" => password}) do
      returnValue = :ets.lookup(:user_table, username);
      if(returnValue == []) do
        json conn %{status: "ERROR", login_message: "Error: User Does Not Exist"}
    else
        [{username,returnedPassword}] = returnValue
        if(returnedPassword == password) do
            :ets.insert(:user_sockets, {username, socket})
            json conn %{status: "OK", login_message: "Login Successful" , username: username}

        else
            json conn %{status: "ERROR", login_message: "Incorrect Password"}
        end
    end
    end
  
    # def show(conn, %{"id" => id}) do
    #     #user = Repo.get!(User, id)
    #     html conn, "<html> <body> <h1> Hello, #{id} </h1> </body> </html>";
    # end

  end
  