defmodule RedirectTo.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use RedirectTo.ConnCase

      use Hound.Helpers
      hound_session
    end
  end
end
