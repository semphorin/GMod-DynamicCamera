local cvar_viewroll = CreateClientConVar("cl_dv_viewroll", 1, true, false)
local cvar_jumppitch = CreateClientConVar("cl_dv_jumppitch", 1, true, false)

-- dynamic view
--[[
function ViewRolling(ply, pos, angles, fov)
	if !cvar_viewroll:GetBool() or !ply:IsValid() or !ply:Alive() or ply:InVehicle() or ply:ShouldDrawLocalPlayer() then
		return
	end
	
	--local var2 = ply:GetVelocity():Dot(ply:EyeAngles():Right())
	local lookvector = ply:EyeAngles():Right():Angle()
	local speed = ply:GetVelocity():Dot(ply:EyeAngles():Right())
	local ang = math.Clamp((speed * -10 / 300), -5, 5)

	angles.r = angles.r + ang
	local view = 
	{
		origin = pos,
		angles = angles,
		fov = fov
	}
	--return view
	--this breaks other addons, notably mw2019 sweps
end
]]--

function Roll2(cmd, x, y, angles)
	local speed = LocalPlayer():GetVelocity():Dot(angles:Right())
	local ang = math.Clamp((speed * -5 / 300), -3, 3)

	angles.r = ang
	cmd:SetViewAngles(angles)
end


function JumpPitching(ply, orig, angles, fov)
	if !cvar_jumppitch:GetBool() or !ply:IsValid() or !ply:Alive() or ply:InVehicle() or ply:ShouldDrawLocalPlayer() then
		return
	end
	
	local x = ply:GetVelocity()
	local final = math.Clamp((x.z / 150), -3, 3)
	
	--x.y is not vertical velocity
	
	if x.z != 0 then
		angles.p = angles.p + final
	end
	
	local view = {
		origin = orig,
		angles = angles,
		fov = fov
	}
	

end

hook.Add("InputMouseApply", "Roll2", Roll2)
--hook.Add("CalcView", "ViewRolling", ViewRolling)
hook.Add("CalcView", "JumpPitching", JumpPitching)
