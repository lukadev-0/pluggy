local Types = require(script.Parent.Types)

local createToolbarBuilder = require(script.toolbar)
local createToolbarButtonBuilder = require(script.toolbarButton)

--[=[
	@class Builders
]=]
local Builders = {}

--[=[
	@type Builder ToolbarBuilder | ToolbarButtonBuilder
	@within Builders
]=]

local META = {
	__index = function(t, k)
		local v = Builders[k]
		if typeof(v) == "function" then
			return v(t)
		end
	end,
}

--[=[
	@prop toolbar ToolbarBuilder
	@within Builders
]=]
function Builders:toolbar()
	return createToolbarBuilder()
end

--[=[
	@prop button ToolbarButtonBuilder
	@within Builders
]=]
function Builders:button()
	return createToolbarButtonBuilder()
end

return setmetatable({}, META) :: Types.Builders
