serialize=require("ser")


function collectstate()

	ret={}

	ret.rtw=rtw
	print("rtw"..rtw)
	ret.boxes={}
	
	for i,b in ipairs(widgets) 
	do
		if b.type=='tbox' then
			s={}
			s.x=b.x
			s.y=b.y
			s.w=b.w
			s.h=b.h
			s.buffer=b.buffer
			s.tzoom=b.tzoom
			s.justif=b.justif
			table.insert(ret.boxes,s)
		end
	
	end
	return ret
end


function restorestate(s)
	rtw=s.rtw
	print("rtw"..rtw)
	rtwslide.value=rtw/tw

	--we remove all boxes 
	for i,w in ipairs(widgets)
	do
		if w.type=='tbox' then
			table.remove(widgets,i)
		end
	end
	
	
	for i,b in ipairs(s.boxes) 
	do
			rest=createtbox(b.x,b.y,b.w,b.h)
			rest.buffer=b.buffer
			rest.tzoom=b.tzoom
			rest.justif=b.justif
			maintainlpl(rest)
			table.insert(widgets,rest)
		
	
	end
	
	
end

function savegui()
 print('#save')

 love.filesystem.write('state.lua',serialize(collectstate()))

end


function loadgui()
 print('#load')
 -- if love.filesystem.getInfo('state.lua').exists then
 if love.filesystem.getInfo('state.lua') then
  print("state exists")
  loaded=love.filesystem.load('state.lua')()
  print('restoring state')
  restorestate(loaded)
 end

end