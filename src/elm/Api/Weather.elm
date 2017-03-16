module Api.Weather exposing(fetchWeather)

import Http
import Messages exposing (Message(WeatherFetchFail, WeatherFetchSucceed))
import Models exposing (WeatherDetails, Weather)
import Task
import Json.Decode as Decode exposing (Decoder, (:=))

fetchWeather : String -> Float -> Float -> Cmd Message
fetchWeather apiKey longitude latitude =
  let
    url = "/api/weather/forecast/" ++ apiKey ++ "/" ++ toString(longitude) ++ "," ++ toString(latitude)
  in
    Task.perform WeatherFetchFail WeatherFetchSucceed (Http.get decodeWeather url)


decodeWeather : Decoder WeatherDetails
decodeWeather =
  Decode.object1 WeatherDetails
    (Decode.at [ "currently", "temperature" ] Decode.float)
