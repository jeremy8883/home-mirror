module Clock.View exposing (clock)

import Html.Attributes exposing (class)
import Date exposing (Date, fromTime)
import Html exposing (Html, div, text)
import String exposing (pad)

import Clock.Types exposing(Model)
import Messages exposing (Clock)

toTimeString : Date -> String
toTimeString date =
  let
    hours = date |> Date.hour |> toString
    minutes = date |> Date.minute |> toString |> pad 2 '0'
  in
    hours ++ ":" ++ minutes

clock : Model -> Html Clock
clock model =
  let
    date = fromTime model
  in
    div [ class "clock" ][
      text ( toTimeString date )
    ]
