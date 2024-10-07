# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MockElection.Repo.insert!(%MockElection.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias MockElection.Accounts

admin = Accounts.get_user_by_email("admin@app.com")

if is_nil(admin) do
  {:ok, admin} =
    Accounts.register_user(%{
      email: "admin@app.com",
      password: "secure_password__",
      role: "admin"
    })

  IO.puts("admin users create: #{admin.email}")
else
  IO.puts("admin user already exists")
end
