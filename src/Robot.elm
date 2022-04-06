module Robot exposing (Model, executeOrders, fromJust, init)

import String exposing (left, length, right, slice, toUpper)


type alias Model =
    { x : Int
    , y : Int
    , commands : String
    , facing : Direction
    }


init : Model
init =
    { x = 0, y = 0, commands = "", facing = North }


type Direction
    = North
    | South
    | East
    | West


fromJust : Maybe a -> a
fromJust x =
    case x of
        Just y ->
            y

        Nothing ->
            Debug.todo "error: fromJust Nothing"


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


executeOrders : Int -> Int -> String -> String -> Direction -> { x : Int, y : Int, dir : Direction }
executeOrders x y commands lang dir =
    let
        moves =
            case lang of
                "English" ->
                    "RLF"

                "French" ->
                    "HVG"

                "Swedish" ->
                    "DGT"

                _ ->
                    Debug.todo "Add more Languages"

        fw =
            right 1 moves

        rght =
            left 1 moves

        lft =
            slice 1 2 moves

        first_move =
            left 1 (toUpper commands)

        rest =
            slice 1 (length commands) (toUpper commands)
    in
    if first_move == "" then
        { x = x, y = y, dir = dir }

    else if first_move == fw then
        if dir == North then
            executeOrders x (y - 1) rest lang dir

        else if dir == East then
            executeOrders (x + 1) y rest lang dir

        else if dir == South then
            executeOrders x (y + 1) rest lang dir

        else
            executeOrders (x - 1) y rest lang dir

    else if first_move == lft then
        executeOrders x y rest lang (turnLeft dir)

    else if first_move == rght then
        executeOrders x y rest lang (turnRight dir)

    else
        Debug.todo "branch '_' not implemented"
