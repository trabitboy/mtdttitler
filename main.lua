--multiline support (add line on enter)
-- when softcompose mix new color with old color !

cvsw=800
cvsh=600
 love.window.setMode(cvsw,cvsh)
 love.window.setTitle("mtdt titler")
	mylt=love.graphics.newCanvas(cvsw,cvsh)

--typo width height (pic size)
tw=80
th=200
--meaninful area in the middle (to trim empty space)
rtw=(tw/2)



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
require("slider")
require("cprlfl")


-- test=splitwordandspace("caca pipi zaz prout ")
-- for i,s in ipairs (test)
-- do
	-- print ('#'..s.val..'#')
-- end

-- test=simplecprlfl(5,"caca pipi zaz prout ")
-- for i,l in ipairs (test)
-- do
	-- print('> line begin')
	-- for j,s in ipairs (l)
	-- do
		-- print ('#'..s.val..'#')
	-- end
	-- print('> line end')
-- end


-- love.event.quit()


-- softcomposed= love.image.newImageData( 1920, 1080 )

require("softcompose")



wcount=0


	-- text="ADEHL MNLOP"
	-- text="ADEHLMNLOP"

	addtline("ADEHLMNLOP")
	
	--they intercept mouse and keyboard events
	widgets={}



		function addbox()
			-- print("crotte")
			-- addtline("LOP")
			table.insert(widgets,createtbox(100,100,100,100))
			
		end


		function setjustifleft()
			if boxfocus~=nil then
				boxfocus.justif=jleft
			end
		end
		
		
		function setjustifright()
			if boxfocus~=nil then
				boxfocus.justif=jright
			end
		end
		
		
		function setjustifcenter()
			if boxfocus~=nil then
				boxfocus.justif=jcenter
			end
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
		typo['unknown']=loadfilter("TYPO/unknown.png")
		
		--create our widgets
		plus=createpicbutton(0,0,"bplus.png",addbox )
		table.insert(widgets,plus)

		plus=createpicbutton(0,cvsh-150,"jl.png",setjustifleft )
		table.insert(widgets,plus)

		plus=createpicbutton(0,cvsh-100,"jr.png",setjustifright )
		table.insert(widgets,plus)

		plus=createpicbutton(0,cvsh-50,"jc.png",setjustifcenter )
		table.insert(widgets,plus)

		
		zoom=createslider(20,300)
		table.insert(widgets,zoom)
		first=createtbox(100,100,300,500)
		table.insert(widgets,first)
		boxfocus=first
		
	
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
		-- to_save=love.graphics.captureScreenshot("screenshot.png")
		-- -- to_save:encode("png","test.png")
		-- -- softcompose(softcomposed,typo["A"].data,0,0)
		-- composescreen(softcomposed,lines,0,0)
		-- softcomposed:encode("png","softcomposed.png")
		-- love.event.quit()

		love.graphics.setCanvas(mylt)
		love.graphics.clear(1.0,1.0,1.0,0.0)
		-- love.graphics.setColor(1.0,1.0,0.0,1.0)
		-- love.graphics.circle("fill",100,100,50)
		-- love.graphics.setColor(1.0,1.0,0.0,0.5)
		-- love.graphics.circle("fill",200,200,50)
		-- love.graphics.setColor(1.0,1.0,0.0,0.2)
		-- love.graphics.circle("fill",300,300,50)
		rendergui()

	
		love.graphics.setCanvas()
		mylt:newImageData():encode("png","test.png")

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
	
	
function rendergui()	
	for i,w in ipairs( widgets)
	do
		w.render(w)
	
	end
end

	
function love.draw()


	rendergui()

	
	-- if elapsed ==false then
		-- love.graphics.captureScreenshot("dbg.png")
		-- elapsed=true
	-- end
	
	
	-- love.graphics.draw(typo['unknown'].pic,0,0)
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
	
	
	
	
	