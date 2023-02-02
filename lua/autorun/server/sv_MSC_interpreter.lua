MSC = MSC or {}
MSC.Commands = MSC.Commands or {}

function MSC.parse(cmdString)
    local str = string.Trim(cmdString)
    local stringTable = {}
    if #str > 2 then -- it's 2 because we don't want to just have a prefix with no command. that would be pointless
        if MSC.prefixes[str[1]] then -- we recognize it can be a command
            stringTable = string.Split(str," ") -- separating them in a table
            local cmd = string.lower(string.sub(stringTable[1],2)) -- removing prefix and lowering to ignore case
            table.remove(stringTable,1) -- separating cmd from args
            return {command = cmd,args=stringTable}
        end
        return false -- not recognized as a function
    end
    return false -- we don't treat it
end


function MSC.loadAndExecute(ply,givenCmdTable)  -- givenCmdTable is a table with command and args as provided by MSC.parse
    local commandData = MSC.Commands[givenCmdTable.command]
    if commandData then
        if commandData.disabled then
            MSC.sendError(ply,string.format("Command '%s' (%s) is disabled.",commandData.name,commandData.cmd))
            return
        end

        if #commandData.args <= #givenCmdTable.args then
            MSC.execute(ply,givenCmdTable,commandData)
        else
            MSC.sendError(ply,string.format("Insufficient arguments provided to function %s (%d expected) Argument pretty name: %s",commandData.cmd,#commandData.args,commandData.args[#cmdStringData.args + 1]))
        end
    else
        MSC.sendError(ply,string.format("Command '%s' not found.",givenCmdTable.command))
        return
    end
end


function MSC.execute(ply,givenData,commandData)
    local callback = MSC.Callbacks[commandData.callback]
    if not isfunction(callback) then
        error(string.format("Callback '%s' not found.",givenData.command))
    end

    if commandData.adminOnly and not ply:IsAdmin() then
        MSC.sendError(ply,"Command is admin only.")
        return
    end

    if commandData.privillege then
        if not MSC.hasPrivillege(ply,commandData.privillege) then
            MSC.sendError(ply,"You don't have the privillege to execute this command.")
            return
        end
    end

    callback(ply,commandData,unpack(givenData.args))
end