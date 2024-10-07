defmodule MockElectionWeb.ContactLive do
  use MockElectionWeb, :live_view
  
  def render(assigns) do
    ~H"""
    <h1>This is the contact page </h1>
    """
  end
end