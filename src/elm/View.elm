module View exposing (view)

import Html exposing (Html, div)

import Models exposing (ClockModel)
import View.Clock exposing (clock)
import Messages exposing (Clock)

view : ClockModel -> Html Clock
view model =
  div [] [ clock model ]
