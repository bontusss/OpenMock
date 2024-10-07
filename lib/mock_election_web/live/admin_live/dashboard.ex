defmodule MockElectionWeb.AdminLive.Dashboard do
  use MockElectionWeb, :live_view
  alias MockElection.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, users: list_users(), roles: ["users", "admin", "moderator"])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Admin Dashboard")
  end

  @impl true
  def handle_event("update_role", %{"user-id" => user_id, "role" => new_role}, _socket) do
    user = Accounts.get_user!(user_id)
    {:ok, _updated_user} = Accounts.update_user_role(user, new_role)
  end

  defp list_users do
    Accounts.list_users()
  end


end
