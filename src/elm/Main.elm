import Html.App

import Clock.Types exposing (..)
import Clock.State exposing (init, update, subscriptions)
import Root.View exposing (view)

main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
