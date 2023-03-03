MSC = MSC or {}

MSC.prefixes = {
    ['{'] = true,
    [':'] = true
}


MSC.COLOR_DEFAULT = Color(250,250,250)
MSC.COLOR_ERROR = Color(250,20,20)
MSC.COLOR_SUCCESS = Color(20,250,20)
MSC.COLOR_WARNING = Color(250,180,50)

MSC.Messages = {
    notarget = "No valid target found.",
    foundmulti = "Multiple targets found, please be more specific.",
    deadtarget = "Target is dead.",
    noprivillege = "You don't have the privillege to execute this command.",
    adminonly = "This command is admin only.",
}