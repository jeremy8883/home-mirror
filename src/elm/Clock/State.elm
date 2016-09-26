module Clock.State exposing (init, update, subscriptions)

import Models exposing (ClockModel)
import Time exposing (Time, second)
import Messages exposing (Clock(Tick))

init : (ClockModel, Cmd Clock)
init =
  (0, Cmd.none)

-- UPDATE

update : Messages.Clock -> ClockModel -> (ClockModel, Cmd Clock)
update msg model =
  case msg of
    Tick newTime ->
      (newTime, Cmd.none)


-- SUBSCRIPTIONS

subscriptions : ClockModel -> Sub Clock
subscriptions model =
  Time.every second Tick
