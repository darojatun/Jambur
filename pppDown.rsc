:global GlobalConfig;
:if ($GlobalConfig != true) do={ /system/script/run GlobalConfig;};
:global BotID;
:global ChatID;
:global thisbox;

:local nama $user;
#:local nama test@ppp;

:local datetime "$[/system/clock/get date] ~ $[/system/clock/get time]";
#:local mrtg ("http://$ip/um/mrtg.html?user=$nama");

/tool fetch url="https://api.telegram.org/bot$BotID/sendMessage?chat_id=$ChatID&parse_mode=Markdown&text=*$thisbox* | PPPoE LOGOUT \E2\9D\8C%0A$datetime%0AUser: $nama" keep-result=no;


