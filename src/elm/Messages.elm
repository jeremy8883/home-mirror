module Messages exposing (Message(..))

import Http
import Models exposing (WeatherDetailsModel)
import Time exposing (Time)

type Message
  = ClockTick Time
  | WeatherFetch Time
  | WeatherFetchSucceed WeatherDetailsModel
  | WeatherFetchFail Http.Error
