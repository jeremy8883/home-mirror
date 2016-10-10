module Update exposing (update)

import Api.Weather exposing (fetchWeather)
import Messages exposing (Message(ClockTick, WeatherFetch, WeatherFetchFail, WeatherFetchSucceed))
import Models exposing (FetchStatus(Failed, Fetching, Succeeded), Model)

update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    ClockTick newTime ->
     ({ model | clock = newTime }, Cmd.none)
    WeatherFetch ->
      ( { model | weather = { status = Fetching, details = Nothing } }
      , fetchWeather model.config.weather.darkSkyApiKey model.config.weather.longitude model.config.weather.latitude
      )
    WeatherFetchSucceed newWeatherDetails ->
      ( { model | weather = { status = Succeeded, details = Just newWeatherDetails } }
      , Cmd.none
      )
    WeatherFetchFail _ ->
      ( { model | weather = { status = Failed, details = Nothing } }
      , Cmd.none
      )
