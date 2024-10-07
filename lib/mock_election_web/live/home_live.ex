defmodule MockElectionWeb.HomeLive do
  use MockElectionWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="hero bg-base-200 min-h-screen font-poppins">
      <div class="hero-content text-center">
        <div class="w-3/4">
          <p class="text-sm font-bold">Empowering transparent elections & social polls.</p>
          <h1 class="text-6xl font-black">
            Simulate government elections securely, ensuring trust & transparency
            in African democracies.
          </h1>
          <p class="py-6 text-xl font-light">
            Build your elections, poll social issues, and gather vital data in real time
            to inform public decisions and strengthen the electoral process.
          </p>
          <a class="btn btn-info">Voter Education</a>
          <a class="btn btn-outline">See Elections</a>
        </div>
      </div>
    </div>
    """
  end
end
