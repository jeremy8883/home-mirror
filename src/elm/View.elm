module View exposing (view)

import Html exposing (Html, div)

import Models exposing (Root)
import View.Clock exposing (clock)
import View.Weather exposing (weather)
import Messages exposing (Message)
import View.Calendar exposing (calendar)
import View.Settings exposing (settings)

view : Root -> Html Message
view model =
  div []
    [ clock model.clock
    , weather model.weather
    , calendar model
    , settings model
    ]
