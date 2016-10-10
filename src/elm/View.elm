module View exposing (view)

import Html exposing (Html, div)

import Models exposing (Model)
import View.Clock exposing (clock)
import View.Weather exposing (weather)
import Messages exposing (Message)

view : Model -> Html Message
view model =
  div [] [ clock model.clock, weather model.weather ]
