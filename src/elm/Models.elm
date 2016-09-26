module Models exposing (..)

import Time exposing (Time)

type alias Model =
  { clock: ClockModel
  }

type alias ClockModel = Time
