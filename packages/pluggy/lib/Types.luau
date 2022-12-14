--!strict

-- Pluggy
export type Pluggy = {
	globals: { [any]: any },
	plugin: Plugin,
	toolbars: { [string]: Toolbar },
	start: (pluggy: Pluggy) -> (),
	createToolbar: (self: Pluggy, id: string, name: string) -> Toolbar,
	load: (self: Pluggy, plugin: Plugin) -> (),
	build: (self: Pluggy, builders: { [string]: RootBuilder }) -> (),
}

export type PluggyOptions<TGlobals> = {
	name: string,
	globals: TGlobals?,
	start: (pluggy: Pluggy) -> (),
}

-- Toolbar
export type Toolbar = {
	pluggy: Pluggy,
	instance: PluginToolbar,
	buttons: { [string]: ToolbarButton },
	createButton: (self: Toolbar, id: string, options: ToolbarButtonOptions) -> ToolbarButton,
}

-- ToolbarButton
export type ToolbarButton = {
	toolbar: Toolbar,
	icon: ToolbarButtonIcon,
	id: string,
	setIcon: (self: ToolbarButton, icon: ToolbarButtonIcon) -> (),
	instance: PluginToolbarButton,
}

export type ToolbarButtonOptions = {
	label: string,
	icon: ToolbarButtonIcon,
	tooltip: string,
	clickableWhenViewportHidden: boolean,
}

export type ToolbarButtonIcon = string | { light: string, dark: string }

-- Builder Types
export type Builder = ToolbarBuilder | ToolbarButtonBuilder
export type RootBuilder = ToolbarBuilder

export type Builders = {
	toolbar: ToolbarBuilder,
	button: ToolbarButtonBuilder,
}

export type ToolbarBuilder = {
	name: (self: ToolbarBuilder, name: string) -> ToolbarBuilder,
	button: (self: ToolbarBuilder, id: string, button: ToolbarButtonBuilder) -> ToolbarBuilder,
	buttons: (self: ToolbarBuilder, buttons: { [string]: ToolbarButtonBuilder }) -> ToolbarBuilder,
}

export type ToolbarButtonBuilder = {
	label: (self: ToolbarButtonBuilder, label: string) -> ToolbarButtonBuilder,
	icon: (self: ToolbarButtonBuilder, icon: ToolbarButtonIcon) -> ToolbarButtonBuilder,
	tooltip: (self: ToolbarButtonBuilder, tooltip: string) -> ToolbarButtonBuilder,
	clickableWhenViewportHidden: (self: ToolbarButtonBuilder) -> ToolbarButtonBuilder,
}

return nil
