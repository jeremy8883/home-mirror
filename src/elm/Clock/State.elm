module Clock.State exposing (init, update, subscriptions)

import Time exposing (Time, second)
import Clock.Types exposing(Model)
import Messages exposing (Clock(Tick))

init : (Model, Cmd Clock)
init =
  (0, Cmd.none)

-- UPDATE

update : Messages.Clock -> Model -> (Model, Cmd Clock)
update msg model =
  case msg of
    Tick newTime ->
      (newTime, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Clock
subscriptions model =
  Time.every second Tick
