%%%----------------------------------------------------------------------
%%% File    : ejabberd_auth_solaris.erl
%%% Author  : Tiva <tiva@itztiva.com>
%%% Purpose : Auth via Solaris services
%%% Created : Feburary 7 2025 by Tiva <tiva@itztiva.com>
%%%
%%%----------------------------------------------------------------------

-module(ejabberd_auth_solaris).

-author('tiva@itztiva.com').

-behaviour(ejabberd_auth).

-export([start/1, stop/1, reload/1, set_password/3, check_password/4,
	 try_register/3, user_exists/2, remove_user/2,
	 store_type/1, plain_password_required/1]).

-include("logger.hrl").

%%%----------------------------------------------------------------------
%%% API
%%%----------------------------------------------------------------------
start(_Host) ->
    ok.

stop(_Host) ->
    ok.

reload(_Host) ->
    ok.

plain_password_required(_) -> true.

store_type(_) -> external.

check_password(User, _AuthzId, Server, Password) ->
    'Elixir.Synapse.Auth':check(User, Server, Password).

set_password(_User, _Server, _Password) ->
    {nocache, {error, db_failure}}.

try_register(_User, _Server, _Password) ->
    {nocache, {error, db_failure}}.

user_exists(_User, _Server) ->
    {nocache, {error, db_failure}}.

remove_user(_User, _Server) ->
    {nocache, {error, db_failure}}.
