# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cards.Repo.insert!(%Cards.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Cards.Accounts.create_user(%{"name" => "Admin", "username" => "admin", "password" => "admin", "is_admin" => true})
Cards.Players.create_player(%{"user_id" => 1})