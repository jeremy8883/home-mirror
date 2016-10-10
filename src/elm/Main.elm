import Api.Weather exposing (fetchWeather)
import Html.App

import Messages exposing (Message(ClockTick, WeatherFetch))
import Models exposing (ConfigModel, Model, FetchStatus(Fetching))
import Time exposing (hour, second)
import Update exposing (update)
import View exposing (view)

main =
  Html.App.programWithFlags
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : ConfigModel -> (Model, Cmd Message)
init config =
  ({ clock = 0
   , config = config
   , weather =
     { status = Fetching
     , details = Nothing
     }
   }, fetchWeather config.weather.darkSkyApiKey config.weather.longitude config.weather.latitude )

subscriptions : Model -> Sub Message
subscriptions model =
  let
    sixHours = hour * 6
  in
    Sub.batch
      [ Time.every second ClockTick
      , Time.every sixHours WeatherFetch
      ]
