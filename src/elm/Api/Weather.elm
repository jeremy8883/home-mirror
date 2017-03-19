module Api.Weather exposing(fetchWeather)

import Http
import Messages exposing (Message(WeatherFetch, WeatherFetch))
import Models exposing (WeatherDetails, Weather)
import Json.Decode as Decode exposing (Decoder)

fetchWeather : String -> Float -> Float -> Cmd Message
fetchWeather apiKey longitude latitude =
  let
    url = "/api/weather/forecast/" ++ apiKey ++ "/" ++ toString(longitude) ++ "," ++ toString(latitude)
    request = Http.get url decodeWeather
  in
    Http.send WeatherFetch request


decodeWeather : Decoder WeatherDetails
decodeWeather =
  Decode.map WeatherDetails
    (Decode.at [ "currently", "temperature" ] Decode.float)
