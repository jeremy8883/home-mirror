module Api.Calendar exposing(fetchCalendar)

import Api.CalendarDecoder exposing (decodeCalendar)
import Date exposing (Date)
import Http exposing (emptyBody, encodeUri, expectJson)
import Json.Decode
import Json.Decode.Pipeline
import Messages exposing (Message(CalendarFetch))
import Utils.Date exposing (dateToString)

fetchCalendar : String -> String -> String -> Date -> Cmd Message
fetchCalendar clientId accessToken calendarName now =
  let
    request =
      Http.request
      { url = "https://www.googleapis.com/calendar/v3/calendars/" ++
          encodeUri calendarName ++
          "/events?maxResults=50&timeMin=" ++ (encodeUri <| dateToString now) ++
          "&key=" ++ encodeUri clientId
      , headers = [Http.header "Authorization" ("Bearer " ++ accessToken)]
      , method = "GET"
      , body = emptyBody
      , expect = expectJson decodeCalendar
      , timeout = Nothing
      , withCredentials = False
      }
  in
    Http.send CalendarFetch request
