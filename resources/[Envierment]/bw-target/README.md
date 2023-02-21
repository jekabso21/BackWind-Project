# meta_target

## Release
Please report bugs, incorrect readme instructions/examples, or any other issue you might find, right here on github issues.  
You can also post any missing features from other targetting resources that you would like added through github issues.

## Referencing:

Add the api to your resource fxmanifest.lua:
`client_script '@bw-target/lib/target.lua'`  [
NOTE: You can use e]()xports by the same function name if you choose (as the examples.lua file does).

## Api functions:
```
ret nil             target.addPoint           (id, title, icon, point,      radius,     onInteract, items,      vars)
ret nil             target.addModel           (id, title, icon, model,      radius,     onInteract, items,      vars)
ret table[id,...]   target.addModels          (id, title, icon, models,     radius,     onInteract, items,      vars)
ret nil             target.addNetEnt          (id, title, icon, netId,      radius,     onInteract, items,      vars)
ret nil             target.addLocalEnt        (id, title, icon, entId,      radius,     onInteract, items,      vars)
ret nil             target.addInternalPoly    (id, title, icon, points,     options,    radius,     onInteract, items,      vars)
ret nil             target.addInternalBoxZone (id, title, icon, center,     length,     width,      options,    radius,     onInteract, items, vars)
ret function        target.addExternalPoly    (id, title, icon, radius,     onInteract, items,      vars)
ret function        target.addExternalBoxZone (id, title, icon, radius,     onInteract, items,      vars)
ret nil             target.addNetEntBone      (id, title, icon, netId,      bone,       radius,     onInteract, items,      vars)
ret table[id,...]   target.addNetEntBones     (id, title, icon, netId,      bones,      radius,     onInteract, items,      vars)
ret nil             target.addLocalEntBone    (id, title, icon, entId,      bone,       radius,     onInteract, items,      vars)
ret table[id,...]   target.addLocalEntBones   (id, title, icon, entId,      bones,      radius,     onInteract, items,      vars)
ret nil             target.addModelBone       (id, title, icon, model,      bone,       radius,     onInteract, items,      vars)
ret table[id,...]   target.addModelBones      (id, title, icon, models,     bones,      radius,     onInteract, items,      vars)
ret nil             target.remove             (id, ... [,id,id])
```

### Argument info:

##### REQUIRED
```
id          - string              (unique identifier for this target)
title       - string              (ui title label)
icon        - string              (fontawesome icon for menu title [e.g: 'fas fa-user'])
onInteract  - string OR function  (callback function or event name to trigger when an item of this target is selected)
items       - table               (table of items, more information on item structure below in this document under "Item info:")
vars        - table               (a table of any additional data you want to pass along to your callback function/event)
```

##### OPTIONAL (Based on type)
```
any
radius - number (distance from player to raycast endCoord to interact with this target)
```

```
point
point - vector3 (target point)
```

```
model
model - string OR hash (name or hash of model)
```

```
models
models - table (table of strings or numbers/hashes)
```

```
netEnt
netId - number (network id from NetworkGetNetworkIdFromEntity(ent))
```

```
localEnt
entId - number (id for this entity)
```

```
internalPoly
points  - table (table of vector2 points to create the polyzone with)
options - table (options for the polyzone, more information on https://github.com/mkafrin/PolyZone)
```

```
internalBoxZone
center  - vector3 (center point for box zone)
length  - number  (length of box zone)
width   - number  (width of box zone)
options - table   (options for the box zone, more information on https://github.com/mkafrin/PolyZone)
```

```
netEntBone
netId - number (network id from NetworkGetNetworkIdFromEntity(ent))
bone  - string OR hash (name or hash of bone)
```

```
netEntBones
netId - number (network id from NetworkGetNetworkIdFromEntity(ent))
bones - table (table of bone names or bone hashes)
```

```
localEntBone
entId - number (id for this entity)
bone  - string OR hash (name or hash of bone)
```

```
localEntBones
entId - number (id for this entity)
bones - table (table of bone names or bone hashes)
```

```
modelBone
model - string OR hash (name or hash of model)
bone  - string OR hash (name or hash of bone)
```

```
modelBones
model - string OR hash (name or hash of model)
bones - table (table of string OR hash (name or hash of bone))
```

### Item info:

##### REQUIRED
```
label - string (ui label for this option)
```

##### OPTIONAL
```
onInteract  - string OR function  (callback function or event name to trigger when this item specifically is selected)
anything    - any                 (literally any other data you want to pass through to your callback/event)
```

## Example use:

### netEnt
```lua
  -- NOTE: This example uses a callback event per option, and a single default callback function for any others

  AddEventHandler('myscript:handsUp',function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> hands_up          Hands Up
  end)

  AddEventHandler('myscript:openInventory',function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> open_inventory    Open Inventory
  end)

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> ragdoll           Ragdoll
  end

  local networkId = NetworkGetNetworkIdFromEntity(PlayerPedId())

  target.addNetEnt('my_netEnt_target', 'Network Entity', 'fas fa-user', networkId, 10.0, onInteract, {
    {
      name = 'hands_up',
      label = 'Hands Up',
      onSelect = 'myscript:handsUp'
    },
    {
      name = 'open_inventory',
      label = 'Open Inventory',
      onSelect = 'myscript:openInventory'
    },
    {
      name = 'ragdoll',
      label = 'Ragdoll',
    }
  },{
    foo = 'bar'
  })
```

