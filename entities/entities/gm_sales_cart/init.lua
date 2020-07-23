AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("SalesAssignCart")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_cart002.mdl" or "models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	phys:SetMaterial("gm_sales_cart")
	phys:SetMass(1000)
	-- phys:SetInertia(-)
	-- self:GetPhysicsObject():SetDamping(0, 30)
end

physenv.AddSurfaceData(util.TableToKeyValues({
	base = "metal",
	friction = "0.30",
	density = "100",
}, "gm_sales_cart"))

local i = 0

function ENT:PhysicsUpdate(p)
	-- p:SetMaterial("gm_sales_cart")
	-- print("\nGetEnergy", p:GetEnergy(), "\nGetInertia", p:GetInertia(), "\nGetInvInertia", p:GetInvInertia(), "\nGetInvMass", p:GetInvMass(), "\nGetStress", p:GetStress(), "\nGetSurfaceArea", p:GetSurfaceArea())
	-- if i == 0 then PrintTable(p:GetFrictionSnapshot()) end i = (i + 1) % 100
	-- p:OutputDebugInfo()
	local ply = self.ply
	if not IsValid(ply) then return end
	local vel = p:GetVelocity()
	local acc = ply:KeyDown(IN_SPEED) and 15 or 5

	if ply:KeyDown(IN_BACK) then
		vel = vel * 0.95
	elseif ply:KeyDown(IN_FORWARD) then
		vel = vel + p:GetAngles():Forward() * acc
	end

	-- vel[3] = 8
	if ply:KeyDown(IN_MOVERIGHT) then
		p:SetAngles(p:GetAngles() + Angle(0, -2))
		-- p:SetPos(p:GetCapabilitiestPos() + Vector(0, 0, vel:Length() / 2000))
		-- vel:Rotate(-Angle(0, 2, -vel:Length() / 1200))
		if p:IsPenetrating() then
			vel = vel:GetNormalized() * math.min(vel:Length(), 100)
		end
		p:Wake()
	elseif ply:KeyDown(IN_MOVELEFT) then
		p:SetAngles(p:GetAngles() + Angle(0, 2))
		-- p:SetPos(p:GetPos() + Vector(0, 0, vel:Length() / 2000))
		-- vel:Rotate(Angle(0, 2, -vel:Length() / 1200))
		if p:IsPenetrating() then
			vel = vel:GetNormalized() * math.min(vel:Length(), 100)
		end
		p:Wake()
	end


	vel = vel:GetNormalized() * math.min(vel:Length(), 400)
	-- if vel:LengthSqr() < 1 then
	-- vel:SetUnpacked(0,0,0)
	-- p
	-- end
	p:SetVelocityInstantaneous(vel)
	p:AddAngleVelocity(p:GetAngleVelocity() * -1)
	-- if not ply:KeyDown(IN_BACK) then p:AddAngleVelocity(-p:GetAngleVelocity() * 0.5) end
end