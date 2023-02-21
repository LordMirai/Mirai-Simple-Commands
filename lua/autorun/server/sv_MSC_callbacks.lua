MSC = MSC or {}
MSC.Commands = MSC.Commands or {}
MSC.Callbacks = MSC.Callbacks or {}


MSC.Callbacks["example"] = function(ply, data, ...)
    local args = {...}
    print("Hello World!", ply)
    PrintTable(args)
end

MSC.Callbacks["help"] = function(ply, data, ...)
    local args = {...}
    local target = ""
    if #args>0 then
        target = args[1]
        
        if not MSC.Commands[target] then
            MSC.sendMessage(ply, "Command not found.",MSC.COLOR_WARNING)
            return
        end

        if MSC.Commands[target].disabled then
            MSC.sendMessage(ply, "Command is disabled.",MSC.COLOR_WARNING)
            return
        end
    end

    local outStr = "Printing command data for "
    if target == "" then
        outStr = outStr .. "all commands.\n"
        for k,v in ipairs(MSC.Commands) do
            outStr = outStr .. MSC.formatCmd(v)
        end
    else
        outStr = outStr .. target .. ".\n"..MSC.formatCmd(MSC.Commands[target])
    end

    MSC.sendMessage(ply, outStr)
end

MSC.Callbacks["slay"] = function(ply, data, ...)
    local args = {...}
    local target = args[1]

    local targetPly = MSC.findTarget(ply, target)
    if not targetPly then
        MSC.sendMessage(ply, "Player not found.",MSC.COLOR_WARNING)
        return
    end
    if targetPly:IsPlayer() then
        MSC.slay(targetPly)
        
        MSC.sendMessage(ply, "Player "..targetPly:Nick().." has been slain.",MSC.COLOR_SUCCESS)
        MSC.sendMessage(targetPly, "You have been slain by "..ply:Nick()..".",MSC.COLOR_ERROR)
    else
        local nicks = {}
        for k,v in ipairs(targetPly) do
            table.Add(nicks, v:Nick())
            MSC.slay(v)
            MSC.sendMessage(v, "You have been slain by "..ply:Nick()..".",MSC.COLOR_ERROR)
        end
        MSC.sendMessage(ply, "The following players have been slain:\n"..table.concat(nicks,", "),MSC.COLOR_SUCCESS)
end


MSC.Callbacks["kick"] = function(ply, data, ...)
    local args = {...}
    local target = args[1]

    local targetPly = MSC.findTarget(ply, target)
    if not targetPly then
        MSC.sendMessage(ply, "Player not found.",MSC.COLOR_WARNING)
        return
    end

    if istable(targetPly) then
        MSC.sendMessage(ply, "Multiple players found.",MSC.COLOR_WARNING)
        return
    end

    table.remove(args,1)

    local reason = table.concat(args," ")
    local msg = "[MSC] You have been kicked by "..ply:Nick()..". Reason: "..reason
    target:Kick(msg)
end