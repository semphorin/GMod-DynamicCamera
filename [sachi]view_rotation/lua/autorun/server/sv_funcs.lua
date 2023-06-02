function OnLand(player, inWater, onFloater, speed)
	
	player:ViewPunch(Angle(math.Clamp(speed/100, -5, 5), 0, math.random(-.1, .1)))
	
end

hook.Add("OnPlayerHitGround", "OnLand", OnLand)
