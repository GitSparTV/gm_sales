include("shared.lua")

function GM:Initialize()
	print("Initialize")
end

function GM:InitPostEntity()
	print("InitPostEntity")
end

function GM:Think()
end

function GM:PlayerShouldTakeDamage(ply, attacker)
	print("PlayerShouldTakeDamage")
end

function GM:EntityTakeDamage(ent, info)
	print("EntityTakeDamage")
end

function GM:PlayerHurt(player, attacker, healthleft, healthtaken)
	print("PlayerHurt")
end

function GM:CreateEntityRagdoll(entity, ragdoll)
	print("CreateEntityRagdoll")
end

function GM:PlayerInitialSpawn(ply)
end

function GM:PlayerSpawn(ply)
end

function GM:CanPlayerSuicide()
	return false
end

function GM:SetupMove(ply, mv, cmd)
	if ply.Cart and ply.Cart:IsValid() then
		mv:SetOrigin(ply.Cart:LocalToWorld(Vector(-60, 0, -15)))
		cmd:SetButtons(0)
		cmd:ClearMovement()
		ply.Cart:PhysWake()
	end
end

function GM:PlayerNoClip()
	return true
end

-- function GM:Move() return true end
concommand.Add("sales_start", function(ply, cmd, args)
	local cart = ents.Create("sales_cart")
	cart:SetPos(ply:GetEyeTrace().HitPos + Vector(0, 0, 10))
	cart:Spawn()
	cart:Activate()
	cart.ply = ply
	ply.Cart = cart
end)

local objs = {}

timer.Create("generate", 0.3, 0, function()
	math.randomseed(SysTime())

	if #objs ~= 0 then
		for k, v in ipairs(objs) do
			if v:IsValid() then
				v:SetAngles(Angle(90, math.random(0, 1) * 90, 0))
			end
		end
	else
		for k, v in ipairs(ents.FindByClass("info_target")) do
			local e = ents.Create("prop_physics")
			e:SetModel("models/props_phx/construct/metal_plate2x2.mdl")
			e:SetAngles(Angle(90, math.random(0, 1) * 90, 0))
			e:Spawn()
			e:Activate()
			e:SetMoveType(MOVETYPE_NONE)
			local trace = {}
			trace.start = v:GetPos()
			trace.endpos = v:GetPos() + (v:GetUp() * -512)
			local tr = util.TraceLine(trace)
			e:SetPos(tr.HitPos)
			local vFlushPoint = tr.HitPos - (tr.HitNormal * 2048)
			vFlushPoint = e:NearestPoint(vFlushPoint)
			vFlushPoint = e:GetPos() - vFlushPoint
			vFlushPoint = tr.HitPos + vFlushPoint
			debugoverlay.Cross(tr.HitPos, 10, 5, Color(255, 0, 0))
			e:SetPos(vFlushPoint)
			objs[k] = e
		end
	end
end)
-- models/props_c17/shelfunit01a.mdl
-- models/props_wasteland/kitchen_shelf001a.mdl
-- models/props_c17/display_cooler01a.mdl
-- 