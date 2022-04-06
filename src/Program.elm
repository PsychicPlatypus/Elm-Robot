module Program exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style, type_, value)
import Html.Events exposing (onClick, onInput)
import Robot exposing (Model)
import String exposing (toInt)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = Robot.init
        , view = view
        , update = update
        }


turnToInt : String -> Int
turnToInt str =
    str
        |> toInt
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
            { model | x = turnToInt num }

        SetY num ->
            { model | y = turnToInt num }

        SetCommands cmds ->
            { model | commands = cmds }

        ButtonPressed ->
            let
                func =
                    Robot.executeOrders model.x model.y model.commands "English" model.facing
            in
            { model | x = func.x, y = func.y, facing = func.dir }



-- Run ->
-- View


view : Model -> Html Msg
view model =
    div [ style "display" "flex", style "flex-direction" "column", style "justify-content" "center", style "align-items" "center" ]
        [ h1 [] [ text "Robot" ]
        , div []
            [ input [ type_ "Text", onInput SetX, value (Debug.toString model.x) ] []
            , input [ type_ "Text", onInput SetY, value (Debug.toString model.y) ] []
            , input [ type_ "Text", onInput SetCommands, value model.commands ] []
            ]
        , button [ onClick ButtonPressed ] [ text "Run" ]
        ]
