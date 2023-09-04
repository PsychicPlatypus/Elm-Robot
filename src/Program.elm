module Program exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style, type_, value)
import Html.Events exposing (onClick, onInput)
import Robot exposing (Model)
import StyleGen exposing (appStyles)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = Robot.init
        , view = view
        , update = update
        }


toInt : String -> Int
toInt str =
    str
        |> String.toInt
        |> Maybe.withDefault 0



-- Subscriptions
-- Update


type Msg
    = SetX String
    | SetY String
    | SetCommands String
    | ButtonPressed



-- Run


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetX num ->
            { model | x = toInt num }

        SetY num ->
            { model | y = toInt num }

        SetCommands commands ->
            { model | commands = commands }

        ButtonPressed ->
            Robot.run model
                |> Debug.log "new status"



-- Run ->
-- View


view : Model -> Html Msg
view model =
    div appStyles
        [ h1 [] [ text "Robot" ]
        , div [ style "display" "flex" ]
            [ input [ type_ "Text", onInput SetX, value (String.fromInt model.x) ] []
            , input [ type_ "Text", onInput SetY, value (String.fromInt model.y) ] []
            , br [] []
            , input [ type_ "Text", value (Robot.directionToString model.facing) ] []
            , br [] []
            , input [ type_ "Text", onInput SetCommands, value model.commands ] []
            ]
        , button [ onClick ButtonPressed ] [ text "Run" ]
        ]
