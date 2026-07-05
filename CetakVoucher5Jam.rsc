:global GlobalConfig;
:if ($GlobalConfig != true) do={ /system/script/run GlobalConfig;};
:global BotID;
:global ChatID;
:global thisbox;

:local Profile "5Jam";
:local PrefixGroup "5j@";
:local Quantity 990;
:local Length 4;
:local Prefix "5";
:local Combine "lowercase,numbers";
:local PasswordLength empty;
:local Template 5Jam.html;
:local Expiredin 90d;

:local datetime ([/system/clock/get date] . "~" .  [/system/clock/get time]);
:local ip [/ip/address/get [find interface=sabdaindah.web.id] address];
:set ip [:pick $ip 0 [:find $ip "/"]];

:local URL ("http://" . $ip ."/um/PRIVATE/GENERATED/vouchers/gen_" . $Template);
:local groupname ("$PrefixGroup$datetime");
:local srcpath ("um5files/PRIVATE/GENERATED/vouchers/gen_" . $Template);
/user-manager/user/group/add name=$groupname copy-from=0;
/user-manager/user/add-batch-users profile=$Profile group=$groupname username-length=$Length username-characters=$Combine number-of-users=$Quantity password-length=$PasswordLength username-prefix=$Prefix;

/system/script/add name=$groupname source=\
"/user-manager/user/remove [find group=$groupname];\n\
/user-manager/user/group/remove [find name=$groupname];\n\
/system/script/run CleaningUM;\n\
/system/scheduler/remove [find name=$groupname];\n\
/system/script/remove [find name=$groupname];";

/system/scheduler/add name=$groupname interval=$Expiredin on-event=$groupname;

/user-manager/user/generate-voucher numbers=[find group=$groupname] voucher-template=$Template;

:log warning ("New Voucher Generated: $URL");

/tool/fetch url="https://api.telegram.org/bot$BotID/sendMessage?chat_id=$ChatID&text=Voucher%20$thisbox:%20$URL" keep-result=no;
