import Html.App

import Clock.State exposing (subscriptions)
import Messages exposing (Message)
import Models exposing (Model)
import Update exposing (update)
import View exposing (view)

main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : (Model, Cmd Message)
init =
  ({ clock = 0 }, Cmd.none)
