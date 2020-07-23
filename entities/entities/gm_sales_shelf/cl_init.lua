include("shared.lua")

local ItemPoints = {
	{
		{Vector(15, -24, 2 + 26), Vector(15, -8, 2 + 26), Vector(15, 8, 2 + 26), Vector(15, 24, 2 + 26)},
		{Vector(15, -24, 2), Vector(15, -8, 2), Vector(15, 8, 2), Vector(15, 24, 2)},
		{Vector(15, -24, -24), Vector(15, -8, -24), Vector(15, 8, -24), Vector(15, 24, -24)},
		{Vector(15, -24, -46), Vector(15, -8, -46), Vector(15, 8, -46), Vector(15, 24, -46)},
	}
}

function ENT:Draw()
	self:DrawModel()

	for k, v in ipairs(ItemPoints[1]) do
		for k, V in ipairs(v) do
		debugoverlay.Cross(self:LocalToWorld(V), 1, 0, Color(255, 0, 0))
		end
	end
end