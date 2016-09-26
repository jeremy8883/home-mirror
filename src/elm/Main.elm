import Html.App

import Clock.State exposing (init, update, subscriptions)
import View exposing (view)

main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
