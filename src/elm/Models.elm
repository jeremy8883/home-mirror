module Models exposing (..)

import Time exposing (Time)

type alias Model =
  { config: ConfigModel
  , clock: ClockModel
  , weather: WeatherModel
  }

type alias ConfigModel =
  { weather: WeatherConfigModel
  }

type alias WeatherConfigModel =
  { darkSkyApiKey: String
  , longitude: Float
  , latitude: Float
  }

type alias ClockModel = Time

type FetchStatus
  = Fetching
  | Succeeded
  | Failed

type alias WeatherModel =
  { status: FetchStatus
  , details: Maybe WeatherDetailsModel
  }

type alias WeatherDetailsModel =
  { temperature: Float }
