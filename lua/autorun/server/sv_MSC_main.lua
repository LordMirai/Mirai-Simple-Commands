MSC = MSC or {}

hook.Add("PlayerSay", "MSC_Say_Command_Callback", function(ply,msg)
    local parsed = MSC.parse(msg)
    if parsed then
        MSC.loadAndExecute(ply,parsed)
        return '' // prevent default
    end
end)

function MSC.sendMessage(ply,msg,col)
    net.Start('MSC_RequestMessage')
    net.WriteString(msg or "")
    net.WriteColor(col or Color(250,250,250))
    net.Send(ply)
end

function MSC.sendError(ply,msg)
    net.Start('MSC_RequestMessage')
    net.WriteString(msg or "")
    net.WriteColor(Color(220,20,20))
    net.Send(ply)
end

function MSC.broadcast(msg,long)
    net.Start('MSC_RequestMessageLong')
    net.WriteString(msg or "")
    net.WriteColor(Color(250,250,250))
    net.WriteBool(long or false)
    net.Broadcast()
end

print("sv_MSC.lua reloaded")