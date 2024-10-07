defmodule MockElectionWeb.AboutLive do 
  use MockElectionWeb, :live_view
  
  def render(assigns) do 
    ~H"""
    <div>This is the about page</div>
    """
  end
end