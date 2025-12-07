local mp = require "mp"

-- On my NucBox G1 with an Intel N95 processor, 4K AV1 encoded videos play
-- poorly unless the fast profile is selected.
local function use_fast_profile()
    local height = tonumber(mp.get_property("height"))
    if height > 1080 then
        mp.msg.info("high-res video height =", height)
        mp.commandv("set", "profile", "fast")
    end
end

mp.register_event("file-loaded", use_fast_profile)
