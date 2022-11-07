local Types = require(script.Parent.Parent.Types)

--[=[
	@class ToolbarBuilder
]=]
local ToolbarBuilder = {}
local META = { __index = ToolbarBuilder }

--[=[
	@within ToolbarBuilder
	@return ToolbarBuilder
]=]
function ToolbarBuilder:name(name: string)
	self._data.name = name
	return self
end

--[=[
	@within ToolbarBuilder
	@return ToolbarBuilder
	@param button ToolbarButtonBuilder
]=]
function ToolbarBuilder:button(id: string, button: Types.ToolbarButtonBuilder)
	self._buttons[id] = button
	return self
end

--[=[
	@within ToolbarBuilder
	@return ToolbarBuilder
	@param buttons { [string]: ToolbarButtonBuilder }
]=]
function ToolbarBuilder:buttons(buttons: { [string]: Types.ToolbarButtonBuilder })
	for id, button in buttons do
		self:button(id, button)
	end
	return self
end

function ToolbarBuilder:_build(id: string, pluggy: Types.Pluggy)
	local toolbar = pluggy:createToolbar(id, self._data.name)
	for buttonId, button in self._buttons do
		button:_build(buttonId, toolbar)
	end
end

local function createToolbarBuilder()
	local self = { _buttons = {}, _data = {} }
	return setmetatable(self, META) :: Types.ToolbarBuilder
end

return createToolbarBuilder
