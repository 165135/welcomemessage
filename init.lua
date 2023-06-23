if minetest.get_server_info().address == "ctf.rubenwardy.com" then
    storage = core.get_mod_storage()
    minetest.register_chatcommand("registerwelcome", {
        params = "<player_name>",
        func = function(message)
            players = message:sub(1,message:find(" "))
            playerlist = players:split(",")
            for i = 1, #playerlist do
                temp_data = (storage:get_string("names"))
                data_list = temp_data:split(",")
                local alreadyin = false
                for i = 1, #data_list do
                    if (data_list[i] == playerlist[i]) then
                        alreadyin = true
                    end
                end
                if alreadyin == false then
                    temp_data = temp_data .. "," .. playerlist[i]
                    storage:set_string("names", temp_data)
                    storage:set_string(playerlist[i], "")
                    print(minetest.colorize("#FF5000", storage:get_string("names")))
                else
                    print(minetest.colorize("#FF5000", "Already in list"))
                end
            end
        end,
    })

    minetest.register_chatcommand("removewelcome", {
        params = "<player_name>",
        func = function(message)
            players = message:sub(1,message:find(" "))
            playerlist = players:split(",")
            for i = 1, #playerlist do
                if storage:get_string("names"):find(playerlist[i]) then
                    storage:set_string("names",storage:get_string("names"):sub(1, storage:get_string("names"):find(playerlist[i])-2) .. storage:get_string("names"):sub(storage:get_string("names"):find(playerlist[i])+storage:get_string("names"):len(),-1))
                    print(minetest.colorize("#FF5000", "Removed player " .. playerlist[i]))
                else
                    print(minetest.colorize("#FF5000", "Cannot remove, not in welcome list"))
                end
            end
        end,
    })

    minetest.register_chatcommand("welcomemessage", {
        params = "<player> <message>",
        func = function(message)
            if not message:find(" ") then
                print(minetest.colorize("#FF5000", "Please format as .welcomemessage <player(s)> <message>"))
            else
                players = message:sub(1,message:find(" "))
                msg = message:sub(message:find(" "),-1)
                playerlist = players:split(",")
                for i = 1, #playerlist do
                   storage:set_string(playerlist[i],message:sub(message:find(" ")+1,-1))
                    print(minetest.colorize("#FF5000", "Message to send to " .. playerlist[i] .. " is: " .. storage:get_string(playerlist[i])))
                end
            end            
        end,
    })

    minetest.register_chatcommand("welcome", {
        params = "<true/false>",
        func = function(message)
            if message == "true" then
                storage:set_string("send", message)
                print("Will send welcome.")
            end
            if message == "false" then
                storage:set_string("send", message)
                print("Will not send welcome.")
            end
        end,
    })

    minetest.register_chatcommand("resetwelcome", {
        func = function(message)
            temp_data = (storage:get_string("names"))
            data_list = temp_data:split(",")
            for i = 1, #data_list do
               storage:set_string(data_list[i], "")
            end
            storage:set_string("names", "")
        end,
    })

    minetest.register_chatcommand("listwelcome", {
        func = function(message)
            print(minetest.colorize("#FF5000", "Welcome names: " .. storage:get_string("names")))
        end,
    })

    core.register_on_receiving_chat_message(function(message)
        privs = {
            interact = true,
        }
        if string.find(message, "***") and string.find(message, " joined the game.") and not (storage:get_string("send") == "false") then
            local name = minetest.localplayer:get_name()
            start = (string.find(message, "*** "))
            stop = (string.find(message, " joined the game."))
            message = string.sub(message,start+16,stop-13)
            --print(string.len(message))
            --print(message)
            
            local temp_msg = tostring(message)
        	temp_data = (storage:get_string("names"))
            data_list = temp_data:split(",")
            local indata = false
            for i = 1, #data_list do
               if (data_list[i] == message) then
                   indata = true
               end
            end
            if indata == true and not(name == message)then
                print(minetest.colorize("#FF5000", "Sent welcome to " .. message))
                --print(storage:get_string(message))
                temp_wb = "wb " .. message
                if not (storage:get_string(message) == "") then
                    temp_wb = (storage:get_string(message))
                end
                if storage:get_string(message):find("<name>") then
                    temp_wb = (storage:get_string(message):sub(1,storage:get_string(message):find("<name>")-1) .. message .. storage:get_string(message):sub(storage:get_string(message):find("<name>")+6,-1))
                end
                core.send_chat_message(temp_wb)
            message = ""
            end
        end
    end)
end
