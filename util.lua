util = {}

-- https://lospec.com/palette-list/resurrect-64
util.colors = {
  foo="#2e222f",
  foo="#3e3546",
  foo="#625565",
  foo="#966c6c",
  foo="#ab947a",
  foo="#694f62",
  foo="#7f708a",
  foo="#9babb2",
  foo="#c7dcd0",
  white="#ffffff",
  foo="#6e2727",
  foo="#b33831",
  foo="#ea4f36",
  foo="#f57d4a",
  foo="#ae2334",
  foo="#e83b3b",
  foo="#fb6b1d",
  foo="#f79617",
  foo="#f9c22b",
  foo="#7a3045",
  foo="#9e4539",
  foo="#cd683d",
  foo="#e6904e",
  foo="#fbb954",
  foo="#4c3e24",
  foo="#676633",
  foo="#a2a947",
  foo="#d5e04b",
  foo="#fbff86",
  foo="#165a4c",
  foo="#239063",
  foo="#1ebc73",
  foo="#91db69",
  foo="#cddf6c",
  foo="#313638",
  foo="#374e4a",
  foo="#547e64",
  foo="#92a984",
  foo="#b2ba90",
  foo="#0b5e65",
  foo="#0b8a8f",
  foo="#0eaf9b",
  foo="#30e1b9",
  foo="#8ff8e2",
  foo="#323353",
  foo="#484a77",
  foo="#4d65b4",
  blue="#4d9be6",
  foo="#8fd3ff",
  foo="#45293f",
  foo="#6b3e75",
  foo="#905ea9",
  foo="#a884f3",
  foo="#eaaded",
  foo="#753c54",
  foo="#a24b6f",
  foo="#cf657f",
  foo="#ed8099",
  foo="#831c5d",
  foo="#c32454",
  foo="#f04f78",
  foo="#f68181",
  foo="#fca790",
  foo="#fdcbb0",
}

function util.setColorHex(rgba)
--	setColorHEX(rgba)
--	where rgba is string as "#336699cc"
	local rb = tonumber(string.sub(rgba, 2, 3), 16)
	local gb = tonumber(string.sub(rgba, 4, 5), 16)
	local bb = tonumber(string.sub(rgba, 6, 7), 16)
	local ab = tonumber(string.sub(rgba, 8, 9), 16) or nil
--	print (rb, gb, bb, ab) -- prints 	51	102	153	204
--	print (love.math.colorFromBytes( rb, gb, bb, ab )) -- prints	0.2	0.4	0.6	0.8
	love.graphics.setColor(love.math.colorFromBytes( rb, gb, bb, ab ))
end

function util.pp(table)
  print(table)
  for k,v in pairs(table) do
    print("  - " .. k .. " => " .. tostring(v))
  end
end

function util.capitalize(s)
  local first = string.upper(string.sub(s,1,1))
  local rest = string.sub(s,2,string.len(s))
  return first..rest
end

function util.titlecase(s)
  local text, _ = s:gsub("_", " ")
  local result = ""
  for word in string.gmatch(text, "%a+") do
    result = result .. util.capitalize(word) .. " "
  end
  chomp = result:sub(1, result:len() - 1)
  return chomp
end
