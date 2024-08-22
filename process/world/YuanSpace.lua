-- Tile Source: vWUOQGqnN4lIFkdN1Q_RAVf7-cz5TTmbDtxCAOuESdk
-- Map JSON: HZPhTBVaqMZVr6UC5gpGMYx1-qJUjcIdDOFaVCvjh-s
-- Name: YuanSpace
-- ProcessId: D47JUInbsrPfYp2lSyqXY4YEa5ShZw7TeZrIA-b-_Nc
-- Tileset: https://bakudas.itch.io/generic-rpg-pack

--#region Model

RealityInfo = {
    Dimensions = 2,
    Name = 'YuanSpace',
    ['Render-With'] = '2D-Tile-0',
  }
  
  RealityParameters = {
    ['2D-Tile-0'] = {
      Version = 0,
      Spawn = { 36, 28 },
      -- This is a tileset themed to Llama Land main island
      Tileset = {
        Type = 'Fixed',
        Format = 'PNG',
        TxId = 'EV5Mo7Fs4c_MW0u4taZ0IqU1nMrLb1JBd9uylqIo6GE', -- TxId of the tileset in PNG format
      },
      -- This is a tilemap of sample small island
      Tilemap = {
        Type = 'Fixed',
        Format = 'TMJ',
        -- TxId = '8pEgfhyIgLB2d33hXh9YzcxtNPx807mzhf2_6qFcPjg'
        TxId = 'zONIRQfsw1561DVZ-cApZ9YFs-0hp4jBi53Y3XsZYXg'
        -- TxId = 'gzh7MgSQnZrYgO4saNdLggS4XxMBcdAtdfGZmLsdUPM', -- TxId of the tilemap in TMJ format
        -- Since we are already setting the spawn in the middle, we don't need this
        -- Offset = { -10, -10 },
      },
    },
  }
  
  RealityEntitiesStatic = {
    -- Blue potion: Warp back to island
    ['19z5ky0x_z5tae_nQmvTGLyOelknHb2uFCz2SnJBoek'] = {
      Position = { 40, 42 },
      Type = 'Hidden', -- 'Warp'/'Avatar' types are understood by `2D-Tile-0` renderer
      Metadata = {
        Interaction = {
          Type = 'Warp',
          Size = { 1, 1 }
        },
      }
    }
  }
  
  --#endregion
  
  return print("Loaded Reality Template")
  