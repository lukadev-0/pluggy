local Types = require(script.Parent.Types)
local ToolbarButton = require(script.Parent.ToolbarButton)

--[=[
	@class Toolbar

	A plugin toolbar which contains buttons.

	Wraps [PluginToolbar]
]=]
local Toolbar = {}
Toolbar.__index = Toolbar

--[=[
	@prop pluggy Pluggy
	@within Toolbar
	@readonly
]=]

--[=[
	@prop buttons { [string]: ToolbarButton }
	@within Toolbar
	@readonly
]=]

--[=[
	@prop instance PluginToolbar
	@within Toolbar
	@readonly
]=]

--[=[
	:::note
	This function should not be called manually,
	use [Pluggy:toolbar] instead.
	:::

	@param pluggy Pluggy
	@return Toolbar
]=]
function Toolbar.new(pluggy: Types.Pluggy, name: string): Types.Toolbar
	local self = {
		pluggy = pluggy,
		buttons = {},
		instance = pluggy.plugin:CreateToolbar(name),
	}

	setmetatable(self, Toolbar)

	return (self :: any) :: Types.Toolbar
end

--[=[
	Creates a button.

	@param options ToolbarButtonOptions
	@return ToolbarButton
]=]
function Toolbar:createButton(id: string, options: Types.ToolbarButtonOptions)
	if self.buttons[id] then
		error(("A button with id '%s' already exists."):format(id))
	end

	local button = ToolbarButton.new(id, self, options)
	self.buttons[id] = button

	return button
end

return Toolbar
