local sound_helper = require "def-sfx.sfx_helper"
local class = require "def-sfx.dependencies.class"

local M = class:extend()

local sounds = {}

function M:init(target)
	self.sounds_2D = {}
	self.sounds_pan = {}
	self.target = target
end

function M.play(id)
	if sounds[id].is_playing then
		return
	end
	
	local path = sounds[id].path
	sounds[id].is_playing = true	
	sound.play(path, {gain = sounds[id].gain}, function()
		sounds[id].is_playing = false
	end)
end


function M:update_pan()
	for _, v in pairs(self.sounds_pan) do
		local id = v.id
		if sounds[id].is_playing then
			local source = go.get_position(v.source)
			local listener = go.get_position(self.target)
			local deadzone = v.pan_range
		
			local pan = sound_helper.calculate_pan(source, listener, deadzone)
			sound.set_pan(sounds[id].path, pan)
		end
	end
end

function M:update_gain_2D()
	for _, v in pairs(self.sounds_2D) do
		local id = v.id
		if sounds[id].is_playing then
			local source = go.get_position(v.source)
			local listener = go.get_position(self.target)
			local deadzone = v.range_2D
			local gain = v.gain

			gain = gain * sound_helper.calculate_gain_2D(source, listener, deadzone)
			sound.set_gain(sounds[id].path, gain)
		end
	end
end

function M:stop_all()
	for _, v in pairs(sounds) do
		sound.stop(v.path)
	end
end

function M:register(properties)
	local pan = properties.pan
	local is_2D = properties.is_2D

	if pan then table.insert(self.sounds_pan, properties) end
	if is_2D then table.insert(self.sounds_2D, properties) end

	sounds[properties.id] = {
		is_playing = false,
		path = properties.path,
		gain = properties.gain
	}
end

function M:unregister(id)
	for k, v in pairs(self.sounds_pan) do
		if v.go_id == id then
			table.remove(self.sounds_pan, k)
		end
	end

	for k, v in pairs(self.sounds_2D) do
		if v.go_id == id then
			table.remove(self.sounds_2D, k)
		end
	end
end

return M
