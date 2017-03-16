module Update exposing (update)

import Api.Calendar exposing (fetchCalendar)
import Api.Oauth exposing (fetchUserInfo, logout)
import Api.Weather exposing (fetchWeather)
import Date exposing (fromTime)
import Messages exposing (Message(CalendarFetch, CalendarFetchFail, CalendarFetchSucceed, ClockTick, NoOp, OauthFetchUserInfo, OauthFetchUserInfoFail, OauthFetchUserInfoSucceed, OauthLogout, OauthLogoutFail, OauthLogoutSucceed, WeatherFetch, WeatherFetchFail, WeatherFetchSucceed))
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
      WeatherFetch _ ->
        ( { model | weather = { status = Fetching, details = model.weather.details } }
        , fetchWeather weatherConfig.darkSkyApiKey weatherConfig.longitude weatherConfig.latitude
        )
      WeatherFetchSucceed newWeatherDetails ->
        ( { model | weather = { status = Succeeded, details = Just newWeatherDetails } }
        , Cmd.none
        )
      WeatherFetchFail _ ->
        ( { model | weather = { status = Failed, details = Nothing } }
        , Cmd.none
        )
      OauthFetchUserInfo ->
        ( { model | user = { status = Fetching, details = model.user.details } }
        , case model.oauth of
            Nothing -> Cmd.none
            Just oauth -> fetchUserInfo oauth.accessToken
        )
      OauthFetchUserInfoSucceed newUserDetails ->
        ( { model | user = { status = Succeeded, details = Just newUserDetails } }
        , Cmd.none
        )
      OauthFetchUserInfoFail _ ->
        ( { model | user = { status = Failed, details = Nothing } }
        , Cmd.none
        )
      OauthLogout ->
        let
          meh = LocalStorage.remove "auth"
        in
          ( { model | oauth = Nothing, user = { status = Succeeded, details = Nothing } }
          , case model.oauth of
              Nothing -> Cmd.none
              Just oauth -> logout oauth.accessToken
          )
      OauthLogoutSucceed _ ->
        ( model, Cmd.none )
      OauthLogoutFail _ ->
        ( model, Cmd.none )
      CalendarFetch startFrom ->
        ( { model | calendar = { status = Fetching, details = model.calendar.details } }
        , case model.oauth of
          Nothing -> Cmd.none
          Just oauth ->
            fetchCalendar model.config.oauth.clientId oauth.accessToken model.config.calendar.name (fromTime startFrom)
        )
      CalendarFetchSucceed newCalendarDetails ->
        ( { model | calendar = { status = Succeeded, details = Just newCalendarDetails } }
        , Cmd.none
        )
      CalendarFetchFail _ ->
        ( { model | calendar = { status = Failed, details = Nothing } }
        , Cmd.none
        )
      NoOp ->
        (model, Cmd.none)