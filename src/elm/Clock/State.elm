module Clock.State exposing (init, update, subscriptions, Msg)

import Time exposing (Time, second)
import Clock.Types exposing(Model)

init : (Model, Cmd Msg)
init =
  (0, Cmd.none)

-- UPDATE

type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      (newTime, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every second Tick
