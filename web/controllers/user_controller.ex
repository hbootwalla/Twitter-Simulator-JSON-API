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
        json(conn, %{status: "ERROR", message: "User Does Not Exist"});
      else
          [{username,returnedPassword}] = returnValue
          if(returnedPassword == password) do
              json conn, %{status: "OK", message: "Login Successful" , username: username}
          else
              json conn, %{status: "ERROR", message: "Incorrect Password"}
          end
      end
    end

    def get_all_tweets(conn, %{"username" => username, "password" => password}) do
      validation = validate_user(conn, username, password)
      if validation == :ok do
        tweetList = DatabaseHandler.getAllTweetsByUser(username);
        json conn, %{status: "OK", tweetList: tweetList}
      end
    end

    def tweet(conn, %{"username" => username, "password" => password, "tweet" => tweetText}) do
      validation = validate_user(conn, username, password)
      if validation == :ok do
        handles = TweetParser.getAllHandles(tweetText);
        hashtags = TweetParser.getAllHashtags(tweetText);
        tweetId = :ets.info(:tweet_table)[:size];
        DatabaseHandler.insertTweet(tweetId, username, tweetText);

        Enum.map(handles, fn (handle) -> DatabaseHandler.insertHandleTweet(handle, tweetId) end);
        Enum.map(hashtags, fn (hashtag) -> DatabaseHandler.insertHashtagTweet(hashtag, tweetId) end);

        json conn, %{status: "OK", tweetId: tweetId, tweetText: tweetText, owner: username, hashtags: hashtags, handles: handles}
      end
    end

    def subscribe_to_user(conn, %{"username" => username, "password" => password, "subscribedUser" => subscribedUser}) do
      validation = validate_user(conn, username, password)
      if validation == :ok do
        DatabaseHandler.addUserToFollowingList(username, subscribedUser);
        DatabaseHandler.addUserToFollowersList(subscribedUser, username);
        json conn, %{status: "OK", username: username, subscribedUser: subscribedUser}
      end
    end

    def get_tweets_by_hashtag(conn, %{"username" => username, "password" => password, "hashtag" => hashtag}) do
      validation = validate_user(conn, username, password)
      if validation == :ok do
        tweets = DatabaseHandler.getAllTweetsByHashtag(hashtag);
        json conn, %{status: "OK", username: username, hashtag: hashtag, tweets: tweets}
      end
    end

    def get_tweets_by_handle(conn, %{"username" => username, "password" => password, "handle" => handle}) do
      validation = validate_user(conn, username, password)
      if validation == :ok do
        tweets = DatabaseHandler.getAllTweetsByHandle(handle);
        json conn, %{status: "OK", username: username, handle: handle, tweets: tweets}
      end
    end

    def get_all_subscribers_tweets(conn, %{"username" => username, "password" => password}) do
      validation = validate_user(conn, username, password)
      if validation == :ok do
        tweets = DatabaseHandler.getSubscribedUsersTweets(username);
        json conn, %{status: "OK", username: username, tweets: tweets}
      end
    end

    def get_all_following(conn, %{"username" => username, "password" => password}) do
      validation = validate_user(conn, username, password)
      if validation == :ok do
        followingList = DatabaseHandler.getAllFollowing(username)
        json conn, %{status: "OK", username: username, followingList: followingList}
      end
    end

    def get_all_followers(conn, %{"username" => username, "password" => password}) do
      validation = validate_user(conn, username, password)
      if validation == :ok do
        followersList = DatabaseHandler.getAllFollowers(username)
        json conn, %{status: "OK", username: username, followersList: followersList}
      end
    end
  
    def validate_user(conn, username, password) do
      returnValue = :ets.lookup(:user_table, username);
      if returnValue == [] do
        json conn, %{status: "ERROR", message: "User Does Not Exist"}
        :error
      else
        [{username,returnedPassword}] = returnValue
        if(returnedPassword == password) do
          :ok
        else
          json conn, %{status: "ERROR", message: "Incorrect Password"}
          :error
        end
      end
    end

    # def show(conn, %{"id" => id}) do
    #     #user = Repo.get!(User, id)
    #     html conn, "<html> <body> <h1> Hello, #{id} </h1> </body> </html>";
    # end

  end
  