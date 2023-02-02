MSC = MSC or {}

function MSC.writeMessage(msg,col,long)
    local head = "[MSC] "
    if long then
        head = "[Mirai Simple Commands]"
        col = Color(50,0,250)
    end
    chat.AddText(Color(90,10,160),"[MSC] ",col or Color(250,250,250),msg)
end

net.Receive('MSC_RequestMessage', function()
    local msg = net.ReadString()
    local col = net.ReadColor()

    MSC.writeMessage(msg,col,false)
end)

net.Receive("MSC_RequestMessageLong", function()
    local msg = net.ReadString()
    local col = net.ReadColor()
    local long = net.ReadBool()

    MSC.writeMessage(msg,col,long)
end)

print("cl_MSC.lua reloaded")
