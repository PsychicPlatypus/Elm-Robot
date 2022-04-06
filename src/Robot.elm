module Robot exposing (Model, executeOrders, fromJust)

import List exposing (head)
import String exposing (left, length, right, slice, toUpper)



-- Model


type alias Model =
    { x : Int
    , y : Int
    , commands : String
    , facing : String
    }


fromJust : Maybe a -> a
fromJust x =
    case x of
        Just y ->
            y

        Nothing ->
            Debug.todo "error: fromJust Nothing"


turnLeft : String -> String
turnLeft currentDir =
    case currentDir of
        "N" ->
            "W"

        "W" ->
            "S"

        "S" ->
            "E"

        "E" ->
            "N"

        invalidState ->
            invalidState


turnRight : String -> String
turnRight currentDir =
    case currentDir of
        "N" ->
            "E"

        "E" ->
            "S"

        "S" ->
            "W"

        "W" ->
            "N"

        invalidState ->
            invalidState


facing : String -> List String
facing dir =
    case dir of
        "N" ->
            [ "N", "E", "S", "W" ]

        "E" ->
            [ "E", "S", "W", "N" ]

        "S" ->
            [ "S", "W", "N", "E" ]

        _ ->
            [ "W", "N", "E", "S" ]


executeOrders : Int -> Int -> String -> String -> String -> { x : Int, y : Int, dir : String }
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

        directions =
            facing dir

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
        { x = x, y = y, dir = fromJust (head directions) }

    else if first_move == fw then
        if dir == "N" then
            executeOrders x (y - 1) rest lang dir

        else if dir == "E" then
            executeOrders (x + 1) y rest lang dir

        else if dir == "S" then
            executeOrders x (y + 1) rest lang dir

        else
            executeOrders (x - 1) y rest lang dir

    else if first_move == lft then
        executeOrders x y rest lang (turnLeft dir)

    else if first_move == rght then
        executeOrders x y rest lang (turnRight dir)

    else
        Debug.todo "branch '_' not implemented"
