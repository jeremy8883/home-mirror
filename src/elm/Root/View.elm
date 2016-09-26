module Root.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)

import Clock.State exposing (Msg)
import Clock.Types exposing (Model)
import Clock.View exposing (clock)

view : Model -> Html Msg
view model =
  div [] [ clock model ]
