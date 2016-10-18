module Models exposing (..)

import Time exposing (Time)

type alias Model =
  { config: ConfigModel
  , clock: ClockModel
  , weather: WeatherModel
  , calendar: CalendarModel
  , oauth: Maybe OauthModel
  , user: UserModel
  }

type alias ConfigModel =
  { weather:
    { darkSkyApiKey: String
    , longitude: Float
    , latitude: Float
    }
  , oauth: { clientId: String }
  , calendar: { name: String }
  }

type alias ClockModel = Time

type FetchStatus
  = Fetching
  | Succeeded
  | Failed

type alias WeatherModel =
  { status: FetchStatus
  , details: Maybe WeatherDetailsModel
  }

type alias WeatherDetailsModel =
  { temperature: Float }

type alias OauthModel =
  { accessToken: String
  , tokenType: String
  , expiresIn: String
  }

type alias CalendarModel =
  { status: FetchStatus
  , details: Maybe CalendarDetailsModel
  }

type alias CalendarDetailsModel =
  { updated: String
  , summary: String
  }

--type alias CalendarEventItem =
--  { id: String
--  , status: String
--  , summary: String
--  , description: String
--  }

type alias UserModel =
  { status: FetchStatus
  , details: Maybe UserDetailsModel
  }

type alias UserDetailsModel =
  { name: String
  , email: String
  }

type alias LogoutResponseModel = { success: Bool }
