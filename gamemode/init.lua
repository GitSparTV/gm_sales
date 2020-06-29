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

function GM:PlayerNoClip()
	return true
end

concommand.Add("sales_start", function(ply, cmd, args)
	local cart = ents.Create("sales_cart")
	cart:SetPos(ply:GetEyeTrace().HitPos + Vector(0, 0, 10))
	cart:Spawn()
	cart:Activate()
	cart:AssignCart(ply)
end)

objs = {}

game.CleanUpMap()
math.randomseed(SysTime())
for k, v in ipairs(ents.FindByClass("info_target")) do
	local e = ents.Create("prop_physics")
	e:SetModel("models/gm_sales/shelf_1.mdl")
	e:SetAngles(Angle(0, math.random(0, 1) * 90, 0))
	e:Spawn()
	e:Activate()
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
	e:SetMoveType(MOVETYPE_NONE)
	e:GetPhysicsObject():EnableMotion(false)
	objs[k] = e
end


-- models/props_c17/shelfunit01a.mdl
-- models/props_wasteland/kitchen_shelf001a.mdl
-- models/props_c17/display_cooler01a.mdl
-- 