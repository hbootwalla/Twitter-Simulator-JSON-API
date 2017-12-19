{application,twitter_simulator,
             [{applications,[kernel,stdlib,elixir,logger,gettext,
                             phoenix_pubsub,cowboy,phoenix_html,phoenix,
                             phoenix_live_reload,postgrex,phoenix_ecto]},
              {description,"twitter_simulator"},
              {modules,['Elixir.DatabaseHandler','Elixir.TweetParser',
                        'Elixir.TwitterSimulator',
                        'Elixir.TwitterSimulator.Endpoint',
                        'Elixir.TwitterSimulator.ErrorHelpers',
                        'Elixir.TwitterSimulator.ErrorView',
                        'Elixir.TwitterSimulator.Gettext',
                        'Elixir.TwitterSimulator.LayoutView',
                        'Elixir.TwitterSimulator.PageController',
                        'Elixir.TwitterSimulator.PageView',
                        'Elixir.TwitterSimulator.Repo',
                        'Elixir.TwitterSimulator.Router',
                        'Elixir.TwitterSimulator.Router.Helpers',
                        'Elixir.TwitterSimulator.TwitterChannel',
                        'Elixir.TwitterSimulator.UserController',
                        'Elixir.TwitterSimulator.UserSocket',
                        'Elixir.TwitterSimulator.UserView',
                        'Elixir.TwitterSimulator.Web']},
              {registered,[]},
              {vsn,"0.0.1"},
              {mod,{'Elixir.TwitterSimulator',[]}},
              {extra_applications,[logger]}]}.