module Utils.Temperature exposing (fahrenheitToCelsius, toDegreesString)

import String exposing (append)
import Utils.Math exposing (roundBy)
import Utils.String exposing (appendP)

fahrenheitToCelsius : Float -> Float
fahrenheitToCelsius f =
  (f - 32) * 5 / 9

toDegreesString : Float -> String
toDegreesString deg =
  deg
  |> roundBy 1
  |> toString
  |> appendP "°"
