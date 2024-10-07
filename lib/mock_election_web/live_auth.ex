defmodule MockElectionWeb.LiveAuth do
  import Phoenix.Component
  alias MockElection.Accounts

  def on_mount(:default, _params, session, socket) do
    case fetch_current_user(session) do
      {:ok, user} ->
        {:cont, assign(socket, current_user: user)}

      _ ->
        {:cont, assign(socket, current_user: nil)}
    end
  end

  defp fetch_current_user(session) do
    with user_token when not is_nil(user_token) <- Map.get(session, "user_token"),
         user when not is_nil(user) <- Accounts.get_user_by_session_token(user_token) do
      {:ok, user}
    else
      _ -> :error
    end
  end
end
