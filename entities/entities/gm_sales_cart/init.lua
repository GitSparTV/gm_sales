AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("SalesAssignCart")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_cart002.mdl" or "models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysWake()
	self:GetPhysicsObject():SetMass(1000)
	-- self:GetPhysicsObject():SetDamping(0, 30)
end