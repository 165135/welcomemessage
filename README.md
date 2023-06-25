# chatwelcomer
Written by Peace12345 (aka Brain_Juice)
Send automatic welcome messages to players.

Commands:
Register player(s) with ".registerwelcome <player>".
Set a specific welcome message for player(s)* with ".welcomemessage <player(s)> <message>". To set where in <message> to put the player's name, use <name> within the string. Ex. ".welcomemessage Brain_Juice Hello, <name>!". Leaving <message> empty will default to "wb <name>", but a space after <playername> is still required.
List the players you send welcome to with ".listwelcome".
Remove player(s)* from your welcome list with ".removewelcome <player>".
Reset players you send welcome to with ".resetwelcome". NOTE: This removes all players from the list, use with caution.
Turn welcome message on (globaly) with ".welcome <true>". Turn welcome message off (globaly) with ".welcome <false>".

* To input more than one player, separate them by commas without spaces in between, Ex. "Brain_Juice,Peace12345,etc".

How to download this (and other) CSMs:
 1. From github, click on the green "<> Code⏷" Button. From there, click "Download ZIP".
 2. Go to your Downloads folder. Extract the .zip file.
 3. Move the extracted file to the "clientmods" folder in your Minetest directory.
 4. If there is not already, create a text file, "mods.conf". Type in, "load_mod_welcomemessage = true".
 5. Launch Minetest, go to settings, and enable client modding.
 6. All done!
