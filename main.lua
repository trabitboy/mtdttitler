--multiline support (add line on enter)
-- when softcompose mix new color with old color !

--typo width height
tw=80
th=200


require("lines")
require("loadfilter")

gui = require('Gspot') -- import the library


--gspot
local DIV = love._version_major >= 11 and 1/255 or 1

font = love.graphics.newFont(192)

softcomposed= love.image.newImageData( 1920, 1080 )

require("softcompose")


	-- text="ADEHL MNLOP"
	-- text="ADEHLMNLOP"

	addtline("ADEHLMNLOP")
	
	function love.load()
	
		love.graphics.setFont(font)
		-- love.graphics.setColor(255 * DIV, 192 * DIV, 0 * DIV, 128 * DIV) -- just setting these so we know the gui isn't stealing our thunder

		-- sometext = 'Lörem ipsum dolor sït amet, consectètur adipisicing élit, sed do eiusmod tempoŕ incididunt ut labore et dọlorẹ magna aliquæ.'

		-- local textout = gui:typetext(sometext, {y = 32, w = 128})

		-- button
		local button = gui:button('A Button', {x = 128, y = gui.style.unit, w = 128, h = gui.style.unit}) -- a button(label, pos, optional parent) gui.style.unit is a standard gui unit (default 16), used to keep the interface tidy
		button.click = function(this, x, y) -- set element:click() to make it respond to gui's click event
			-- text=text.."A"
			gui:feedback('Clicky')
		end
	
	-- text input
	input = gui:input('Chat', {64, love.graphics.getHeight() - 32, 256, 2*gui.style.unit})
	input.keyrepeat = true -- this is the default anyway
	input.done = function(this) -- Gspot calls element:done() when you hit enter while element has focus. override this behaviour with element.done = false
		gui:feedback('line added : '..this.value)
		addtline(this.value)
		this.value = ''
		this.Gspot:unfocus()
	end
	button = gui:button('Speak', {input.pos.w + gui.style.unit, 0, 64, gui.style.unit}, input) -- attach a button
	button.click = function(this)
		this.parent:done()
	end
	
	
		pic=loadfilter("left1.png")
		typo={}
		typo['A']=loadfilter("TYPO/A.png")
		typo['D']=loadfilter("TYPO/D.png")
		typo['E']=loadfilter("TYPO/E.png")
		typo['H']=loadfilter("TYPO/H.png")
		typo['L']=loadfilter("TYPO/L.png")
		typo['M']=loadfilter("TYPO/M.png")
		typo['N']=loadfilter("TYPO/N.png")
		typo['L']=loadfilter("TYPO/L.png")
		typo['O']=loadfilter("TYPO/O.png")
		typo['P']=loadfilter("TYPO/P.png")
	end

	
	
	love.textinput = function(key)
		if gui.focus then
			gui:textinput(key) -- only sending input to the gui if we're not using it for something else
		end
	end

	-- deal with 0.10 mouse API changes
love.mousepressed = function(x, y, button)
	gui:mousepress(x, y, button) -- pretty sure you want to register mouse events
end
love.mousereleased = function(x, y, button)
	gui:mouserelease(x, y, button)
end
love.wheelmoved = function(x, y)
	gui:mousewheel(x, y)
end

love.keypressed = function(key, code, isrepeat)
	if gui.focus then
		gui:keypress(key) -- only sending input to the gui if we're not using it for something else
	else
		if key == 'return'then -- binding enter key to input focus
			input:focus()
		elseif key == 'f1' then -- toggle show-hider
			if showhider.display then showhider:hide() else showhider:show() end
		else
			gui:feedback(key) -- why not
		end
	end
end

	
	
	function love.update(dt)
		if love.keyboard.isDown("space") then
			to_save=love.graphics.captureScreenshot("test.png")
			-- to_save:encode("png","test.png")
			-- softcompose(softcomposed,typo["A"].data,0,0)
			composescreen(softcomposed,lines,0,0)
			softcomposed:encode("png","softcomposed.png")
			love.event.quit()
		end
			gui:update(dt)

	end
	
    function love.draw()
		
	
		-- love.graphics.print("Hello World!", 400, 300)
		-- love.graphics.draw(pic.pic,0,0)
		-- love.graphics.draw(typo.A.pic,0,0)
		
		
		for j,line in ipairs(lines)
		do
			print(line)
			x=0
			for i = 1, #line do
				local c = line:sub(i,i)
				-- do something with c
				love.graphics.draw(typo[c].pic,x,0)
				x=x+40
			end
		
		end
		gui:draw()
    end
	
	
	
	
	