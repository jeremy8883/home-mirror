import Html.App

import Clock.State exposing (subscriptions)
import Messages exposing (Message)
import Models exposing (ConfigModel, Model)
import Update exposing (update)
import View exposing (view)

main =
  Html.App.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : ConfigModel -> (Model, Cmd Message)
init config =
  ({ clock = 0
   , config = config }, Cmd.none)
