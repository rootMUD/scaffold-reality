local json = require("json")

TARGET_WORLD_PID = 'D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'
CHAT_TARGET = 'D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'
HomePosition = HomePosition or { 39, 40 }
Initialized = Initialized or nil
TIMESTAMP_LAST_MESSAGE_MS = TIMESTAMP_LAST_MESSAGE_MS or 0
COOLDOWN_MS = 3000

QUOTES = {
    "Here are the LIST of world you could visit:",
    "LLAMA LAND: https://llamaland.arweave.net",
    "YuanSpace: https://world.rootmud.xyz"
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
                DisplayName = "YuanSailor",
                Interaction = {
                    Type = "Default"
                },
                SkinNumber = 2
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
