local lastRoll = 0

-- Event listeners
local frame, events = CreateFrame("Frame"), {};

function events:CHAT_MSG_SYSTEM(...)
    local msg = ...
    local author, rollResult, rollMin, rollMax = string.match(msg, "(.+) rolls (%d+) %((%d+)-(%d+)%)")
    if author then
        lastRoll = tonumber(rollResult)
    end
    if lastRoll == 1 and author then
        print(author .. " loses! Type \"/droll\" if you're the next person in the circle.")
    end
end

frame:SetScript("OnEvent", function(self, event, ...)
    events[event](self, ...);
end);

for k, v in pairs(events) do
    frame:RegisterEvent(k); -- Register all events for which handlers have been defined
end

local function droll(msg)
    if msg == "" and lastRoll <= 1 then
        RandomRoll(1, 1000)
    end
    if msg == "" and lastRoll > 1 then
        RandomRoll(1, lastRoll)
    end
    if msg == "?" then
        print("Death Rolling Commands:")
        print("/droll - Roll based on value of previous roll seen in chat")
        print("/droll ? - Show this message")
    end
end

SLASH_DROLLENTRY1 = "/droll"

SlashCmdList["DROLLENTRY"] = droll
