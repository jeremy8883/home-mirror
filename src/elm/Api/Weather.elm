module Api.Weather exposing(fetchWeather)

import Http
import Messages exposing (Message(FetchWeatherFail, FetchWeatherSucceed))
import Models exposing (WeatherDetailsModel, WeatherModel)
import Task
import Json.Decode as Decode exposing (Decoder, (:=))

fetchWeather : String -> Float -> Float -> Cmd Message
fetchWeather apiKey longitude latitude =
  let
    url = "https://api.darksky.net/forecast/" ++ apiKey ++ "/" ++ toString(longitude) ++ "," ++ toString(latitude)
  in
    Task.perform FetchWeatherFail FetchWeatherSucceed (Http.get decodeWeather url)


decodeWeather : Decoder WeatherDetailsModel
decodeWeather =
  Decode.object1 WeatherDetailsModel
    (Decode.at [ "currently", "temperature" ] Decode.float)
