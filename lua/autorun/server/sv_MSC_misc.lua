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
    end
end