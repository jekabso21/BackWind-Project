local RedEM = exports["redem_roleplay"]:RedEM()

RegisterServerEvent('bw-stables:storeHorse')
AddEventHandler('bw-stables:storeHorse', function(model, id, location)
    local src = source

    local Player = RedEM.GetPlayer(source)
    local cid = Player.citizenid
    --check if the horse is already stored in table by checking last_id
    exports.oxmysql:fetch('SELECT * FROM horses WHERE last_id = ?', {id}, function(result)
        if result[1] ~= nil then
            exports.oxmysql:execute('UPDATE horses SET last_id = ? WHERE location = ?', {id, location})
        else
            local name = lib.callback.await('bw-stables:createname', src)
            exports.oxmysql:execute('INSERT INTO horses (name, model, owner_cid, last_id, location) VALUES (?, ?, ?, ?, ?)', {name, model, cid, id, location})
        end
    end)
end)
RegisterServerEvent("bw-stables:updateid")
AddEventHandler("bw-stables:updateid", function(oldid, newid)
    exports.oxmysql:execute('UPDATE horses SET last_id = ? WHERE last_id = ?', {newid, oldid})
end)


-- Server Callbacks --
RedEM.RegisterCallback('bw-stables:gethorses', function(source, cb)
    local src = source
    local Player = RedEM.GetPlayer(source)
    local cid = Player.citizenid
    local loc = lib.callback.await('bw-stables:getuserloc', src)
    exports.oxmysql:fetch('SELECT * FROM horses WHERE `owner_cid`=? AND `location`=?;', {cid, loc}, function(result)
        cb(result)
    end)
end)

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end