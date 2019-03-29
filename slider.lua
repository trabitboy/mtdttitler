local dfltzoom=0.2

local sheight=100
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
		
		
		if boxfocus~=nil then
			boxfocus.tzoom=s.value
			maintainlpl(boxfocus)
		end

end

function sclick(s,mx,my)
	if mx >= s.x and mx<s.x+swidth and my >= s.y and my<s.y+sheight then
		
		s.value= (my-s.y)/sheight 
		
		if boxfocus~=nil then
			boxfocus.tzoom=s.value
		
		end
		
		registerdrag=s
		
		
		return true
	end
end

function createslider(x,y)
	ret={}
	ret.x=x
	ret.y=y
	ret.render=render
	ret.click=sclick
	ret.value=dfltzoom
	ret.drag=drag
	return ret
end




