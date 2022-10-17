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

--[=[
	@within Builders
	@param builders { [string]: Builder }
]=]
local function build(builders: { [string]: Types.RootBuilder })
	for id, builder in builders do
		builder:_build(id)
	end
end

local META = {
	__index = function(t, k)
		if k == "build" then
			return build
		end

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
	return createToolbarBuilder(self._pluggy)
end

--[=[
	@prop button ToolbarButtonBuilder
	@within Builders
]=]
function Builders:button()
	return createToolbarButtonBuilder()
end

local function createBuilders(pluggy: Types.Pluggy)
	local self = { _pluggy = pluggy }
	return setmetatable(self, META) :: Types.Builders
end

return createBuilders
