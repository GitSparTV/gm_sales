include("shared.lua")

function GM:Initialize()
end

function GM:InitPostEntity()
end

function GM:Think()
end

function GM:HUDPaint()
end

function GM:HUDPaintBackground()
end

function GM:PostDrawOpaqueRenderables()
	local cart = LocalPlayer().Cart
	if not IsValid(cart) then return end
	render.DrawLine(cart:GetPos(),cart:GetPos() + cart:GetVelocity(),color_white)
	render.DrawLine(cart:GetPos(),cart:GetPos() + cart:GetForward() * 50,Color(255,0,0))
end

-- function GM:Move() return true end

do
	local Hide = {
		CHudAmmo = true,
		CHudBattery = true,
		CHudCrosshair = true,
		CHudDamageIndicator = true,
		CHudHealth = true,
		CHudSecondaryAmmo = true
	}

	function GM:HUDShouldDraw(name)
		return not Hide[name]
	end
end

do
	local Color1, Color2, Color3, chatAddText = Color(255, 255, 255), Color(255, 30, 40), Color(30, 160, 40), chat.AddText

	function GM:OnPlayerChat(player, strText, bTeamOnly, bPlayerIsDead)
		local tab, len = {}, 1

		if bPlayerIsDead then
			tab[1] = Color2
			tab[2] = "*DEAD* "
			len = 3
		end

		if bTeamOnly then
			tab[len] = Color3
			tab[len + 1] = "(TEAM) "
			len = len + 2
		end

		if player:IsValid() then
			tab[len] = player
		else
			tab[len] = "Console"
		end

		len = len + 1
		tab[len] = Color1
		tab[len + 1] = ": "
		tab[len + 2] = strText
		chatAddText(tab[1], tab[2], tab[3], tab[4], tab[5], tab[6], tab[7], tab[8])

		return true
	end
end