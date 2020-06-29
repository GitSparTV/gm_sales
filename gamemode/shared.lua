GM.Name = "Sales"
GM.Author = "Spar"
GM.Email = "Spar#6665"
GM.TeamBased = true

function GM:PlayerConnect(name, address)
end

function GM:PropBreak(attacker, prop)
end

function GM:EntityRemoved(ent)
end

function GM:Tick()
end

function GM:OnEntityCreated(Ent)
end

function GM:EntityKeyValue(ent, key, value)
end

function GM:CreateTeams()
	TEAM_BLUE = 1
	team.SetUp(TEAM_BLUE, "Blue Team", Color(0, 0, 255))
	team.SetSpawnPoint(TEAM_BLUE, "ai_hint") -- <-- This would be info_terrorist or some entity that is in your map
	TEAM_ORANGE = 2
	team.SetUp(TEAM_ORANGE, "Orange Team", Color(255, 150, 0))
	team.SetSpawnPoint(TEAM_ORANGE, "sky_camera") -- <-- This would be info_terrorist or some entity that is in your map
	TEAM_SEXY = 3
	team.SetUp(TEAM_SEXY, "Sexy Team", Color(255, 150, 150))
	team.SetSpawnPoint(TEAM_SEXY, "info_player_start") -- <-- This would be info_terrorist or some entity that is in your map
	team.SetSpawnPoint(TEAM_SPECTATOR, "worldspawn")
end

function GM:Move(ply)
	-- if CLIENT and ply.Cart and ply.Cart:IsValid() then
	-- 	if ply:KeyDown(IN_MOVERIGHT) then
	-- 		ply.Cart:SetNetworkAngles(ply.Cart:GetNetworkAngles() - Angle(0, 2, -ply.Cart:GetVelocity():Length() / 1200))
	-- 	elseif ply:KeyDown(IN_MOVELEFT) then
	-- 		ply.Cart:SetNetworkAngles(ply.Cart:GetNetworkAngles() + Angle(0, 2, -ply.Cart:GetVelocity():Length() / 1200))
	-- 	end
	-- end

	-- return true
end

function GM:CalcView( ply, origin, angles, fov, znear, zfar )
	-- if ply.Cart and ply.Cart:IsValid() then
	-- 	local view = {}
	-- 	view.origin = ply.Cart:LocalToWorld(Vector(-60, 0, 40))
	-- 	view.angles = angles
	-- 	view.fov = fov
	-- 	view.drawviewer = false

	-- 	return view
	-- end
end

function GM:SetupMove(ply, mv, cmd)
	if ply.Cart and ply.Cart:IsValid() then
		if SERVER then
			ply.Cart:PhysWake()
			mv:SetOrigin(ply.Cart:LocalToWorld(Vector(-60, 0, -15)))
		elseif not IsFirstTimePredicted() then
			ply:SetEyeAngles(LerpAngle(0.1, ply:EyeAngles(), ply.Cart:GetNetworkAngles()))
		end

		if CLIENT then
			-- mv:SetOrigin(LocalToWorld(Vector(-60, 0, -15), angle_zero, ply.Cart:GetNetworkOrigin(), ply.Cart:GetNetworkAngles()))
		end

		-- mv:SetVelocity(ply.Cart:GetAbsVelocity())
		-- mv:SetMoveAngles(ply:EyeAngles())
		-- mv:SetAngles()
		cmd:SetButtons(0)
		cmd:ClearMovement()
		cmd:ClearButtons()
	end
end

function GM:FinishMove(ply, mv)
	-- if ( drive.FinishMove( ply, mv ) ) then return true end
end

function GM:PlayerPostThink(ply)
end

function GM:OnReloaded()
end

function GM:PreGamemodeLoaded()
end

function GM:OnGamemodeLoaded()
end

function GM:PostGamemodeLoaded()
end