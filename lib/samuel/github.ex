defmodule Samuel.Github do
  @moduledoc """
  Github interactions.
  """

  def post_comment(_) do
    access_token = Application.get_env :samuel, :github_access_key
    client = Tentacat.Client.new(%{access_token: access_token}, "https://api.github.com/api/v3/")
  end

end
