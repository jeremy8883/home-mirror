module Update exposing (update)

import Api.Calendar exposing (fetchCalendar)
import Api.Oauth exposing (fetchUserInfo, logout)
import Api.Weather exposing (fetchWeather)
import Date exposing (fromTime)
import Messages exposing (Message(CalendarFetch, CalendarRequired, ClockTick, NoOp, OauthLogoutPost, OauthLogoutRequired, OauthUserInfoFetch, OauthUserInfoRequired, WeatherFetch, WeatherRequired))
import Models exposing (FetchStatus(Failed, Fetching, Succeeded), Root)
import Utils.LocalStorage as LocalStorage

update : Message -> Root -> (Root, Cmd Message)
update message model =
  let
    weatherConfig = model.config.weather
  in
    case message of
      ClockTick newTime ->
       ({ model | clock = newTime }, Cmd.none)
      WeatherRequired _ ->
        ( { model | weather = { status = Fetching, details = model.weather.details } }
        , fetchWeather weatherConfig.darkSkyApiKey weatherConfig.longitude weatherConfig.latitude
        )
      WeatherFetch (Ok newWeatherDetails) ->
        ( { model | weather = { status = Succeeded, details = Just newWeatherDetails } }
        , Cmd.none
        )
      WeatherFetch (Err _) ->
        ( { model | weather = { status = Failed, details = Nothing } }
        , Cmd.none
        )
      OauthUserInfoRequired ->
        ( { model | user = { status = Fetching, details = model.user.details } }
        , case model.oauth of
            Nothing -> Cmd.none
            Just oauth -> fetchUserInfo oauth.accessToken
        )
      OauthUserInfoFetch (Ok newUserDetails) ->
        ( { model | user = { status = Succeeded, details = Just newUserDetails } }
        , Cmd.none
        )
      OauthUserInfoFetch (Err _) ->
        ( { model | user = { status = Failed, details = Nothing } }
        , Cmd.none
        )
      OauthLogoutRequired ->
        let
          meh = LocalStorage.remove "auth"
        in
          ( { model | oauth = Nothing, user = { status = Succeeded, details = Nothing } }
          , case model.oauth of
              Nothing -> Cmd.none
              Just oauth -> logout oauth.accessToken
          )
      OauthLogoutPost (Ok _) ->
        ( model, Cmd.none )
      OauthLogoutPost (Err _) ->
        ( model, Cmd.none )
      CalendarRequired startFrom ->
        ( { model | calendar = { status = Fetching, details = model.calendar.details } }
        , case model.oauth of
          Nothing -> Cmd.none
          Just oauth ->
            fetchCalendar model.config.oauth.clientId oauth.accessToken model.config.calendar.name (fromTime startFrom)
        )
      CalendarFetch (Ok newCalendarDetails) ->
        ( { model | calendar = { status = Succeeded, details = Just newCalendarDetails } }
        , Cmd.none
        )
      CalendarFetch (Err _) ->
        ( { model | calendar = { status = Failed, details = Nothing } }
        , Cmd.none
        )
      NoOp ->
        (model, Cmd.none)