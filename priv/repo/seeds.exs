# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BlogsPortfolio.Repo.insert!(%BlogsPortfolio.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BlogsPortfolio.Backoffice.Admin
alias BlogsPortfolio.Repo

# Create admin user
admin_attrs = %{
  email: "admin@example.com",
  password: "admin123456789",
  confirmed_at: DateTime.utc_now() |> DateTime.truncate(:second)
}

%Admin{}
|> Admin.registration_changeset(admin_attrs)
|> Repo.insert!()
