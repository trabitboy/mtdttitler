-- BUG in line break, if word to big, empty rl inserted


--WIP load save
--whole state to load save

--TODO load save screen with folders
--TODO save and restore, maybe separate thumb screen? pic and data saved ?

--WIP snap
-- on left or right
--TODO snap on up down
-- copy width copy height copy zoom button ?
--TODO disable snap  ( toggle button )





require("conf")

renderdecos=true

cvsw=1920
cvsh=1080
 -- cvsw=ww
 -- cvsh=wh
 love.window.setMode(ww,wh,{resizable=true})
 
 scrsx=ww/cvsw
 scrsy=wh/cvsh
  
 
 love.window.setTitle("mtdt titler")
 --r to tex
	mylt=love.graphics.newCanvas(cvsw,cvsh)

--typo width height (pic size)
tw=80
th=200
--meaninful area in the middle (to trim empty space)
rtw=(tw/2)

function love.resize( nw, nh )
	local npw,nph=love.window.toPixels( nw, nh )
	ww=npw
	wh=nph
	local pscrsx=ww/cvsw
	local pscrsy=wh/cvsh
	if pscrsx>pscrsy then
		scrsy=pscrsy
		scrsx=pscrsy
	else
		scrsy=pscrsx
		scrsx=pscrsx
	
	end
end


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
require("rtwslider")
require("cprlfl")
require("save")
require("msgbox")

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
	
	
	function copywidthmode()
	
		if copywcb==nil then
			msg.postmsg(msg,"copy width mode, click other box, reclick button to cancel",true)
			copywcb=true
		else 
			copywcb=nil
			msg.postmsg(msg,"copy width mode canceled")
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
		
		rtwslide=creatertwslider(cvsw-40,300)		
		table.insert(widgets,rtwslide)

		msg=createmsgbox(600,10)
		table.insert(widgets,msg)

		copyw=createpicbutton(200,cvsh-50,"copywidth.png",copywidthmode )
		table.insert(widgets,copyw)

		
	end

	

	
	
npress=false
npx=nil
npy=nil	
	
	
love.mousepressed = function(x, y, button)
	print("mousepressed "..x.." "..y)
	npress=true
	npx=x/scrsx
	npy=y/scrsy
	print("mousepressed scaled "..npx.." "..npy)
	
	
end

love.mousemoved=function( x, y, dx, dy, istouch )
	if registerdrag~=nil then
			registerdrag.drag(registerdrag,dx/scrsx,dy/scrsy)
	end
end

love.mousereleased = function(x, y, button)

	if registerdrag~=nil then
		if registerdrag.dragrelease then
			registerdrag.dragrelease(registerdrag)
		end
	end
	
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
	
	if key=="f1" then
		renderdecos= not renderdecos
	end
	
	if key=="f2" then
		msg.postmsg(msg,"save")
		savegui()
	end
	
	if key=="f3" then
		msg.postmsg(msg,"load")
		loadgui()
	end
	
end




	
love.textinput = function(key)

	print(key)
	if boxfocus~=nil then
		boxfocus.addtext(boxfocus,key)
	end

end

function rendertocanvas()
		love.graphics.setCanvas(mylt)
		love.graphics.clear(1.0,1.0,1.0,0.0)
		rendergui()
		love.graphics.setCanvas()
end	

function love.update(dt)
	if love.keyboard.isDown("escape") then

		rendertocanvas()
		-- love.graphics.setCanvas(mylt)
		-- love.graphics.clear(1.0,1.0,1.0,0.0)
		-- rendergui()
		-- love.graphics.setCanvas()
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
	
	-- love.graphics.print("toto",100,100)
	
	--for debug,last click
	if npx~=nil and renderdecos==true then
		love.graphics.circle("fill",npx,npy,10)
	end
	
end

	
function love.draw()

	-- love.graphics.setCanvas(mylt)
	-- rendergui()
	-- love.graphics.setCanvas()
	-- love.graphics.setColor(0.0,0.0,0.0,0.0)
	-- love.graphics.clear()
	 -- love.graphics.draw(mylt,0,0,0,ww,wh)

	 
	 rendertocanvas()
	love.graphics.setColor(0.0,0.0,0.0,1.0)
	love.graphics.clear()
	love.graphics.setColor(1.0,1.0,1.0,1.0)
	love.graphics.draw(mylt,0,0,0,scrsx,scrsy)
	-- rendergui()
end
	
	
	
	
	