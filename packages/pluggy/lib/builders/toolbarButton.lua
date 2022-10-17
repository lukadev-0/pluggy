local Types = require(script.Parent.Parent.Types)

--[=[
	@class ToolbarButtonBuilder
]=]
local ToolbarButtonBuilder = {}
local META = { __index = ToolbarButtonBuilder }

--[=[
	@within ToolbarButtonBuilder
	@return ToolbarButtonBuilder
]=]
function ToolbarButtonBuilder:label(label: string)
	self._data.label = label
	return self
end

--[=[
	@within ToolbarButtonBuilder
	@return ToolbarButtonBuilder
	@param icon ToolbarButtonIcon
]=]
function ToolbarButtonBuilder:icon(icon: Types.ToolbarButtonIcon)
	self._data.icon = icon
	return self
end

--[=[
	@within ToolbarButtonBuilder
	@return ToolbarButtonBuilder
]=]
function ToolbarButtonBuilder:tooltip(tooltip: string)
	self._data.tooltip = tooltip
	return self
end

--[=[
	@within ToolbarButtonBuilder
	@return ToolbarButtonBuilder
]=]
function ToolbarButtonBuilder:clickableWhenViewportHidden(clickableWhenViewportHidden: boolean)
	self._data.clickableWhenViewportHidden = clickableWhenViewportHidden
	return self
end

function ToolbarButtonBuilder:_build(id: string, toolbar: Types.Toolbar)
	toolbar:createButton(id, self._data)
end

local function createToolbarButtonBuilder()
	local self = { _data = {} }
	return setmetatable(self, META) :: Types.ToolbarButtonBuilder
end

return createToolbarButtonBuilder
