local f = io.open("test_1.vmf", "r")
local s = f:read("*a")
f:close()
local m = {}

for y = 0, 5 do
	for x = 0, 5 do
		m[x * 6 + y] = (-384 + (x * 256)) .. " " .. (-128 + (y * 256)) .. " 16"
		io.write((x .. ";" .. y),"   ")
	end
	io.write("\n")
end

local i = 0

s = string.gsub(s, [[entity
{
.-
}]], function(e)
	if not e:find([["classname" "gm_sales_shelf_point"]]) then return e end
	local x, y = math.floor(i / 6), i % 6
	local dirs = {}

	if x ~= 0 and m[(x - 1) * 6 + y] then
		dirs[1] = (x - 1) * 6 + y
	end

	if y ~= 5 and m[x * 6 + (y + 1)] then
		dirs[#dirs + 1] = x * 6 + (y + 1)
	end

	if x ~= 5 and m[(x + 1) * 6 + y] then
		dirs[#dirs + 1] = (x + 1) * 6 + y
	end

	if y ~= 0 and m[x * 6 + (y - 1)] then
		dirs[#dirs + 1] = x * 6 + (y - 1)
	end

	local s1, s2, s3, s4 = dirs[1], dirs[2], dirs[3], dirs[4]
	local nexts = ""

	if s1 then
		nexts = [[	"nextshelf1" "ShelfPoint]] .. s1 .. "\"\n"
	end

	if s2 then
		nexts = nexts .. [[	"nextshelf2" "ShelfPoint]] .. s2 .. "\"\n"
	end

	if s3 then
		nexts = nexts .. [[	"nextshelf3" "ShelfPoint]] .. s3 .. "\"\n"
	end

	if s4 then
		nexts = nexts .. [[	"nextshelf4" "ShelfPoint]] .. s4 .. "\"\n"
	end

	i = i + 1

	return string.format([[entity
{
	"id" "%s"
	"classname" "gm_sales_shelf_point"
%s	"targetname" "%s"
	"origin" "%s"
	editor
	{
		"color" "220 30 220"
		"visgroupshown" "1"
		"visgroupautoshown" "1"
		"logicalpos" "[0 9500]"
	}
}]], e:match([["id" "(%d+)"]]), nexts, "ShelfPoint" .. (i - 1), m[i - 1])
end)

local f = io.open("test_1.vmf", "w")
f:write(s)
f:close()