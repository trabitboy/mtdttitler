--compose the image to save in software ( to handle alpha ourselves )

--blits a line 
function composescreen(tgt,ls,x,y)

	ly=0
	for j,line in ipairs(ls)
	do

		lx=0
		for i = 1, #line do
			local c = line:sub(i,i)
			-- do something with c
			softcompose(tgt,typo[c].data,lx,y)
			lx=lx+80
		end
		ly=ly+th
	end
end


function rendertitling()
	

end

--TODO zoom later?
-- takes 2 image datas and coords, copies alpha
function softcompose( tgt , src, x, y )
	for j=0,1079
	do
		for i = 0,1919 do
		
			-- sx=i-x
			-- sy=i-
			
				-- tgt:setPixel(i,j,
					-- 0.5,					
					-- 0.5,
					-- 0.5,
					-- 0.5)
			
			if (i-x)>=0 and (i-x)<src:getWidth() 
				and (j-y)>=0 and (j-y)<src:getHeight()
			then
		
				tgt:setPixel(i,j,src:getPixel(i-x,j-y))
			end
		end
	end
end