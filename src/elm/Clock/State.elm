module Clock.State exposing (subscriptions)

import Messages exposing (ClockMessage(ClockTick), Message)
import Models exposing (ClockModel, Model)
import Time exposing (Time, second)

-- SUBSCRIPTIONS

--TODO
--subscriptions : Model -> Sub Message
--subscriptions model =
--  Time.every second ClockTick

subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none
