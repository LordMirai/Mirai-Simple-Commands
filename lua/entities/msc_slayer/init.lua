AddCSLuaFile("shared.lua")
include("shared.lua")
-- no CL file needed

function ENT:Initialize()
	self:SetModel("")
	self:SetSolid(SOLID_NONE) -- nocollide with everything
    self:SetMoveType(MOVETYPE_NONE) -- don't move
    self:SetPos(0, 0, 0) -- initialize at 0, 0, 0, should be out of the way

	if self:IsValid() then
		self:Activate() -- not sure if this is needed
    end

    timer.Simple(3, function()
        if self:IsValid() then -- should have a very short lifetime
            self:Remove()
        end
    end)
end