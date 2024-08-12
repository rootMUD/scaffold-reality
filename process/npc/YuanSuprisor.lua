local json = require("json")

TARGET_WORLD_PID = 'D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'
CHAT_TARGET = 'D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'

ACHIEVEMENT_TARGET = 'wbIGThLriLEzpuL5yS__aba2jn0YAF471adJTrc0Pdg'

HomePosition = HomePosition or {14, 43}
Initialized = Initialized or nil
TIMESTAMP_LAST_MESSAGE_MS = TIMESTAMP_LAST_MESSAGE_MS or 0
COOLDOWN_MS = 3000

QUOTES = {"Lucky Guy! You found me! I will give you a achievement", "You could check all of ur achievement in:",
          "https://dimension-life.rootmud.xyz/profile"}

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
                DisplayName = "YuanSuperisor",
                Interaction = {
                    Type = "Default"
                },
                SkinNumber = 7
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
                ['Author-Name'] = 'YuanSuperisor'
            },
            Data = quote
        })
    end

    -- Send({
    --     Target = ACHIEVEMENT_TARGET,
    --     Tags = {
    --       Action = 'GetAllWhitelists',
    --     },
    --     Data = '{"cursor": 0}'
    -- })

    Send({
        Target = ACHIEVEMENT_TARGET,
        Tags = {
            Action = 'AppendAchievement'
        },
        Data = json.encode({
            title = 'findsuperisor',
            description = 'Yeps! You find Supervisor!',
            proven = '',
            address = msg.From
        })
    })

    TIMESTAMP_LAST_MESSAGE_MS = msg.Timestamp
end)

Handlers.add("CronTick", Handlers.utils.hasMatchingTag("Action", "Cron"), function(msg)
    print("CronTick")
    Send({
        Target = TARGET_WORLD_PID,
        Tags = {
            Action = 'Reality.EntityFix'
        }
    })
end)
