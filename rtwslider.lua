local dfltrtw=0.5

local sheight=300
local swidth=20

local function render(s)
	if renderdecos==true then
		love.graphics.setColor(1.0,0.0,0.0,1.0)
		love.graphics.rectangle("fill",s.x,s.y,swidth,sheight)
		love.graphics.setColor(0.0,1.0,0.0,1.0)
		love.graphics.rectangle("fill",s.x,s.y,swidth,sheight*s.value)
	end
end


local function drag(s,dx,dy)


		s.value= s.value +dy/sheight 
		if s.value<0.1 then
		
			s.value=0.1
		end	

		if s.value>1.0 then
		
			s.value=1.0
		end	
		
		
		updatertw(s)
end


function updatertw(s)
	rtw=tw*s.value
end

function rtwsclick(s,mx,my)
	if mx >= s.x and mx<s.x+swidth and my >= s.y and my<s.y+sheight then
		
		s.value= (my-s.y)/sheight 
		
		updatertw(s)
		registerdrag=s
		
		return true
	end
end

function creatertwslider(x,y)
	ret={}
	ret.x=x
	ret.y=y
	ret.render=render
	ret.click=rtwsclick
	ret.value=dfltrtw
	ret.drag=drag
	return ret
end




