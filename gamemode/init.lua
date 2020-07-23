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

	function GM:KeyPress(ply, key)
		if key == IN_USE then
			local tr = ply:GetEyeTrace()
			print(tr.Entity:WorldToLocal(tr.HitPos))
		end
	end

	concommand.Add("sales_start", function(ply, cmd, args)
		local cart = ents.Create("gm_sales_cart")
		cart:SetPos(ply:GetEyeTrace().HitPos + Vector(0, 0, 10))
		cart:Spawn()
		cart:Activate()
		cart:AssignCart(ply)
	end)

	concommand.Add("sales_cleanup", function(ply, cmd, args)
		game.CleanUpMap()
	end)

	objs = {}
	game.CleanUpMap()
	util.AddNetworkString("test")
	local nameToEnt = {}

	local function FindChild(v, dir)
		local s1, s2, s3, s4 = nameToEnt[v.Shelf1], nameToEnt[v.Shelf2], nameToEnt[v.Shelf3], nameToEnt[v.Shelf4]
		local sc = (s1 and 1 or 0) + (s2 and 1 or 0) + (s3 and 1 or 0) + (s4 and 1 or 0)

		if sc <= 1 then
			if s1 and not s1.WasUsed then
				if dir then
					local d = v:GetPos()
					d:Sub(s1:GetPos())
					d:Normalize()
					if dir ~= d then return end
				end

				return s1
			else
				return
			end
		end

		local wu1, wu2, wu3, wu4 = s1 and s1.WasUsed, s2 and s2.WasUsed, s3 and s3.WasUsed, s4 and s4.WasUsed

		if dir then
			local vp = v:GetPos()

			if not wu1 and s1 then
				local d = vp - s1:GetPos()
				d:Normalize()

				if dir ~= d then
					wu1 = true
				end
			end

			if not wu2 and s2 then
				local d = vp - s2:GetPos()
				d:Normalize()

				if dir ~= d then
					wu2 = true
				end
			end

			if not wu3 and s3 then
				local d = vp - s3:GetPos()
				d:Normalize()

				if dir ~= d then
					wu3 = true
				end
			end

			if not wu4 and s4 then
				local d = vp - s4:GetPos()
				d:Normalize()

				if dir ~= d then
					wu4 = true
				end
			end
		end

		-- local s = select(math.random())
		if wu1 and (wu2 or not s2) and (wu3 or not s3) and (wu4 or not s4) then return end
		local shift = 4 - sc

		do
			::check::

			if wu1 then
				wu1, wu2, wu3, wu4 = wu2, wu3, wu4
				s1, s2, s3, s4 = s2, s3, s4
				shift = shift + 1
				goto check
			end
		end

		if shift <= 2 then
			::check::

			if wu2 then
				wu2, wu3, wu4 = wu3, wu4
				s2, s3, s4 = s3, s4
				shift = shift + 1
				goto check
			end
		end

		if shift <= 1 then
			::check::

			if wu3 then
				wu3, wu4 = wu4
				s3, s4 = s4
				shift = shift + 1
				goto check
			end
		end

		if shift == 0 and wu4 then
			shift = shift + 1
		end

		return select(math.random(4 - shift), s1, s2, s3, s4)
	end

	local ItemPoints = {
		{
			{Vector(15, -24, 2 + 26 + 1), Vector(15, -8, 2 + 26 + 1), Vector(15, 8, 2 + 26 + 1), Vector(15, 24, 2 + 26 + 1)},
			{Vector(15, -24, 2 + 1), Vector(15, -8, 2 + 1), Vector(15, 8, 2 + 1), Vector(15, 24, 2 + 1)},
			{Vector(15, -24, -24 + 1), Vector(15, -8, -24 + 1), Vector(15, 8, -24 + 1), Vector(15, 24, -24 + 1)},
			{Vector(15, -24, -46 + 1), Vector(15, -8, -46 + 1), Vector(15, 8, -46 + 1), Vector(15, 24, -46 + 1)},
		}
	}

	local Items = {"models/props_c17/lampShade001a.mdl", "models/props_combine/breenglobe.mdl", "models/props_interiors/pot01a.mdl", "models/props_interiors/pot02a.mdl", "models/props_junk/CinderBlock01a.mdl", "models/props_junk/metal_paintcan001a.mdl", "models/props_junk/plasticbucket001a.mdl", "models/props_junk/PopCan01a.mdl", "models/props_junk/garbage_coffeemug001a.mdl", "models/props_junk/garbage_glassbottle001a.mdl", "models/props_junk/garbage_glassbottle002a.mdl", "models/props_junk/garbage_glassbottle003a.mdl", "models/props_junk/garbage_glassbottle003a.mdl", "models/props_junk/garbage_metalcan002a.mdl", "models/props_junk/garbage_milkcarton001a.mdl", "models/props_junk/garbage_milkcarton002a.mdl", "models/props_junk/garbage_plasticbottle002a.mdl", "models/props_junk/garbage_plasticbottle001a.mdl", "models/props_junk/garbage_plasticbottle003a.mdl", "models/props_junk/garbage_takeoutcarton001a.mdl", "models/props_junk/GlassBottle01a.mdl", "models/props_junk/glassjug01.mdl", "models/props_junk/watermelon01.mdl", "models/props_lab/cactus.mdl", "models/props_lab/huladoll.mdl", "models/props_lab/jar01a.mdl", "models/maxofs2d/camera.mdl", "models/food/burger.mdl", "models/food/hotdog.mdl",}

	concommand.Add("sales_s", function(ply, cmd, args)
		-- timer.Create("a", 2, 0, function()
		-- do return end
		game.CleanUpMap()
		math.randomseed(SysTime())
		local points = ents.FindByClass("gm_sales_shelf_point")
		local pk = #points

		for k = 1, pk do
			local v = points[k]
			v.WasUsed = nil
			nameToEnt[v:GetName()] = v
		end

		for _ = 1, pk * 2 do
			local a, b = math.random(pk), math.random(pk)
			points[a], points[b] = points[b], points[a]
		end

		for k = 1, pk do
			local v = points[k]
			local e

			if v.WasUsed then
				goto skip
			end

			v.WasUsed = true

			do
				local len = math.random()

				if len > 0.7 then
					len = 4
				elseif len > 0.5 then
					len = 3
				elseif len > 0.1 then
					len = 2
				else
					len = 1
				end

				e = ents.Create("gm_sales_shelf")
				e:SetModel("models/gm_sales/shelf_1.mdl")

				if len == 1 then
					net.Start("test")
					net.WriteUInt(0, 2)
					net.WriteVector(v:GetPos())
					net.Send(Entity(1))
					e:SetPos(v:GetPos())
					e:SetAngles(Angle(0, math.random(-1, 1) * 90, 0))
					goto eskip
				else
					local child1 = FindChild(v)

					if not child1 then
						net.Start("test")
						net.WriteUInt(0, 2)
						net.WriteVector(v:GetPos())
						net.Send(Entity(1))
						e:SetPos(v:GetPos())
						e:SetAngles(Angle(0, math.random(-1, 1) * 90, 0))
						goto eskip
					end

					child1.WasUsed = true
					local vp1 = v:GetPos()
					local cp1 = child1:GetPos()
					vp1:Sub(cp1)
					vp1:Normalize()

					if len == 2 then
						net.Start("test")
						net.WriteUInt(1, 2)
						net.WriteVector(v:GetPos())
						net.WriteVector(child1:GetPos())
						net.Send(Entity(1))
						e:SetModel("models/gm_sales/shelf_2.mdl")
						e:SetPos(v:GetPos() - (v:GetPos() - cp1) / 2)
					else
						local child2 = FindChild(child1, vp1)

						if not child2 then
							net.Start("test")
							net.WriteUInt(1, 2)
							net.WriteVector(v:GetPos())
							net.WriteVector(cp1)
							net.Send(Entity(1))
							e:SetModel("models/gm_sales/shelf_2.mdl")
							e:SetPos(v:GetPos() - (v:GetPos() - cp1) / 2)
						elseif len == 3 then
							net.Start("test")
							net.WriteUInt(2, 2)
							net.WriteVector(v:GetPos())
							net.WriteVector(cp1)
							net.WriteVector(child2:GetPos())
							net.Send(Entity(1))
							e:SetModel("models/gm_sales/shelf_3.mdl")
							e:SetPos(cp1)
							child2.WasUsed = true
						elseif len == 4 then
							local cp2 = child2:GetPos()
							child2.WasUsed = true
							local child3 = FindChild(child2, vp1)

							if not child3 then
								net.Start("test")
								net.WriteUInt(2, 2)
								net.WriteVector(v:GetPos())
								net.WriteVector(cp1)
								net.WriteVector(cp2)
								net.Send(Entity(1))
								e:SetModel("models/gm_sales/shelf_3.mdl")
								e:SetPos(cp1)
							else
								net.Start("test")
								net.WriteUInt(3, 2)
								net.WriteVector(v:GetPos())
								net.WriteVector(cp1)
								net.WriteVector(cp2)
								net.WriteVector(child3:GetPos())
								net.Send(Entity(1))
								e:SetModel("models/gm_sales/shelf_4.mdl")
								e:SetPos(cp1 - (cp1 - cp2) / 2)
								child3.WasUsed = true
							end
						end
					end

					local a = vp1:Angle()
					a[2] = a[2] + 90
					e:SetAngles(a)
				end

				::eskip::
				local trace = {}
				trace.start = e:GetPos()
				trace.endpos = e:GetPos() + Vector(0, 0, -512)
				trace.filter = e
				local tr = util.TraceLine(trace)
				e:SetPos(tr.HitPos)
				local vFlushPoint = tr.HitPos - (tr.HitNormal * 2048)
				vFlushPoint = e:NearestPoint(vFlushPoint)
				vFlushPoint = e:GetPos() - vFlushPoint
				vFlushPoint = tr.HitPos + vFlushPoint
				e:SetPos(vFlushPoint)
				e:SetMaterial("models/gibs/woodgibs/woodgibs01")
				e:Spawn()
				e:Activate()
				e:SetMoveType(MOVETYPE_NONE)
				e:GetPhysicsObject():EnableMotion(false)
			end

			::skip::

			if e then
				for k, v in ipairs(ItemPoints[1]) do
					for k, V in ipairs(v) do
						local E = ents.Create("prop_physics")
						E:SetModel(Items[math.random(#Items)])
						E:SetPos(e:LocalToWorld(V))
						local trace = {}
						trace.start = E:GetPos()
						trace.endpos = E:GetPos() + Vector(0, 0, -512)
						trace.filter = E
						local tr = util.TraceLine(trace)
						E:SetPos(tr.HitPos)
						local vFlushPoint = tr.HitPos - (tr.HitNormal * 2048)
						vFlushPoint = E:NearestPoint(vFlushPoint)
						vFlushPoint = E:GetPos() - vFlushPoint
						vFlushPoint = tr.HitPos + vFlushPoint
						E:SetPos(vFlushPoint)
						E:Spawn()
						E:Activate()
						E:GetPhysicsObject():EnableMotion(false)
						E:SetMoveType(MOVETYPE_NONE)
					end
				end
			end
			-- print(v)
			-- objs[k] = e
		end
	end)
	-- models/props_c17/shelfunit01a.mdl
	-- models/props_wasteland/kitchen_shelf001a.mdl
	-- models/props_c17/display_cooler01a.mdl
	-- 