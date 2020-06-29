include("shared.lua")

local WaitForCart
net.Receive("SalesAssignCart", function()
	print("HELLO")
	local ent = net.ReadUInt(16)
	WaitForCart = ent
end)

hook.Add("OnEntityCreated","CartAssign",function(ent)
	timer.Simple(0,function()
		if ent:EntIndex() == WaitForCart then
			ent:AssignCart(LocalPlayer())
			WaitForCart = nil
		end
	end)
end)