### localEnt
```lua
  -- NOTE: This example uses a callback function per option

  handsUp = function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_localEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> hands_up            Hands Up
  end

  openInventory = function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_localEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> open_inventory      Open Inventory
  end

  local localId = PlayerPedId()

  target.addLocalEnt('my_localEnt_target', 'Local Entity', 'fas fa-user', localId, 10.0, false, {
    {
      name = 'hands_up',
      label = 'Hands Up',
      onSelect = handsUp
    },
    {
      name = 'open_inventory',
      label = 'Open Inventory',
      onSelect = openInventory
    },
  },{
    foo = 'bar'
  })
```

### internalPoly
```lua
  -- NOTE: This example uses a single function callback for the entire target

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> pinkcage_target  Pink Cage
    print(itemData.name,itemData.label)     --> lock_door        Lock Door
  end

  local points = {
    vector2(328.41662597656,-189.42219543457),
    vector2(347.90512084961,-196.81504821777),
    vector2(336.11190795898,-227.95924377441),
    vector2(306.11798095703,-216.42715454102),
    vector2(314.41293334961,-194.19380187988),
    vector2(324.84567260742,-198.19834899902)
  }

  local options = {
    name="pink_cage",
    minZ=51.0,
    maxZ=62.0,
    debugGrid=false,
    gridDivisions=25
  }

  target.addInternalPoly('pinkcage_target', 'Pink Cage', 'fas fa-home', points, options, onInteract, {
    {
      name = 'lock_door',
      label = 'Lock Door'
    }
  },{
    foo = 'bar'
  })
```

### internalBoxZone
```lua
  -- NOTE: This example uses a single function callback for the entire target

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> pinkcage_target  Pink Cage
    print(itemData.name,itemData.label)     --> lock_door        Lock Door
  end

  local center = vector3(328.41662597656,-189.42219543457,50.0000)
  local length = 20.0
  local width = 20.0

  local options = {
    name="box_zone",
    offset={0.0,0.0,0.0},
    scale={1.0,1.0,1.0}
  }

  target.addInternalPoly('pinkcage_target', 'Pink Cage', 'fas fa-home', center, length, width, options, onInteract, {
    {
      name = 'lock_door',
      label = 'Lock Door'
    }
  },{
    foo = 'bar'
  })
```

### externalPoly
```lua
  -- NOTE: This example uses a single function callback for the entire target

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> pinkcage_target  Pink Cage
    print(itemData.name,itemData.label)     --> lock_door        Lock Door
  end

  local polyzone = PolyZone:Create({
    vector2(328.41662597656,-189.42219543457),
    vector2(347.90512084961,-196.81504821777),
    vector2(336.11190795898,-227.95924377441),
    vector2(306.11798095703,-216.42715454102),
    vector2(314.41293334961,-194.19380187988),
    vector2(324.84567260742,-198.19834899902)
  },{
    name="pink_cage",
    minZ=51.0,
    maxZ=62.0,
    debugGrid=false,
    gridDivisions=25
  })

  local setInside = target.addExternalPoly('pinkcage_target', 'Pink Cage', 'fas fa-home', onInteract, {
    {
      name = 'lock_door',
      label = 'Lock Door'
    }
  },{
    foo = 'bar'
  })

  polyzone:onPointInOut(PolyZone.getPlayerPosition,setInside,100)
```

### externalBoxZone
```lua
  -- NOTE: This example uses a single function callback for the entire target

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> pinkcage_target  Pink Cage
    print(itemData.name,itemData.label)     --> lock_door        Lock Door
  end

  local boxzone = BoxZone:Create(vector3(123.4,345.6,678.9),20.0,20.0,{
    name="box_zone",
    offset={0.0,0.0,0.0},
    scale={1.0,1.0,1.0}
  })

  local setInside = target.addExternalBoxZone('pinkcage_target', 'Pink Cage', 'fas fa-home', onInteract, {
    {
      name = 'lock_door',
      label = 'Lock Door'
    }
  },{
    foo = 'bar'
  })

  boxzone:onPointInOut(PolyZone.getPlayerPosition,setInside,100)
```

### modelBone
```lua
  -- NOTE: This example uses a single function callback for the entire target

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> my_buffalo_target   Buffalo
    print(itemData.name,itemData.label)     --> lock_door           Lock Door
  end

  target.addModelBone('my_buffalo_target', 'Buffalo', 'fas fa-car', GetHashKey('buffalo'), GetHashKey('chassis'), 10.0, onInteract, {
    {
      name = 'lock_door',
      label = 'Lock Door'
    }
  },{
    foo = 'bar'
  })
```

