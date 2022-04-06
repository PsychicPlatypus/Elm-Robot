module Robot exposing (Model, execute_orders, fromJust)

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


turn_left : String -> String
turn_left currentDir =
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


turn_right : String -> String
turn_right currentDir =
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


execute_orders : Int -> Int -> String -> String -> String -> { x : Int, y : Int, dir : String }
execute_orders x y commands lang dir =
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
            execute_orders x (y - 1) rest lang dir

        else if dir == "E" then
            execute_orders (x + 1) y rest lang dir

        else if dir == "S" then
            execute_orders x (y + 1) rest lang dir

        else
            execute_orders (x - 1) y rest lang dir

    else if first_move == lft then
        execute_orders x y rest lang (turn_left dir)

    else if first_move == rght then
        execute_orders x y rest lang (turn_right dir)

    else
        Debug.todo "branch '_' not implemented"
