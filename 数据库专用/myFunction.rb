module MYFUNCTION
	def MYFUNCTION.append(string,needQuotations)
		array=string.split(",")
		result="("
		for i in 0..needQuotations.length-1
			if(result.length==1)
				result+=quotation(array[i],needQuotations[i])
			else
				result+=","
				result+=quotation(array[i],needQuotations[i])
			end
		end
		result+=')'
		#puts result
		return result
	end

	def MYFUNCTION.quotation(item,boolean)
		if boolean
			return "'#{item}'"
		else
			return "#{item}"
		end
	end
end