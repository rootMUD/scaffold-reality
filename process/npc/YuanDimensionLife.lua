local json = require("json")

TARGET_WORLD_PID = 'D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'
CHAT_TARGET = 'D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'
HomePosition = HomePosition or { 22, 3 }
Initialized = Initialized or nil
TIMESTAMP_LAST_MESSAGE_MS = TIMESTAMP_LAST_MESSAGE_MS or 0
COOLDOWN_MS = 3000

QUOTES = {
    "DimensionLife if the pet game & AI twin Protocol on AO!",
    "Launch App: https://home.dimension-life.rootmud.xyz/",
    "Homepage: https://home.dimension-life.rootmud.xyz/",
    "Whitepaper: https://bodhi.wtf/space/5/15192/"

}

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
                DisplayName = "DimensionLife",
                Interaction = {
                    Type = "Default"
                },
                SkinNumber = 6
            }
        })
    })
end

if not Initialized then
    Register()
end

Handlers.add('DefaultInteraction', Handlers.utils.hasMatchingTag('Action', 'DefaultInteraction'), function(msg)
    print('DefaultInteraction')
    if ((msg.Timestamp - TIMESTAMP_LAST_MESSAGE_MS) < COOLDOWN_MS) then
        return
    end

    -- Send each quote as a separate message
    for _, quote in ipairs(QUOTES) do
        Send({
            Target = CHAT_TARGET,
            Tags = {
                Action = 'ChatMessage',
                ['Author-Name'] = 'YuanSailor'
            },
            Data = quote
        })
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
end)
