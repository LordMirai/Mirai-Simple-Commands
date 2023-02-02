AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("")
	self:SetSolid(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetPos(0,0,-100)

	if self:IsValid() then
		self:Activate()
	else return end

    timer.Simple(3, function()
        if self:IsValid() then
            self:Remove()
        end
    end)
end