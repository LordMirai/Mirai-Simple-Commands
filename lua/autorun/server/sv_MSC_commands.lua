MSC = MSC or {}
MSC.Commands = MSC.Commands or {}
MSC.Callbacks = MSC.Callbacks or {}

// command structures

MSC.Commands[""] = {
    name = "",
    cmd = "",
    desc = "",
    args = {},
    optArgs = {},
    callback = MSC.Callbacks[""],
    disabled = false,
    adminOnly = false
}

function MSC.formatCmd(cmdTable)
    local str = string.format("%s (%s). %s\nArgs: %s; %s",
        cmdTable.name,
        cmdTable.cmd,
        cmdTable.desc,
        table.concat(cmdTable.args, ", "),
        cmdTable.optArgs and table.concat(cmdTable.optArgs, ", ") or "")
    return str

end

MSC.Commands["example"] = {
    name = "Example Command",
    cmd = "example",
    desc = "This is an example command.",
    args = {"arg1","arg2"},
    optArgs = {"opt","args","..."},
    callback = MSC.Callbacks["example"],
    disabled = false
}

MSC.Commands["help"]{
    name = "List Commands",
    cmd = "help",
    desc = "Lists all commands, with args.",
    args = {},
    optArgs = {"command"},
    callback = MSC.Callbacks["help"],
    disabled = false
}

MSC.Commands["kick"] = {
    name = "Kick Player",
    cmd = "kick",
    desc = "Kicks a player from the server.",
    args = {"player"},
    optArgs = {"reason"},
    callback = MSC.Callbacks["kick"],
    disabled = false,
    adminOnly = true
}

MSC.Commands["slay"] = {
    name = "Slay Player",
    cmd = "slay",
    desc = "Kills a player.",
    args = {"plyName"},
    optArgs = {},
    callback = MSC.Callbacks["slay"],
    disabled = false,
    adminOnly = true
}