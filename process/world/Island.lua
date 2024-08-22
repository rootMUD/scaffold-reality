-- PID Kh-PHmaRt0bykGUgyK4euVSknML6yHIwQPyR5xPvXxg

--#region Model

RealityInfo = {
  Dimensions = 2,
  Name = 'ExampleReality',
  ['Render-With'] = '2D-Tile-0',
}

RealityParameters = {
  ['2D-Tile-0'] = {
    Version = 0,
    Spawn = { 10, 10 },
    -- This is a tileset themed to Llama Land main island
    Tileset = {
      Type = 'Fixed',
      Format = 'PNG',
      TxId = 'h5Bo-Th9DWeYytRK156RctbPceREK53eFzwTiKi0pnE', -- TxId of the tileset in PNG format
    },
    -- This is a tilemap of sample small island
    Tilemap = {
      Type = 'Fixed',
      Format = 'TMJ',
      TxId = 'koH7Xcao-lLr1aXKX4mrcovf37OWPlHW76rPQEwCMMA', -- TxId of the tilemap in TMJ format
      -- Since we are already setting the spawn in the middle, we don't need this
      -- Offset = { -10, -10 },
    },
  },
}

RealityEntitiesStatic = {
    -- Blue potion: Warp back to island
    ['D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc'] = {
      Position = { 8, 8 },
      Type = 'Hidden', -- 'Warp'/'Avatar' types are understood by `2D-Tile-0` renderer
      Metadata = {
        Interaction = {
          Type = 'Warp',
          Size = { 1, 1 }
        },
      }
    },
  ['CJcM_n0-s3gtt_Xqcffu5-AseTFARioG7iK4B3myeU4'] = {
    Type = "Avatar",
    Position = { 9, 9 },
    Metadata = {
      DisplayName = "Captain",
      SkinNumber = 9,
      Interaction = {
        Type = 'SchemaForm',
        Id = 'Sail',
      },
    },
  }
}

--#endregion

return print("Loaded Reality Template")
