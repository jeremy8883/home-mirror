import Html.App

import Messages exposing (Message(ClockTick))
import Models exposing (ConfigModel, Model, FetchStatus(Fetching))
import Time exposing (second)
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
   , config = config
   , weather =
     { status = Fetching
     , details = Nothing
     }
   }, Cmd.none)

subscriptions : Model -> Sub Message
subscriptions model =
  Time.every second ClockTick
