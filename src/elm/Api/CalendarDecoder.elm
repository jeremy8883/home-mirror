module Api.CalendarDecoder exposing (decodeCalendar)

import Json.Decode exposing (bool, int, list, nullable, string)
import Json.Decode.Pipeline exposing (decode, optional, required)
import Models exposing (CalendarDetails, CalendarEventItem, CalendarEventItemDate, CalendarEventItemUser)

decodeCalendar : Json.Decode.Decoder CalendarDetails
decodeCalendar =
    decode CalendarDetails
    |> required "etag" (string)
    |> required "summary" (string)
    |> required "updated" (string)
    |> required "timeZone" (string)
    |> required "accessRole" (string)
    |> required "items" (list decodeCalendarEventItem)

decodeCalendarEventItem : Json.Decode.Decoder CalendarEventItem
decodeCalendarEventItem =
    decode CalendarEventItem
    |> required "etag" (string)
    |> required "id" (string)
    |> required "status" (string)
    |> required "htmlLink" (string)
    |> required "created" (string)
    |> required "updated" (string)
    |> required "summary" (string)
    |> required "creator" (decodeCalendarEventItemUser)
    |> required "organizer" (decodeCalendarEventItemUser)
    |> required "start" (decodeCalendarEventItemDate)
    |> required "end" (decodeCalendarEventItemDate)
    |> required "iCalUID" (string)
    |> required "sequence" (int)

decodeCalendarEventItemUser : Json.Decode.Decoder CalendarEventItemUser
decodeCalendarEventItemUser =
    decode CalendarEventItemUser
    |> required "email" (string)
    |> required "displayName" (string)

decodeCalendarEventItemDate : Json.Decode.Decoder CalendarEventItemDate
decodeCalendarEventItemDate =
    decode CalendarEventItemDate
    |> optional "date" (nullable string) Nothing
    |> optional "dateTime" (nullable string) Nothing
