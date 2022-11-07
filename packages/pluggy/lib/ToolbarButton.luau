local Types = require(script.Parent.Types)

--[=[
	@class ToolbarButton

	A button which is contained inside of a [Toolbar].

	Wraps [PluginToolbarButton]
]=]
local ToolbarButton = {}
ToolbarButton.__index = ToolbarButton

--[=[
	@type ToolbarButtonIcon string | { light: string, dark: string }
	@within ToolbarButton
]=]

--[=[
	@interface ToolbarButtonOptions
	@within ToolbarButton

	.label   string
	.icon    ToolbarButtonIcon
	.tooltip string
]=]

--[=[
	@prop id string
	@within ToolbarButton
	@readonly
]=]

--[=[
	@prop toolbar Toolbar
	@within ToolbarButton
	@readonly
]=]

--[=[
	@prop icon ToolbarButtonIcon
	@within ToolbarButton
	@readonly
]=]

--[=[
	@prop instance PluginToolbarButton
	@within ToolbarButton
	@readonly
]=]

--[=[
	:::note
	This function should not be called manually,
	use [Toolbar:button] instead.
	:::

	@param toolbar Toolbar
	@param options ToolbarButtonOptions
	@return ToolbarButton
]=]
function ToolbarButton.new(id: string, toolbar: Types.Toolbar, options: Types.ToolbarButtonOptions): Types.ToolbarButton
	local self = {
		id = id,
		toolbar = toolbar,
	}

	setmetatable(self, ToolbarButton)

	self:setIcon(options.icon)
	self.instance = toolbar.instance:CreateButton(id, options.tooltip, self._iconId, options.label)
	self.instance.ClickableWhenViewportHidden = options.clickableWhenViewportHidden or false

	return (self :: any) :: Types.ToolbarButton
end

--[=[
	@param icon ToolbarButtonIcon
]=]
function ToolbarButton:setIcon(icon: Types.ToolbarButtonIcon)
	self.icon = icon

	if self._themeChangeConnection then
		self._themeChangeConnection:Disconnect()
	end

	if typeof(icon) == "string" then
		self._iconId = icon
	elseif typeof(icon) == "table" then
		local Studio = settings():GetService("Studio")

		local function updateIcon()
			self._iconId = if Studio.Theme.Name == "Dark" then icon.dark else icon.light

			if self.instance then
				self.instance.Icon = self._iconId
			end
		end

		self._themeChangeConnection = Studio.ThemeChanged:Connect(updateIcon)
		updateIcon()
	else
		error("Icon should be string or table")
	end
end

return ToolbarButton
