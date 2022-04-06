module RobotFuncs exposing (Model, execute_orders, fromJust)

import List exposing (drop, head, take)
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


turn_left : List String -> List String
turn_left dir_list =
    let
        x =
            take 1 dir_list

        y =
            drop 1 dir_list

        return_list =
            y ++ x
    in
    return_list


turn_right : List String -> List String
turn_right dir_list =
    let
        x =
            take 3 dir_list

        y =
            drop 3 dir_list

        return_list =
            y ++ x
    in
    return_list


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
        execute_orders x y rest lang (fromJust (head (turn_left directions)))

    else if first_move == rght then
        execute_orders x y rest lang (fromJust (head (turn_right directions)))

    else
        Debug.todo "branch '_' not implemented"
