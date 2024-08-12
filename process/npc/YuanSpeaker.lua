-- $ aos yuan-sailor --module="GYrbbe0VbHim_7Hi6zrOpHQXrSQz07XNtwCnfbFo2I0" --cron 1-minute
-- aos> .load YuanSailor.lua
-- aos> .monitor

local json = require("json")

Initialized = Initialized or nil
TARGET_WORLD_PID = "D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc"

TICK_COUNT = TICK_COUNT or 0

MinRunTime = MinRunTime or 5000

IsRunning = IsRunning or false
RunStage = RunStage or 1
LastRunStageTimestamp = LastRunStageTimestamp or 0

HomePosition = {39 , 38}

function Register()
  print("Registering")
  Send({
    Target = TARGET_WORLD_PID,
    Tags = {
      Action = "Reality.EntityCreate",
    },
    Data = json.encode({
      Type = "Avatar",
      Position = HomePosition,
      Metadata = {
        DisplayName = "YuanSailor",
        Interaction = {
          Type = "SchemaForm",
          Id = "HiPlayer",
        },
        SkinNumber = 3,
      },
    }),
  })
end

if (not Initialized) then
  Register()
end

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

-- Schema

Handlers.add(
  'Schema',
  Handlers.utils.hasMatchingTag('Action', 'Schema'),
  function(msg)
    print('Schema')
    Send({
    Target = msg.From,
    Tags = { Type = 'Schema' },
    Data = json.encode({
      HiPlayer = {
        Title = "a small joke",
        Description = "how about tell a small joke in the chatbox?",
        Schema = nil,
        },
    })
    })
  end
)