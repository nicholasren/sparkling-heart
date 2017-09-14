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



-- | Play


type alias Model =
    { hearts : List Heart
    , courage : Int
    }


type alias Heart =
    { comment : String
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
        ]



--UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( heartIncreased (model)
            , Cmd.none
            )

        Decrement ->
            ( heartDecreased (model)
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
    { hearts = List.map (\n -> heart) (List.range 1 5)
    , courage = 5
    }


emptyModel : Model
emptyModel =
    { hearts = []
    , courage = 5
    }


heart : Heart
heart =
    { comment = "Sparkling"
    }


displayHearts : Model -> List (Html msg)
displayHearts model =
    model.hearts
        |> List.map (\h -> span [] [ text "💖" ])


displayCourage : Model -> List (Html msg)
displayCourage model =
    List.range 1 model.courage
        |> List.map (\c -> span [] [ text "💪" ])


heartIncreased : Model -> Model
heartIncreased model =
    { hearts = inc (model.hearts)
    , courage = model.courage
    }


heartDecreased : Model -> Model
heartDecreased model =
    { hearts = dec (model.hearts)
    , courage = model.courage
    }


inc : List Heart -> List Heart
inc hearts =
    if List.length hearts < 10 then
        hearts ++ [ heart ]
    else
        hearts


dec : List Heart -> List Heart
dec hearts =
    if List.length hearts == 1 then
        [ heart ]
    else
        hearts
            |> List.tail
            |> Maybe.withDefault [ heart ]
