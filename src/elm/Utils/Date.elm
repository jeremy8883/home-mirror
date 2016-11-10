module Utils.Date exposing (dateToString)

import Date exposing (Date, Month(Apr, Aug, Dec, Feb, Jan, Jul, Jun, Mar, May, Nov, Oct, Sep), day, hour, minute, month, second, year)
import String exposing (padLeft)


-- example output: "2016-07-04T10:00:00Z"
dateToString : Date -> String
dateToString date =
  (toString <| year <| date) ++ "-" ++
  (getDateMonth date) ++ "-" ++
  (padLeft 2 '0' <| toString <| day <| date) ++ "T" ++
  (padLeft 2 '0' <| toString <| hour <| date) ++ ":" ++
  (padLeft 2 '0' <| toString <| minute <| date) ++ ":" ++
  (padLeft 2 '0' <| toString <| second <| date) ++ "Z"

getDateMonth : Date -> String
getDateMonth date =
  case month date of
    Jan -> "01"
    Feb -> "02"
    Mar -> "03"
    Apr -> "04"
    May -> "05"
    Jun -> "06"
    Jul -> "07"
    Aug -> "08"
    Sep -> "09"
    Oct -> "10"
    Nov -> "11"
    Dec -> "12"
