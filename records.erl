-module(records).
-compile(export_all).
%类似于 struct 的record
-record(robot,{
    name,
    type = industrial, %default value
    hobbies,
    details = []
}).

-record(user, {id, name, group, age}).

%包含头文件
-include("records.hrl").

first_robot() -> #robot{
    name = "Mechatron",  %type 为默认值， hobbies = undefined
    details = ["Moved by a small man inside"]}.

%取其中成员
get_name() ->
    A = first_robot(),
    A#robot.name.



%在rocord 上应用模式匹配
admin_panel(#user{name = Name, group = admin}) -> 
    Name ++ " is allowed!";
admin_panel(#user{name = Name}) ->
    Name ++ " is not allowed!".

adult_selection(U = #user{}) when U#user.age >= 18 ->
    allowed;
adult_selection(_) ->
    forbidden.


repairman() ->
    Bob = #robot{name = "Bob"},
    Details = Bob#robot.details,
    NewBob = Bob#robot{details = ["trying to have feelings"]},
    {havebeenchanged, NewBob}.

include() -> 
    A = #externalrecord{one = "1",two = "2",three = "3"},A.