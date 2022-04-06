module Robot exposing (Language(..), Model, init, run)


type alias Model =
    { x : Int
    , y : Int
    , commands : String
    , facing : Direction
    , language : Language
    }


init : Model
init =
    { x = 1, y = 2, commands = "HGHGGHGHG", facing = North, language = Swedish }


type Direction
    = North
    | South
    | East
    | West


type Command
    = InvalidMove
    | Left
    | Right
    | Forward


type Language
    = English
    | Swedish
    | French


turnLeft : Direction -> Direction
turnLeft currentDir =
    case currentDir of
        North ->
            West

        West ->
            South

        South ->
            East

        East ->
            North


turnRight : Direction -> Direction
turnRight currentDir =
    case currentDir of
        North ->
            East

        East ->
            South

        South ->
            West

        West ->
            North


toCommands : Language -> Char -> Command
toCommands language s =
    case language of
        English ->
            case s of
                'R' ->
                    Right

                'L' ->
                    Left

                'F' ->
                    Forward

                _ ->
                    InvalidMove

        Swedish ->
            case s of
                'H' ->
                    Right

                'V' ->
                    Left

                'G' ->
                    Forward

                _ ->
                    InvalidMove

        French ->
            case s of
                'D' ->
                    Right

                'G' ->
                    Left

                'T' ->
                    Forward

                _ ->
                    InvalidMove


runCommand : Command -> Model -> Model
runCommand cmd m =
    case cmd of
        InvalidMove ->
            m

        Left ->
            { m | facing = turnLeft m.facing }

        Right ->
            { m | facing = turnRight m.facing }

        Forward ->
            case m.facing of
                North ->
                    { m | y = m.y - 1 }

                South ->
                    { m | y = m.y + 1 }

                West ->
                    { m | x = m.x - 1 }

                East ->
                    { m | x = m.x + 1 }


run : Model -> Model
run model =
    model.commands
        |> String.toList
        |> List.map Char.toUpper
        |> List.map (toCommands model.language)
        |> List.foldl runCommand model
