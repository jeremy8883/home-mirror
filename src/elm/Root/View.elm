module Root.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Models exposing (ClockModel)
import Clock.View exposing (clock)
import Messages exposing (Clock)

view : ClockModel -> Html Clock
view model =
  div [] [ clock model ]
