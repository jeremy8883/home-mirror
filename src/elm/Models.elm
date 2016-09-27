module Models exposing (..)

import Time exposing (Time)

type alias Model =
  { config: ConfigModel
  , clock: ClockModel
  }

type alias ConfigModel =
  { weather:
    { darkSkyApiKey: String
    , longitude: Float
    , latitude: Float
    }
  }

type alias ClockModel = Time
