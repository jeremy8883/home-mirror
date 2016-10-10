module Update exposing (update)

import Api.Weather exposing (fetchWeather)
import Messages exposing (Message(ClockTick, FetchWeather, FetchWeatherFail, FetchWeatherSucceed))
import Models exposing (FetchStatus(Failed, Fetching, Succeeded), Model)

update : Message -> Model -> (Model, Cmd Message)
update message model =
  case message of
    ClockTick newTime ->
     ({ model | clock = newTime }, Cmd.none)
    FetchWeather ->
      ( { model | weather = { status = Fetching, details = Nothing } }
      , fetchWeather model.config.weather.darkSkyApiKey model.config.weather.longitude model.config.weather.latitude
      )
    FetchWeatherSucceed newWeatherDetails ->
      ( { model | weather = { status = Succeeded, details = Just newWeatherDetails } }
      , Cmd.none
      )
    FetchWeatherFail _ ->
      ( { model | weather = { status = Failed, details = Nothing } }
      , Cmd.none
      )
