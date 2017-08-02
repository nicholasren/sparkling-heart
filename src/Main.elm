module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


main =
    beginnerProgram
        { model = defaultModel
        , view = view
        , update = update
        }


type alias Model =
    { hearts : List Heart
    }


type alias Heart =
    { comment : String
    }


defaultModel : Model
defaultModel =
    { hearts = [ newHeart, newHeart, newHeart, newHeart, newHeart ]
    }


emptyModel : Model
emptyModel =
    { hearts = []
    }


view : Model -> Html Msg
view model =
    div [ class ".container-fluid" ]
        [ div [ class "row" ] [ h3 [ class "header" ] [ text "Daisy's sparkling heart" ] ]
        , div [ class "row" ] [ img [ src "./daisy.jpg" ] [] ]
        , div [ class "row" ] (display model)
        , div [ class "row" ]
            [ div [ class "col-xs-6" ]
                [ button [ onClick Increment, class "btn btn-primary" ] [ text "Add" ] ]
            , div [ class "col-xs-6" ]
                [ button [ onClick Decrement, class "btn btn-success" ] [ text "Remove" ] ]
            ]
        ]


type Msg
    = Increment
    | Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            { hearts =
                if List.length model.hearts < 5 then
                    model.hearts ++ [ newHeart ]
                else
                    model.hearts
            }

        Decrement ->
            { hearts =
                if List.length model.hearts == 1 then
                    [ newHeart ]
                else
                    Maybe.withDefault [] (List.tail (model.hearts))
            }


newHeart : Heart
newHeart =
    { comment = "Sparkling"
    }


display : Model -> List (Html msg)
display model =
    (List.map (\h -> span [] [ text "💖" ]) model.hearts)
