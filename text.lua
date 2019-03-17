local function addtext(t,txt)

end

local function editkey(t,key)

end

local function render(t,x,y)
	for i,l in ipairs(t.buffer)
	do
		love.graphics.print(l,x,y)
		-- love.graphics.print(x,y,l)
	end
end


function createText()
	ret={}

	ret.buffer={}	
	table.insert(ret.buffer,"pipi")
	ret.addtext=addtext
	ret.editkey=editkey
	ret.render=render
	return ret
end


