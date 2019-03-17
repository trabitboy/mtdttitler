--multiline support (add line on enter)
-- when softcompose mix new color with old color !

--typo width height
tw=80
th=200

--util
function tbllngth(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

require("lines")
require("loadfilter")
require("picbutton")
-- require("ta")
require("tbox")


softcomposed= love.image.newImageData( 1920, 1080 )

require("softcompose")



wcount=0


	-- text="ADEHL MNLOP"
	-- text="ADEHLMNLOP"

	addtline("ADEHLMNLOP")
	
	--they intercept mouse and keyboard events
	widgets={}



		function addbox()
			print("crotte")
			-- addtline("LOP")
			table.insert(widgets,createtbox(100,100,100,100))
			
		end


	
	function love.load()
	
		savefld=love.filesystem.getSaveDirectory()
	
		
	
		typo={}
		typo['A']=loadfilter("TYPO/A.png")
		typo['B']=loadfilter("TYPO/B.png")
		typo['C']=loadfilter("TYPO/C.png")
		typo['D']=loadfilter("TYPO/D.png")
		typo['E']=loadfilter("TYPO/E.png")
		typo['F']=loadfilter("TYPO/F.png")
		typo['G']=loadfilter("TYPO/G.png")
		typo['H']=loadfilter("TYPO/H.png")
		typo['I']=loadfilter("TYPO/I.png")
		typo['J']=loadfilter("TYPO/J.png")
		typo['K']=loadfilter("TYPO/K.png")
		typo['L']=loadfilter("TYPO/L.png")
		typo['M']=loadfilter("TYPO/M.png")
		typo['N']=loadfilter("TYPO/N.png")
		typo['O']=loadfilter("TYPO/O.png")
		typo['P']=loadfilter("TYPO/P.png")
		typo['Q']=loadfilter("TYPO/Q.png")
		typo['R']=loadfilter("TYPO/R.png")
		typo['S']=loadfilter("TYPO/S.png")
		typo['T']=loadfilter("TYPO/T.png")
		typo['U']=loadfilter("TYPO/U.png")
		typo['V']=loadfilter("TYPO/V.png")
		typo['W']=loadfilter("TYPO/W.png")
		typo['X']=loadfilter("TYPO/X.png")
		typo['Y']=loadfilter("TYPO/Y.png")
		typo['Z']=loadfilter("TYPO/Z.png")
		
		--create our widgets
		plus=createpicbutton(0,0,"bplus.png",addbox )
		table.insert(widgets,plus)
		
	end

	

	
	
npress=false
npx=nil
npy=nil	
	
	
love.mousepressed = function(x, y, button)
	print("mousepressed "..x.." "..y)
	npress=true
	npx=x
	npy=y
	
end

love.mousemoved=function( x, y, dx, dy, istouch )
	if registerdrag~=nil then
			registerdrag.drag(registerdrag,dx,dy)
	end
end

love.mousereleased = function(x, y, button)

	registerdrag=nil
end

love.wheelmoved = function(x, y)
end

love.keypressed = function(key, code, isrepeat)
		-- if key == 'return'then -- binding enter key to input focus
	if boxfocus~=nil and ( key=='return' or key=='backspace' or key=='left' or key=='right' or key=='up' or key=='down'  ) then
		print(key)
		boxfocus.editkey(boxfocus,key)
	end
end

	
love.textinput = function(key)

	print(key)
	if boxfocus~=nil then
		boxfocus.addtext(boxfocus,key)
	end

end
	

function love.update(dt)
	if love.keyboard.isDown("escape") then
		to_save=love.graphics.captureScreenshot("screenshot.png")
		-- to_save:encode("png","test.png")
		-- softcompose(softcomposed,typo["A"].data,0,0)
		composescreen(softcomposed,lines,0,0)
		softcomposed:encode("png","softcomposed.png")
		love.event.quit()
	end

	--mouseclick
	if npress==true then
		print("propagating np")
		for i,w in ipairs (widgets)
		do
			ret=w.click(w,npx,npy)
			if ret==true then
				npress=false
				break
			end

		end
		
		
		print("np in void")
		npress=false
	end
	
end
	
	
elapsed=false
	
function love.draw()
	
	if elapsed ==false then
		love.graphics.captureScreenshot("dbg.png")
		elapsed=true
	end
	
	for i,w in ipairs( widgets)
	do
		w.render(w)
	
	end
	
	-- rendertitling()
	-- for j,line in ipairs(lines)
	-- do
		-- -- print(line)
		-- x=0
		-- for i = 1, #line do
			-- local c = line:sub(i,i)
			-- -- do something with c
			-- love.graphics.draw(typo[c].pic,x,0)
			-- x=x+40
		-- end
	
	-- end
	-- love.graphics.print(savefld,0,200)
end
	
	
	
	
	