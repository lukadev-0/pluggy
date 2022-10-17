--!strict

local Types = require(script.Types)
local createBuilders = require(script.builders)

export type PluggyOptions<TGlobals> = Types.PluggyOptions<TGlobals>
export type ToolbarButtonIcon = Types.ToolbarButtonIcon
export type ToolbarButtonOptions = Types.ToolbarButtonOptions
export type Pluggy = Types.Pluggy
export type Toolbar = Types.Toolbar
export type ToolbarButton = Types.ToolbarButton

export type Builder = Types.Builder
export type Builders = Types.Builders
export type ToolbarBuilder = Types.ToolbarBuilder
export type ToolbarButtonBuilder = Types.ToolbarButtonBuilder

--[=[
	@class Pluggy

	Roblox plugin wrapper library.
]=]
local Pluggy = {}
Pluggy.__index = Pluggy

Pluggy.Toolbar = require(script.Toolbar)
Pluggy.ToolbarButton = require(script.ToolbarButton)

--[=[
	@interface PluggyOptions
	@within Pluggy

	.name    string         -- The name of the plugin
	.globals table          -- A table of globals which can be accessed via [Pluggy.globals]
	.start   (Pluggy) -> () -- Function that starts the plugin
]=]

--[=[
	@prop globals table
	@within Pluggy

	A table of globals which can be used to store anything that
	needs to be accessed in different places.
]=]

--[=[
	@prop plugin Plugin
	@within Pluggy

	A table of globals which can be used to store anything that
	needs to be accessed in different places.

	@readonly
]=]

--[=[
	@prop toolbars { [string]: Toolbar }
	@within Pluggy

	A table of toolbars which have been created,
	see [Pluggy:toolbar].

	@readonly
]=]

--[=[
	@method start
	@within Pluggy

	:::note
	This function should not be called manually,
	but should be called using [Pluggy.load] or through
	the debugger.
	:::

	Function that starts the plugin.
]=]

--[=[
	Constructs a new Pluggy plugin

	@param options PluggyOptions
	@return Pluggy
]=]
function Pluggy.new<TGlobals>(options: Types.PluggyOptions<TGlobals>): Types.Pluggy
	local self = {
		name = options.name,
		globals = options.globals or {},
		start = options.start,
		toolbars = {},
	}

	setmetatable(self, Pluggy)

	self.builders = createBuilders(self)

	return self :: Types.Pluggy
end

--[=[
	Creates a toolbar.

	@return Toolbar
]=]
function Pluggy:createToolbar(id: string, name: string)
	if self.toolbars[id] then
		error(("A toolbar with id '%s' already exists"):format(id))
	end

	local toolbar = Pluggy.Toolbar.new(self, name)
	self.toolbars[id] = toolbar

	return toolbar
end

function Pluggy:load(plugin: Plugin)
	self.plugin = plugin
	self:start()
end

return Pluggy
