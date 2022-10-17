local Pluggy = require(script.Parent.Packages.Pluggy)

return Pluggy.new({
	name = "Example",
	start = function(pluggy: Pluggy.Pluggy)
		local p = pluggy.builders

		-- stylua: ignore
		p.build({
			myToolbar = p.toolbar
				:name("My Toolbar")
				:buttons({
					myButton = p.button
						:label("My Button")
						:icon("rbxassetid://0")
						:tooltip("This is a tooltip"),

					alwaysClickableButton = p.button
						:label("Always Clickable")
						:icon("rbxassetid://0")
						:tooltip("This button is always clickable")
						:clickableWhenViewportHidden(),
				}),
		})
	end,
})
