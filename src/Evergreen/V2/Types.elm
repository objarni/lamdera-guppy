module Evergreen.V2.Types exposing (..)

import Browser
import Browser.Navigation
import Lamdera
import Url


type alias FrontendModel =
    { key : Browser.Navigation.Key
    , message : String
    }


type alias BackendModel =
    { message : String
    , clients : (List Lamdera.ClientId)
    }


type ToBackend
    = NewClient
    | NoOpToBackend
    | SetMessage String


type FrontendMsg
    = UrlClicked Browser.UrlRequest
    | UrlChanged Url.Url
    | NoOpFrontendMsg
    | WrapToBackend ToBackend


type BackendMsg
    = NoOpBackendMsg


type ToFrontend
    = NoOpToFrontend
    | UpdateMessage String