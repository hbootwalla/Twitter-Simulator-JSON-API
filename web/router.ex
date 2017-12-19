defmodule TwitterSimulator.Router do
  use TwitterSimulator.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TwitterSimulator do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/user/login_user", UserController, :login_user
    get "/user/register_user", UserController, :register_user
    get "/user/get_all_tweets", UserController, :get_all_tweets
    get "/user/tweet", UserController, :tweet
    get "/user/subscribe_to_user", UserController, :subscribe_to_user
    get "/user/get_tweets_by_hashtag", UserController, :get_tweets_by_hashtag
    get "/user/get_tweets_by_handle", UserController, :get_tweets_by_handle
    get "/user/get_all_subscribers_tweets", UserController, :get_all_subscribers_tweets
    get "/user/get_all_following", UserController, :get_all_following
    get "/user/get_all_followers", UserController, :get_all_followers
  end


  # Other scopes may use custom stacks.
  # scope "/api", TwitterSimulator do
  #   pipe_through :api
  # end
end
