ENT.Base = "base_anim"
ENT.Type = "anim"

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