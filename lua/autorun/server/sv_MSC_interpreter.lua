MSC = MSC or {}
MSC.Commands = MSC.Commands or {}
MSC.Messages = MSC.Messages or {}

function MSC.parse(cmdString)
    local str = string.Trim(cmdString)
    local stringTable = {}
    if #str > 2 then -- it's 2 because we don't want to just have a prefix with no command. that would be pointless
        if MSC.prefixes[str[1]] then -- we recognize it can be a command
            stringTable = string.Split(string.sub(str, 2), " ") -- separating them in a table, removing prefix
            local cmd = string.lower(stringTable[1]) -- lowering to ignore case
            table.remove(stringTable, 1) -- separating cmd from args
            return {command = cmd, args=stringTable}
        end
        return false -- not recognized as a function
    end
    return false -- we don't treat it
end


function MSC.loadAndExecute(ply, givenCmdTable)  -- givenCmdTable is a table with command and args as provided by MSC.parse
    local commandData = MSC.Commands[givenCmdTable.command]
    if commandData then
        if commandData.disabled then
            MSC.sendError(ply, string.format("Command '%s' (%s) is disabled.", commandData.name, commandData.cmd))
            return
        end

        if #commandData.args <= #givenCmdTable.args then
            MSC.execute(ply, givenCmdTable,commandData)
        else
            MSC.sendError(ply, string.format("Insufficient arguments provided to function %s (%d expected).\nArgument pretty name: %s",commandData.cmd,#commandData.args,commandData.args[#cmdStringData.args + 1]))
        end
    else
        MSC.sendError(ply, string.format("Command '%s' not found.", givenCmdTable.command))
        return
    end
end


function MSC.execute(ply, givenData, commandData)
    local callback = MSC.Callbacks[commandData.callback]
    if not isfunction(callback) then
        error(string.format("Callback '%s' not found.", givenData.command))
    end

    if commandData.adminOnly and not ply:IsAdmin() then
        MSC.sendError(ply, Msc.Messages.adminonly)
        return
    end

    if commandData.privillege then
        if not MSC.hasPrivillege(ply, commandData.privillege) then
            MSC.sendError(ply, MSC.Messages.noprivillege)
            return
        end
    end

    callback(ply, commandData, unpack(givenData.args))
end