### modelBones
```lua
  -- NOTE: This example uses a single function callback for the entire target

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> my_buffalo_target   Buffalo
    print(itemData.name,itemData.label)     --> lock_door           Lock Door
  end

  local bones = {
    'door_dside_f',
    'door_dside_r',
    'door_pside_f',
    'door_pside_r'
  }

  target.addModelBone('my_buffalo_target', 'buffalo', 'fas fa-car', GetHashKey('buffalo'), bones, 1.0, onInteract, {
    {
      name = 'lock_door',
      label = 'Lock Door'
    }
  },{
    foo = 'bar'
  })
```

### netEntBone
```lua
  -- NOTE: This example uses a callback event per option, and a single default callback function for any others

  AddEventHandler('myscript:handsUp',function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> hands_up          Hands Up
  end)

  AddEventHandler('myscript:openInventory',function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> open_inventory    Open Inventory
  end)

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> ragdoll           Ragdoll
  end

  local networkId = NetworkGetNetworkIdFromEntity(PlayerPedId())
  local boneName = 'IK_L_Hand'

  target.addNetEntBone('my_netEnt_target', 'Network Entity', 'fas fa-user', networkId, boneName, 10.0, onInteract, {
    {
      name = 'hands_up',
      label = 'Hands Up',
      onSelect = 'myscript:handsUp'
    },
    {
      name = 'open_inventory',
      label = 'Open Inventory',
      onSelect = 'myscript:openInventory'
    },
    {
      name = 'ragdoll',
      label = 'Ragdoll',
    }
  },{
    foo = 'bar'
  })
```

### netEntBones
```lua
  -- NOTE: This example uses a callback event per option, and a single default callback function for any others

  AddEventHandler('myscript:handsUp',function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> hands_up          Hands Up
  end)

  AddEventHandler('myscript:openInventory',function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> open_inventory    Open Inventory
  end)

  function onInteract(targetData,itemData)
    print(targetData.name,targetData.label) --> my_netEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> ragdoll           Ragdoll
  end

  local networkId = NetworkGetNetworkIdFromEntity(PlayerPedId())
  local boneNames = {'IK_L_Hand','IK_R_Hand'}

  target.addNetEntBones('my_netEnt_target', 'Network Entity', 'fas fa-user', networkId, boneNames, 10.0, onInteract, {
    {
      name = 'hands_up',
      label = 'Hands Up',
      onSelect = 'myscript:handsUp'
    },
    {
      name = 'open_inventory',
      label = 'Open Inventory',
      onSelect = 'myscript:openInventory'
    },
    {
      name = 'ragdoll',
      label = 'Ragdoll',
    }
  },{
    foo = 'bar'
  })
```

### localEntBone
```lua
  -- NOTE: This example uses a callback function per option

  handsUp = function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_localEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> hands_up            Hands Up
  end

  openInventory = function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_localEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> open_inventory      Open Inventory
  end

  local localId = PlayerPedId()
  local boneName = 'IK_L_Hand'  

  target.addLocalEnt('my_localEnt_target', 'Local Entity', 'fas fa-user', localId, boneName, 10.0, false, {
    {
      name = 'hands_up',
      label = 'Hands Up',
      onSelect = handsUp
    },
    {
      name = 'open_inventory',
      label = 'Open Inventory',
      onSelect = openInventory
    },
  },{
    foo = 'bar'
  })
```

### localEntBones
```lua
  -- NOTE: This example uses a callback function per option

  handsUp = function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_localEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> hands_up            Hands Up
  end

  openInventory = function(targetData,itemData)
    print(targetData.name,targetData.label) --> my_localEnt_target  Network Entity
    print(itemData.name,itemData.label)     --> open_inventory      Open Inventory
  end

  local localId = PlayerPedId()
  local boneNames = {'IK_L_Hand','IK_R_Hand'}

  target.addLocalEnt('my_localEnt_target', 'Local Entity', 'fas fa-user', localId, boneNames, 10.0, false, {
    {
      name = 'hands_up',
      label = 'Hands Up',
      onSelect = handsUp
    },
    {
      name = 'open_inventory',
      label = 'Open Inventory',
      onSelect = openInventory
    },
  },{
    foo = 'bar'
  })
```

### vehicle
```lua
onSelect = function(targetData, itemData)
  print(targetData.name,targetData.label) --> vehicle  Vehicle
    print(itemData.name,itemData.label)   --> blow_up  Blow Up
end

-- without vars, resource and canInteract
exports["meta_target"]:addVehicle("vehicle", "Vehicle", "fas fa-car", 2.5, onSelect, {
  {
    name = "blow_up",
    label = "Blow Up"
  }
})

-- with vars, resource, canInteract
exports["meta_target"]:addVehicle("vehicle", "Vehicle", "fas fa-car", 2.5, onSelect, {
  {
    name = "blow_up",
    label = "Blow Up"
  }
}, {
  foo = "bar"
}, GetCurrentResourceName(), function(target,pos,ent,endPos,modelHash,isNetworked,netId,targetDist,entityType)
  return true
end)
```

### remove
```lua
  target.removeTarget('pinkcage_target')
```
