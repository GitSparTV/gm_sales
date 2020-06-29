ENT.Base = "base_anim"
ENT.Type = "anim"

function ENT:PhysicsUpdate(p)
	-- print("\nGetEnergy", p:GetEnergy(), "\nGetInertia", p:GetInertia(), "\nGetInvInertia", p:GetInvInertia(), "\nGetInvMass", p:GetInvMass(), "\nGetStress", p:GetStress(), "\nGetSurfaceArea", p:GetSurfaceArea())
	-- PrintTable(p:GetFrictionSnapshot())
	-- p:OutputDebugInfo()
	local ply = self.ply
	if not IsValid(ply) then return end
	p:AddAngleVelocity(-p:GetAngleVelocity())
	local vel = p:GetVelocity()
	local acc = ply:KeyDown(IN_SPEED) and 40 or 10

	if ply:KeyDown(IN_BACK) then
		vel = vel * 0.99
	elseif ply:KeyDown(IN_FORWARD) then
		vel = vel + p:GetAngles():Forward() * acc
	end

	if ply:KeyDown(IN_MOVERIGHT) then
		p:SetAngles(p:GetAngles() - Angle(0, 2, -vel:Length() / 1200))
		-- p:SetPos(p:GetPos() + Vector(0, 0, vel:Length() / 2000))
		-- vel:Rotate(-Angle(0, 2, -vel:Length() / 1200))
		p:Wake()
	elseif ply:KeyDown(IN_MOVELEFT) then
		p:SetAngles(p:GetAngles() + Angle(0, 2, -vel:Length() / 1200))
		-- p:SetPos(p:GetPos() + Vector(0, 0, vel:Length() / 2000))
		-- vel:Rotate(Angle(0, 2, -vel:Length() / 1200))
		p:Wake()
	end

	vel = vel:GetNormalized() * math.min(vel:Length(), 600)
	-- if vel:LengthSqr() < 1 then
	-- vel:SetUnpacked(0,0,0)
	-- p
	-- end
	p:SetVelocityInstantaneous(vel)
	-- if not ply:KeyDown(IN_BACK) then p:AddAngleVelocity(-p:GetAngleVelocity() * 0.5) end
end

function ENT:AssignCart(ply)
	self.ply = ply
	ply.Cart = self

	if SERVER then
		self:SetOwner(ply)
		net.Start("SalesAssignCart")
		net.WriteEntity(self)
		net.Send(ply)
	end
end