MSC = MSC or {}

function MSC.findPlayers(name, limit)
    local plyList = {}
    limit = limit or 0
    local count = 0
    for i, ply in ipairs(player.GetAll()) do
        if string.find(string.lower(ply:Nick()), string.lower(name)) then -- if name contains the search string
            if limit > 0 then -- check if limit is set
                if count == limit then -- check if limit is reached
                    break -- break the loop
                else
                    table.insert(plyList, ply) -- add player to list
                    count = count + 1 -- increase count
                end
            else
                table.insert(plyList, ply) -- add player to list
            end
        end
    end

    return plyList
end

function MSC.findPlayer(name)
    local plyList = MSC.findPlayers(name, 1)
    return plyList[1] or false
end


function MSC.slay(ply)
    if ply:IsValid() then
        local slayer = ents.Create("msc_slayer")
        slayer:Spawn()

        ply:TakeDamage(ply:Health()*2, slayer, slayer)
        if ply:Alive() then
            ply:Kill()
        end
    end
end

function MSC.findTarget(ply, tgString, multi)
    if tgString == "^" then -- get self
        if ply:IsValid() then
            return ply
        else
            return nil 
        end
    elseif tgString == "@" then -- get player under crosshair
        local ent = ply:GetEyeTrace().Entity
        if ent:IsValid() then
            if ent:IsPlayer() then
                return ent
            end
        end
        return nil
    elseif tgString == "?" then -- get admins
        local adminList = {}
        for i, ply in ipairs(player.GetAll()) do
            if ply:IsAdmin() then
                table.insert(adminList, ply)
            end
        end
        return adminList
    elseif string.StartsWith(tgString, "$") then -- get by SteamID
        local id = string.sub(tgString, 2)
        local ply = player.GetBySteamID(id)
        if ply:IsValid() then
            return ply
        end
        return nil
    elseif tgString == "*" then -- get all players
        return player.GetAll()
    else
        local targets = {}
        for _,v in pairs(string.Explode(',', tgString)) do
            v = string.Trim(v)
            if v != "" then
                local found = MSC.findPlayers(v)
                for _, ply in ipairs(found) do
                    if !table.HasValue(targets, ply) then -- unique
                        table.insert(targets, ply)
                    end
                end
            end
        end
        return targets
    end
end