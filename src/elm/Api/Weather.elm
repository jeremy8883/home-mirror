module Api.Weather exposing(fetchWeather)

import Http
import Messages exposing (Message(WeatherFetchFail, WeatherFetchSucceed))
import Models exposing (WeatherDetailsModel, WeatherModel)
import Task
import Json.Decode as Decode exposing (Decoder, (:=))

fetchWeather : String -> Float -> Float -> Cmd Message
fetchWeather apiKey longitude latitude =
  let
    url = "/api/weather/forecast/" ++ apiKey ++ "/" ++ toString(longitude) ++ "," ++ toString(latitude)
  in
    Task.perform WeatherFetchFail WeatherFetchSucceed (Http.get decodeWeather url)


decodeWeather : Decoder WeatherDetailsModel
decodeWeather =
  Decode.object1 WeatherDetailsModel
    (Decode.at [ "currently", "temperature" ] Decode.float)
