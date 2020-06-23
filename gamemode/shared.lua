GM.Name			= "Sales"
GM.Author		= "Spar"
GM.Email		= "Spar#6665"
GM.TeamBased	= true

function GM:PlayerConnect( name, address )
	print("PlayerConnect")
end

function GM:PropBreak( attacker, prop )
end

function GM:EntityRemoved( ent )
	print("EntityRemoved")
end

function GM:Tick()
end

function GM:OnEntityCreated( Ent )
	if Ent:GetClass() == "sales_cart" then CART = Ent end
end

function GM:EntityKeyValue( ent, key, value )
end

function GM:CreateTeams()
	TEAM_BLUE = 1
	team.SetUp( TEAM_BLUE, "Blue Team", Color( 0, 0, 255 ) )
	team.SetSpawnPoint( TEAM_BLUE, "ai_hint" ) -- <-- This would be info_terrorist or some entity that is in your map

	TEAM_ORANGE = 2
	team.SetUp( TEAM_ORANGE, "Orange Team", Color( 255, 150, 0 ) )
	team.SetSpawnPoint( TEAM_ORANGE, "sky_camera" ) -- <-- This would be info_terrorist or some entity that is in your map

	TEAM_SEXY = 3
	team.SetUp( TEAM_SEXY, "Sexy Team", Color( 255, 150, 150 ) )
	team.SetSpawnPoint( TEAM_SEXY, "info_player_start" ) -- <-- This would be info_terrorist or some entity that is in your map

	team.SetSpawnPoint( TEAM_SPECTATOR, "worldspawn" )

end

function GM:Move( ply, mv )

	-- if ( drive.Move( ply, mv ) ) then return true end

end

function GM:SetupMove( ply, mv, cmd )

	-- if ( drive.StartMove( ply, mv, cmd ) ) then return true end

end

function GM:FinishMove( ply, mv )

	-- if ( drive.FinishMove( ply, mv ) ) then return true end

end

function GM:PlayerPostThink( ply )

end

function GM:OnReloaded()
end

function GM:PreGamemodeLoaded()
end

function GM:OnGamemodeLoaded()
end

function GM:PostGamemodeLoaded()
end