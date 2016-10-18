module Messages exposing (Message(..))

import Http
import Models exposing (CalendarDetailsModel, LogoutResponseModel, UserDetailsModel, WeatherDetailsModel)
import Time exposing (Time)

type Message
  = ClockTick Time
  | WeatherFetch Time
  | WeatherFetchSucceed WeatherDetailsModel
  | WeatherFetchFail Http.Error
  | OauthFetchUserInfo
  | OauthFetchUserInfoSucceed UserDetailsModel
  | OauthFetchUserInfoFail Http.Error
  | OauthLogout
  | OauthLogoutSucceed LogoutResponseModel
  | OauthLogoutFail Http.Error
  | CalendarFetch Time
  | CalendarFetchSucceed CalendarDetailsModel
  | CalendarFetchFail Http.Error
