
registerdrag=nil


-- the box which has the focus (only one ) for text andbutton interqctions
boxfocus=nil

hdlw=32
hdlh=32

--for text
dfltzoom =0.3

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

local function addtext(b,txt)
	b.buffer[b.line]=b.buffer[b.line]..txt
end

local function editkey(b,key)
	if key=='return' then
		print('ed k')
		table.insert(b.buffer,"new")
		b.line=b.line+1
	end
	if key=='backspace' then
		b.buffer[b.line]=b.buffer[b.line]:sub(1, -2)
	end

end

-- function removeLastChar (string)
  -- return string:sub(1, -2)
-- end



local function tbrender(b)
	love.graphics.setColor(0.0,1.0,0.0,1.0)
	if b==boxfocus then
		love.graphics.setColor(1.0,0.0,0.0,1.0)
	end
	
	
	love.graphics.rectangle("fill",b.x-hdlw,b.y-hdlh,hdlw,hdlh)
	love.graphics.rectangle("line",b.x,b.y,b.w,b.h)
	love.graphics.rectangle("fill",b.x+b.w,b.y+b.h,hdlw,hdlh)
	-- b.text.render(b.text,b.x,b.y)
	
	
	love.graphics.setColor(1.0,1.0,1.0,1.0)
	y=0
	for i,l in ipairs(b.buffer)
	do
		x=0
	
		for i = 1, #l do
			local c = l:sub(i,i)
			-- do something with c
			if typo[c]~=nil then
				love.graphics.draw(typo[c].pic,b.x+x,b.y+y,0,b.tzoom,b.tzoom)
			end
			x=x+(tw/2)*b.tzoom
			-- if x>(b.w-(tw/2)*b.tzoom) then
			if x>b.w-((tw/2)*b.tzoom) then
				x=0
				-- y=y+th*b.tzoom
				y=y+th*b.tzoom
			end
		end
		y=y+th*b.tzoom
	
	
	
		-- love.graphics.print(l,b.x,b.y+b.fh*i)
		-- love.graphics.print(x,y,l)
	end

end

function createtbox(x,y,w,h)
	ret={}
	ret.x=x
	ret.y=y
	ret.w=w
	ret.h=h
	ret.fh=16
	
	ret.render=tbrender
	ret.click=click
	ret.drag=drag
	
	ret.buffer={}	
	table.insert(ret.buffer,"")
	ret.addtext=addtext
	ret.editkey=editkey
	ret.line=1
	ret.tzoom=dfltzoom
	
	
	return ret
end
