

function simplecprlfl(lpl,l)
	--we iterate on segments and change line when a word segment
	--goes over char limit
	
	ret={}
	
	ts=splitwordandspace(l)
	
	-- nbseg=tbllngth(tosort)
	
	-- print("nb seg "..nbseg)
	-- for i,s in ipairs (tosort)
	-- do
		-- print ('#'..s.val..'#')
	-- end
	


	nbseg2=tbllngth(ts)
	if nbseg2>0 then
		line={}
		table.insert(ret,line)
		--we don t count spaces at begin or end of line
		counttotal=0
		
	end
	
	
	for i,s in ipairs(ts)
	do
		-- print(s)
		-- print(s.val)
		-- print(s.type)
		if s.val:len()+counttotal>lpl then
			-- we overflow line
		
			--TODO this is what inserts empty lines
			--TODO unclear 
		
			if tbllngth(line)>0 then
				--if not first segment of line, we go to next line
				counttotal=0
				line={}
				table.insert(ret,line)
				--we add on next line
				table.insert(line,s)		
				counttotal=counttotal+s.val:len()
			else
				--we go over it, but only word of line !!! we keep it
				table.insert(line,s)		
				counttotal=counttotal+s.val:len()
			end
			
		else
			--we dont overflow, easy 
			table.insert(line,s)		
			counttotal=counttotal+s.val:len()
		end
	end
	
	return ret
end


--WORKS
--get collection of words from string, with space inside
function splitwordandspace(l)
	local ret={}
	if #l==0 then
		return ret
	end
	
	
	current={}
	-- print(l[1])
	current.val=l:sub(1,1)
	print("val "..current.val)
	if l:sub(1,1)==' ' then
		current.type="space"
	else
		current.type="word"
	end
	
	if #l==1 then
		table.insert(ret,current)
	end
	
	--initial segment prepared
	for i = 2, #l do
		cur=l:sub(i,i)
	
		print("current "..cur)
		if cur==' ' and current.type=="word" then
			print("end text")
			--current text segment is over
			--flushing current
			table.insert(ret,current)
			--starting space segment
			current={}
			current.val=""
			current.type="space"
			print("val "..current.val)
		elseif cur~=' ' and current.type=="space" then
			print("end space")
			--ending space segment,flushing
			table.insert(ret,current)
			--starting text segment
			current={}
			current.val=""
			current.type="word"
			print("val "..current.val)
		end
	
		--after identifying state change we stack the segment
		print (current)
		print(current.val)
		current.val=current.val..cur
	
		--if last char of string we flush anyway
		if i==#l then
			--this was the last
			table.insert(ret,current)			
		end
	end
	--format {type:word,val='blabla'},{type:space,val='  '}
	return ret
end



--UNFINISHED MORE COMPLEX WHICH IGNORES SPACE AT BEGINNING AND END
--returns a collection of lines
--each line is a collection of segments, words and spaces
-- so that spaces can be ignored beginning and end of lines
function cprlfl(lpl,l)
	--we iterate on segments and change line when a word segment
	--goes over char limit
	
	ret={}
	
	tosort=splitwordandspace(l)
	if #tosort>0 then
		line={}
		--we don t count spaces at begin or end of line
		counttotal=0
		
	end
	
	for i,s in ipairs(tosort)
	do
		if s.type=="space" then
			--si debut de ligne, n'ajoute pas au compte
			if counttotal==0 then
				table.insert(line,s)
			--si l ajout fait passer la limite de ligne,
			-- on met l'espace mais on passe a la ligne
			else
				table.insert(line,s)
				counttotal=counttotal+s.val:len()
				if counttotal> lpl then
					table.insert(ret,line)
					line={}
					counttotal=0
				end
			end
		elseif s.type=="text" then
			--if text and we are above total when begin,
			-- skip line ( space before )
			-- if counttotal>lpl then
					-- table.insert(ret,line)
					-- line={}
					
					-- counttotal=0
			-- elseif #line==0 and s.val:len()>lpl 
			-- --if text first segment above total, we add and skip line
					-- table.insert(ret,line)
					-- line={}
					-- counttotal=0
				
			-- else
			-- -- if text is not first but above total, we skip then add
			
			-- end			
		end
	
	end
	
end







--to complicated, rewrite
function shitcomputereallinesfromline(lpl,l)
	ret={}
	cur=0 --current char of line
	validated=0
	inword=false
	lastchar=false
	beginofline=0
	
	for i = 1, #l do
		print("###begin char")
		local c = l:sub(i,i)
		cur=cur+1
		print(c)
		print("global "..i)
		print("cur "..cur)
		
		
		--are we on last char of line
		if cur==lpl or i==l:len() then 
			print("last char of line")
			lastchar=true
		end
		
		-- maintain in word status
		if c~=' ' then
			--toggle word state
			if inword==false then
				inword=true
				print("entering word")
			end
		else
			if inword==true then
				inword=false
				print("exiting word")
				--if transitioning to space from char,
				--previous pos is validated !
				--(maybe next char could be space )
				validated=cur-1
			end
			
			--no transition but in space, we validate
			validated=validated+1
		end
		

		print("###end char")
		
		--if last char we switch line now
		if lastchar==true then
			print("line change")
			validatedline=l:sub(beginofline+1,beginofline+validated)
			print("validated line: #"..validatedline..'#')
			table.insert(ret,validatedline)
			cur=0
			beginofline=beginofline+validated
			i=beginofline
			validated=0
			lastchar=false
			inword=false
		end
	end
	return ret
end	
