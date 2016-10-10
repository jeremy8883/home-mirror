module Messages exposing (Message(..))

import Http
import Models exposing (WeatherDetailsModel)
import Time exposing (Time)

type Message
  = ClockTick Time
  | FetchWeather
  | FetchWeatherSucceed WeatherDetailsModel
  | FetchWeatherFail Http.Error
