module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (..)


main =
    beginnerProgram
        { model = emptyModel
        , view = view
        , update = update
        }


type alias Model =
    { hearts : List Heart
    }


type alias Heart =
    { comment : String
    }


emptyModel : Model
emptyModel =
    { hearts = []
    }


view : Model -> Html Msg
view model =
    div []
        [ div [ class "pure-g" ] [ h2 [ class "header" ] [ text "Daisy's sparkling heart" ] ]
        , div [ class "pure-g" ]
            [ div [ class "content" ]
                [ div [] [ img [ src "./daisy.jpg" ] [] ]
                , div [ class "pure-g hearts" ] (display model)
                , div [ class "pure-g" ]
                    [ div [ class "pure-u-1-2" ]
                        [ button [ onClick Increment, class "pure-button-primary pure-button" ] [ text "Add" ] ]
                    , div [ class "pure-u-1-2" ]
                        [ button [ onClick Decrement, class "pure-button-secondary pure-button" ] [ text "Remove" ] ]
                    ]
                ]
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
            { hearts = Maybe.withDefault [] (List.tail (model.hearts)) }


newHeart : Heart
newHeart =
    { comment = "Sparkling"
    }


display : Model -> List (Html msg)
display model =
    (List.map (\h -> span [] [ text "💖" ]) model.hearts)
