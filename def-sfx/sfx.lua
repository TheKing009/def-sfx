local sound_helper = require "game.modules.sfx_helper"
local class = require "game.modules.class"

local M = class:extend()

--to be populated as more sounds are added
local sounds = {}

sounds[hash("tv")] = {name = "tv", is_playing = false}

function M:init()
	self.sounds_2D = {}
	self.sounds_pan = {}
end

function M.play(id)
	print(id, sounds[id].is_playing)
	if sounds[id].is_playing then
		return
	end
	
	local name = sounds[id].name
	sounds[id].is_playing = true	
	sound.play("controller:/sfx#"..name, {}, function()
		sounds[id].is_playing = false
	end)
end


function M:update_pan()
	for _, v in pairs(self.sounds_pan) do
		local id = v.id
		if sounds[id].is_playing then
			local name = sounds[id].name
			local source = go.get_position(v.source)
			local listener = go.get_position(v.listener)
			local deadzone = v.pan_range

			local pan = sound_helper.calculate_pan(source, listener, deadzone)
			sound.set_pan("controller:/sfx#"..name, pan)
		end
	end
end

function M:update_gain_2D()
	for _, v in pairs(self.sounds_2D) do
		local id = v.id
		if sounds[id].is_playing then
			local name = sounds[id].name
			local source = go.get_position(v.source)
			local listener = go.get_position(v.listener)
			local deadzone = v.range_2D
			local gain = v.gain

			gain = gain * sound_helper.calculate_gain_2D(source, listener, deadzone)
			sound.set_gain("controller:/sfx#"..name, gain)
		end
	end
end

function M:stop_all()
	for _, v in pairs(sounds) do
		local name = v.name
		sound.stop("controller:/sfx#"..name)
	end
end

function M:register(properties)
	local pan = properties.pan
	local is_2D = properties.is_2D

	if pan then table.insert(self.sounds_pan, properties) end
	if is_2D then table.insert(self.sounds_2D, properties) end
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