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
        , div [ class "row" ] (display model)
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
            ( { hearts =
                    increased (model)
              }
            , Cmd.none
            )

        Decrement ->
            ( { hearts = decreased (model)
              }
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
    }


emptyModel : Model
emptyModel =
    { hearts = []
    }


heart : Heart
heart =
    { comment = "Sparkling"
    }


display : Model -> List (Html msg)
display model =
    model.hearts
        |> List.map (\h -> span [] [ text "💖" ])


increased : Model -> List Heart
increased model =
    if List.length model.hearts < 10 then
        model.hearts ++ [ heart ]
    else
        model.hearts


decreased : Model -> List Heart
decreased model =
    if List.length model.hearts == 1 then
        [ heart ]
    else
        model.hearts
            |> List.tail
            |> Maybe.withDefault [ heart ]
