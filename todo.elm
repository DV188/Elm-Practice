import Html exposing (div, input, button, text, li, ul, Html, node)
import Html.Attributes exposing (type_, value, attribute, class)
import Html.Events exposing (onClick, onInput)

-- MODEL
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }

type alias Model =
    { todo : String
    , todos : List String
    }

model : Model
model =
    { todo= ""
    , todos = []
    }

-- UPDATE

stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "Rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
            ]

        children =
            []
    in
        node tag attrs children

type Msg =
    UpdateTodo String
    | AddTodo
    | RemoveAll
    | RemoveItem String
    | UpdateInput

update : Msg -> Model -> Model
update msg model =
    case msg of
        UpdateTodo text ->
            { model | todo = text }
        AddTodo ->
            { model | todos = model.todo :: model.todos }
        RemoveAll ->
            { model | todos = [] }
        RemoveItem text ->
            { model | todos = List.filter (\x -> x /= text) model.todos }
        UpdateInput ->
            { model | todo = "" }

-- VIEW

todoItem : String -> Html Msg
todoItem todo =
    li [] [ text todo
        , button [onClick (RemoveItem todo)] [text "x"]
        ]

todoList : List String -> Html Msg
todoList todos =
    let
        child =
            List.map todoItem todos
    in
        ul [] child 

view model =
    div [class "jumbotron"]
        [ stylesheet
        , input [type_ "text"
            , onInput UpdateTodo
            , onClick UpdateInput
            , value model.todo
            , class "form-control"
            ] []
        , button [onClick AddTodo, class "btn btn-primary"] [text "Submit"]
        , button [onClick RemoveAll, class "btn btn-danger"] [text "Remove All"]
        , div [] [todoList model.todos]
        ]

