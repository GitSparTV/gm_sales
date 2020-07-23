ENT.Type = "point"

local keytoKey = {
	nextshelf1 = "Shelf1",
	nextshelf2 = "Shelf2",
	nextshelf3 = "Shelf3",
	nextshelf4 = "Shelf4",
}

function ENT:KeyValue( key, value )
	local l = keytoKey[key]
	if l then
		self[l] = value
	end
end