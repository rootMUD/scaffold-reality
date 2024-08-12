-- Name: YuanGuider
-- PID: C4XXTcFs_0-dsPkszmqTVCVhdIDjiUjJ0rzA_1Y6l5I
-- $ aos yuan-guider --module="GYrbbe0VbHim_7Hi6zrOpHQXrSQz07XNtwCnfbFo2I0" --cron 1-minute
-- aos> .load YuanGuider.lua
-- aos> .monitor

local json = require("json")

TARGET_WORLD_PID ='D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'

CHAT_TARGET = 'D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'

HomePosition = HomePosition or { 39, 28 }
Initialized = Initialized or nil

TIMESTAMP_LAST_MESSAGE_MS = TIMESTAMP_LAST_MESSAGE_MS or 0
COOLDOWN_MS = 5000

QUOTE_INDEX = QUOTE_INDEX or 1

QUOTES = {"Welc0me the Player to the YuanSpace.", "Let's buidl the Autonomous World based on AO.",
          "↓ Go South, you could travel to the other worlds.",
          "↑ Go North, there will be a 'launchPad land', Where you can find the really c00l projects", 
          "← Go West, there is the playground, you could trade, make friends, fight with player/agent, do anythings you like", 
          "Travel around the world, maybe you could find some serendipities!"}

function Register()
    print("Registering")
    Send({
        Target = TARGET_WORLD_PID,
        Tags = {
            Action = "Reality.EntityCreate"
        },
        Data = json.encode({
            Type = "Avatar",
            Position = HomePosition,
            Metadata = {
                DisplayName = "YuanGuider",
                Interaction = {
                    Type = "Default"
                },
                SkinNumber = 1
            }
        })
    })
end

if (not Initialized) then
    Register()
end

Handlers.add('DefaultInteraction', Handlers.utils.hasMatchingTag('Action', 'DefaultInteraction'), function(msg)
    print('DefaultInteraction')
    if ((msg.Timestamp - TIMESTAMP_LAST_MESSAGE_MS) < COOLDOWN_MS) then
        return
    end

    local quote = QUOTES[QUOTE_INDEX]  -- Get the current quote by index
    Send({
        Target = CHAT_TARGET,
        Tags = {
            Action = 'ChatMessage',
            ['Author-Name'] = 'YuanGuider'
        },
        Data = quote
    })

    -- Update the quote index to the next one, wrap around if at end of list
    QUOTE_INDEX = QUOTE_INDEX + 1
    if QUOTE_INDEX > #QUOTES then
        QUOTE_INDEX = 1
    end

    TIMESTAMP_LAST_MESSAGE_MS = msg.Timestamp

end)

Handlers.add(
  "CronTick",
  Handlers.utils.hasMatchingTag("Action", "Cron"),
  function(msg)
    print("CronTick")
    Send({
        Target = TARGET_WORLD_PID,
        Tags = {
          Action = 'Reality.EntityFix',
        },
      })
    end
)
