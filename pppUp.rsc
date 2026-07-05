:global GlobalConfig;
:if ($GlobalConfig != true) do={ /system/script/run GlobalConfig;};
:global BotID;
:global ChatID;
:global thisbox;

:local ip [/ip/address/get [find interface=sabdaindah.web.id] address];
:set ip [:pick $ip 0 [:find $ip "/"]];

:local nama $user;
:local ips [/ppp/active/get [find name=$nama] address];
:local caller [/ppp/active/get [find name=$nama] caller-id];
:local datetime "$[/system/clock/get date] ~ $[/system/clock/get time]";
#:local mrtg ("http://$ip/um/mrtg.html?user=$nama");

/tool fetch url="https://api.telegram.org/bot$BotID/sendMessage?chat_id=$ChatID&parse_mode=Markdown&text=*$thisbox*%20|%20PPPoE%20LOGIN%20\E2\9C\85%0A$datetime%0AUser:%20$nama%0AIP%20Client:%20$ips%0ACaller%20ID:%20$caller" keep-result=no;
