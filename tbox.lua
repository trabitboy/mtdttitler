
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
	print("scan click of id "..b.id)


	if boxfocus==b then
		if mx >= b.x-hdlw and mx<b.x and my >= b.y-hdlh and my<b.y then
			b.mode="drag"
			registerdrag=b
			return true
		end
	
	end

	if boxfocus==b then
		if mx >= b.x+b.w and mx<b.x+b.w+hdlw and my >= b.y+b.h and my<b.y+b.h+hdlh then
			b.mode="resize"
			registerdrag=b
			return true
		end
	
	end
	
		
	if mx >= b.x and mx<b.x+b.w and my >= b.y and my<b.y+b.h then
		print("click detected on id "..b.id)
		
		boxfocus=b
		
		return true
	end
	return false
end

local function addtext(b,txt)
	b.buffer[b.line]=b.buffer[b.line]:sub(1,b.char)..txt..b.buffer[b.line]:sub(b.char+1)
	b.char=b.char+string.len(txt)
	-- b.char=string.len(b.buffer[b.line])
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
	if key=='left' then
		if b.char>1 then
			b.char=b.char-1
			
		end
	end
	if key=='right' then
		if b.char<string.len(b.buffer[b.line]) then
			b.char=b.char+1
		end
	end
	if key=='up' then
		if b.line>1 then
			b.line=b.line-1
			if b.char> string.len(b.buffer[b.line]) then
				--end of line
				b.char=string.len(b.buffer[b.line]) 
			end
		end

	end
	if key=='down' then
		if b.line<tbllngth(b.buffer) then
			b.line=b.line+1
			if b.char> string.len(b.buffer[b.line]) then
				--end of line
				b.char=string.len(b.buffer[b.line]) 
			end
		end

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
	love.graphics.print(b.id,b.x-hdlw,b.y-hdlh)
	y=0
	curline=1
	for i,l in ipairs(b.buffer)
	do
		x=0
	
		--draw a line under current line
		if curline == b.line then
			love.graphics.line(b.x,b.y+y+th*b.tzoom,b.x+b.w,b.y+y+th*b.tzoom)
		end
	
		for i = 1, #l do
			local c = l:sub(i,i)
			-- do something with c

			--draw a cursor like line
			if curline==b.line and i==b.char then
				love.graphics.line(b.x+x+tw*b.tzoom,b.y+y,b.x+x+tw*b.tzoom,b.y+y+th*b.tzoom)
			end

			if typo[c]~=nil then
				love.graphics.draw(typo[c].pic,b.x+x,b.y+y,0,b.tzoom,b.tzoom)
			end

			--draw marker on real carriage return
			if i==string.len(l) then			
				love.graphics.line(b.x+x+tw*b.tzoom,b.y+y,b.x+x+tw*b.tzoom,b.y+y+th*b.tzoom)
			end

			-- prepare coords for next char in line
			x=x+(tw/2)*b.tzoom
			-- if x>(b.w-(tw/2)*b.tzoom) then
			if x>b.w-((tw/2)*b.tzoom) then
				x=0
				-- y=y+th*b.tzoom
				y=y+th*b.tzoom
			end
	
			
			
		end
		y=y+th*b.tzoom
		curline=curline+1
	
	
		-- love.graphics.print(l,b.x,b.y+b.fh*i)
		-- love.graphics.print(x,y,l)
	end

end

function createtbox(x,y,w,h)
	ret={}
	
	wcount=wcount+1
	
	ret.id=wcount
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
	--current line
	ret.line=1
	ret.char=1
	ret.tzoom=dfltzoom
	
	
	return ret
end
