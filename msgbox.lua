local function render(m)
	love.graphics.setColor(1.0,1.0,1.0,1.0)
	if m.tick>0 or m.infinite==true then
		love.graphics.print(m.msg,m.x,m.y,0,2,2)
	end
	m.tick=m.tick-1
	if m.tick<0 then m.tick=0 end
end


local function click(m)

--nothing
end

local function postmsg(m,s,i)
	--flushing
	m.infinite=false

	m.msg=s 
	if i==true then
		m.infinite=true
	else
		m.tick=120
	end

end

function createmsgbox(x,y)
	ret={}
	ret.x=x
	ret.y=y
	ret.render=render
	ret.click= click
	ret.msg="welcome"
	ret.tick=120
	ret.infinite=false
	ret.postmsg=postmsg
	return ret
end