module Utils.Temperature exposing (fahrenheitToCelsius, toDegreesString)

import Utils.Number exposing (toFixed)
import Utils.String exposing (appendP)

fahrenheitToCelsius : Float -> Float
fahrenheitToCelsius f =
  (f - 32) * 5 / 9

toDegreesString : Float -> String
toDegreesString deg =
  deg
  |> toFixed 1
  |> appendP "°"
