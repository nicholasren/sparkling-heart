module Main exposing (main)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type Msg
    = Increment
    | Decrement
    | ChangeMode


type Mode
    = HeartMode
    | CourageMode



-- | Play


type alias Model =
    { hearts : Int
    , courage : Int
    , mode : Mode
    }



-- VIEW


view : Model -> Html Msg
view model =
    div [ class ".container-fluid" ]
        [ div [ class "row" ] [ h3 [ class "header" ] [ text "Daisy's sparkling heart" ] ]
        , div [ class "row" ] [ img [ src "./img/daisy.jpg" ] [] ]
        , div [ class "row" ] (displayHearts model)
        , div [ class "row" ] (displayCourage model)
        , div [ class "row" ]
            [ div [ class "col-xs-6" ]
                [ button [ onClick Increment, class "btn btn-primary" ] [ text "Add" ] ]
            , div [ class "col-xs-6" ]
                [ button [ onClick Decrement, class "btn btn-success" ] [ text "Remove" ] ]
            ]
        , div [ class "row" ] [ button [ onClick ChangeMode ] [ text (displayMode (model)) ] ]
        ]



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( increased (model)
            , Cmd.none
            )

        Decrement ->
            ( decreased (model)
            , Cmd.none
            )

        ChangeMode ->
            ( modeChanged (model)
            , Cmd.none
            )



-- Play ->
-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- INIT


init : ( Model, Cmd Msg )
init =
    ( defaultModel, Cmd.none )



--PRIVATE FUNCTION


defaultModel : Model
defaultModel =
    { hearts = 5
    , courage = 5
    , mode = HeartMode
    }


displayHearts : Model -> List (Html msg)
displayHearts model =
    List.range 1 model.hearts
        |> List.map (\c -> span [] [ text "💖" ])


displayCourage : Model -> List (Html msg)
displayCourage model =
    List.range 1 model.courage
        |> List.map (\c -> span [] [ text "💪" ])


displayMode : Model -> String
displayMode model =
    case model.mode of
        HeartMode ->
            "heart"

        CourageMode ->
            "courage"


increased : Model -> Model
increased model =
    case model.mode of
        HeartMode ->
            { hearts = inc (model.hearts)
            , courage = model.courage
            , mode = model.mode
            }

        CourageMode ->
            { hearts = model.hearts
            , courage = inc (model.courage)
            , mode = model.mode
            }


decreased : Model -> Model
decreased model =
    case model.mode of
        HeartMode ->
            { hearts = dec (model.hearts)
            , courage = model.courage
            , mode = model.mode
            }

        CourageMode ->
            { hearts = model.hearts
            , courage = dec (model.courage)
            , mode = model.mode
            }


modeChanged : Model -> Model
modeChanged model =
    { hearts = model.hearts
    , courage = model.courage
    , mode =
        case model.mode of
            HeartMode ->
                CourageMode

            CourageMode ->
                HeartMode
    }


inc : Int -> Int
inc num =
    if num < 12 then
        num + 1
    else
        num


dec : Int -> Int
dec num =
    if num == 1 then
        num
    else
        num - 1
