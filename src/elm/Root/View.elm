module Root.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Clock.Types exposing (Model)
import Clock.View exposing (clock)
import Messages exposing (Clock)

view : Model -> Html Clock
view model =
  div [] [ clock model ]
