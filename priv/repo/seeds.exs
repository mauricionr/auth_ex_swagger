# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AuthEx.Repo.insert!(%AuthEx.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias AuthEx.Auth
alias AuthEx.Assets

Auth.create_user(%{username: "mrco", password: "password"})

[1,2,3] |> Enum.map(fn(n) ->
    Assets.create_image(%{title: "Lorem Image Title", url: "http://lorempixel.com/400/200/sports/#{n}"})
end)
