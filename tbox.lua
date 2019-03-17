
registerdrag=nil


-- the box which has the focus (only one ) for text andbutton interqctions
boxfocus=nil

hdlw=32
hdlh=32



local function drag(b,dx,dy)
	if b.mode=="drag" then
		b.x=b.x+dx
		b.y=b.y+dy
	end
	if b.mode=="resize" then
		b.w=b.w+dx
		b.h=b.h+dy
	end
end

--if consumed returns true
local function click(b,mx,my)

	if boxfocus==b then
		if mx >= b.x-hdlw and mx<b.x and my >= b.y-hdlh and my<b.y then
			b.mode="drag"
			registerdrag=b
		end
	
	end

	if boxfocus==b then
		if mx >= b.x+b.w and mx<b.x+b.w+hdlw and my >= b.y+b.h and my<b.y+b.h+hdlh then
			b.mode="resize"
			registerdrag=b
		end
	
	end
	
		
	if mx >= b.x and mx<b.x+b.w and my >= b.y and mx<b.y+b.h then
		print("click")
		
		boxfocus=b
		
		return true
	end
	return false
end


local function render(b)
	love.graphics.setColor(0.0,1.0,0.0,1.0)
	if b==boxfocus then
		love.graphics.setColor(1.0,0.0,0.0,1.0)
	end
	
	
	love.graphics.rectangle("fill",b.x-hdlw,b.y-hdlh,hdlw,hdlh)
	love.graphics.rectangle("line",b.x,b.y,b.w,b.h)
	love.graphics.rectangle("fill",b.x+b.w,b.y+b.h,hdlw,hdlh)
	-- b.text.render(b.text,b.x,b.y)
	
end

function createtbox(x,y,w,h)
	ret={}
	ret.x=x
	ret.y=y
	ret.w=w
	ret.h=h
	ret.render=render
	ret.click=click
	ret.drag=drag
	
	-- ret.text=createText()
	
	return ret
end
