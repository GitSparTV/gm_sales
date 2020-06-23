include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_wasteland/laundry_cart002.mdl" or "models/hunter/blocks/cube025x025x025.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
	self:PhysWake()
	self:GetPhysicsObject():SetMass(1000)
end

function ENT:PhysicsUpdate(p)
	p:AddAngleVelocity(-p:GetAngleVelocity() * 0.5)
	local ply = self.ply
	local vel = p:GetVelocity()
	local acc = ply:KeyDown(IN_SPEED) and 100 or 10

	if ply:KeyDown(IN_BACK) then
		vel = vel * 0.99
	elseif ply:KeyDown(IN_FORWARD) then
		vel = vel + p:GetAngles():Forward() * acc
	end

	if ply:KeyDown(IN_MOVERIGHT) then
		p:SetAngles(p:GetAngles() - Angle(0,1-vel:Length() / 1200,-vel:Length() / 1200))
		p:SetPos(p:GetPos() + Vector(0,0,vel:Length() / 2000))
		p:Wake()
	elseif ply:KeyDown(IN_MOVELEFT) then
		p:SetAngles(p:GetAngles() + Angle(0,1-vel:Length() / 1200,-vel:Length() / 1200))
		p:SetPos(p:GetPos() + Vector(0,0,vel:Length() / 2000))
		p:Wake()
	end

	vel = vel:GetNormalized() * math.min(vel:Length(), 600)
	p:SetVelocity(vel)
	-- if not ply:KeyDown(IN_BACK) then p:AddAngleVelocity(-p:GetAngleVelocity() * 0.5) end
end