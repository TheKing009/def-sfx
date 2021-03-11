local M = {}

function M.calculate_pan(source, listener, deadzone)
	local dir = source - listener
	local distance = vmath.length(dir)
	
	dir = vmath.normalize(dir)
	
	local dot = vmath.dot(dir, vmath.vector3(1, 0, 0))
	local pan = 0

	if distance < deadzone then
		pan = distance / deadzone
	else
		pan = 1
	end

	pan = pan * (math.abs(dot) / dot)
	
	return pan
end

function M.calculate_gain_2D(source, listener, deadzone)
	local distance = vmath.length(source - listener)
	local gain = 1
	if distance < deadzone then
		gain = 1 - distance / deadzone
	else
		gain = 0
	end
	return gain
end

return M
