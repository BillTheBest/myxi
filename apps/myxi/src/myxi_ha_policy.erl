%% This Source Code Form is subject to the terms of
%% the Mozilla Public License, v. 2.0.
%% A copy of the MPL can be found in the LICENSE file or
%% you can obtain it at http://mozilla.org/MPL/2.0/.
%%
%% @author Brendan Hay
%% @copyright (c) 2012 Brendan Hay <brendan@soundcloud.com>
%% @doc
%%

-module(myxi_ha_policy).

-behaviour(myxi_policy).

-include("include/myxi.hrl").

%% Callbacks
-export([inject/1]).

%%
%% Callbacks
%%

-spec inject(#policy{}) -> #policy{}.
%% @doc
inject(Policy = #policy{method = Method = #'queue.declare'{arguments = Args}}) ->
    NewArgs = myxi:merge_keylist(Args, [{<<"x-ha-policy">>, longstr, <<"all">>}]),
    Policy#policy{method = Method#'queue.declare'{arguments = NewArgs}};
inject(Policy) ->
    Policy.



