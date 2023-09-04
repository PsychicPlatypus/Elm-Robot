module StyleGen exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)


appStyles : List (Attribute msg)
appStyles =
    [ style "display" "flex"
    , style "flex-direction" "column"
    , style "justify-content" "center"
    , style "align-items" "center"
    ]
