---@type Zenitha.Scene
local scene = {}

local clr = {
    D = { COLOR.HEX '191E31' },
    L = { COLOR.HEX '4D67A6' },
    T = { COLOR.HEX '6F82AC' },
    LT = { COLOR.HEX 'B0CCEB' },
    cbFill = { COLOR.HEX '0B0E17' },
    cbFrame = { COLOR.HEX '6A82A7' },
}
local colorRev = false
local bindBuffer
MusicPlayer = false
local playingBgmTitle = 'Philosophyz'
local playingBgmLength = 2202.8
local playingBgmLengthStr = '22:02.8'
local songList = {
    f0 = "Dr Ocelot - cares",
    f1 = "Dr Ocelot - my lord",
    f2 = "Dr Ocelot - Hotel Zenit",
    f3 = "Dr Ocelot - The sentence is empty",
    f4 = "Dr Ocelot - administration",
    f5 = "Dr Ocelot - Imaginal memory",
    f6 = "Dr Ocelot - voice",
    f7 = "Dr Ocelot - Secret Chemistry",
    f8 = "Dr Ocelot - sequence",
    f9 = "Dr Ocelot - The table was broken",
    f10 = "petrtech - God's power",
    tera = "Dr Ocelot - Rapid fireball",
    f1ex = "Dr Ocelot - Internal registration",

    f0r = "Dr Ocelot - Waiting for justice",
    f1r = "Dr Ocelot - Act suddenly",
    f2r = "Dr Ocelot - They rested",
    f3r = "Dr Ocelot - This is a parkour game.",
    f4r = "Dr Ocelot - Fierce struggle",
    f5r = "Dr Ocelot - The future will come back.",
    f6r = "Dr Ocelot - Deming's testimony",
    f7r = "Dr Ocelot - secret service",
    f8r = "Dr Ocelot - I didn't think so",
    f9r = "Dr Ocelot - Just a victim",
    f10r = "petrtech - Pseudopotheosis",
    terar = "Dr Ocelot - Paul Hale exaggerates",

    fomg = "Ronezkj15 - Chronic depression",
}
local bgmColors = {
    f1 = { COLOR.HEX 'E46A24' },
    f2 = { COLOR.HEX 'F1CC80' },
    f3 = { COLOR.HEX '804200' },
    f4 = { COLOR.HEX '8E1D1D' },
    f5 = { COLOR.HEX 'B8C1C1' },
    f6 = { COLOR.HEX 'EAA380' },
    f7 = { COLOR.HEX '70B5E1' },
    f8 = { COLOR.HEX 'F16A77' },
    f9 = { COLOR.HEX '3DA878' },
    f10 = { COLOR.HEX 'AD80F5' },
    f1r = { COLOR.HEX 'E46A24' },
    f2r = { COLOR.HEX 'F1CC80' },
    f3r = { COLOR.HEX '804200' },
    f4r = { COLOR.HEX '8E1D1D' },
    f5r = { COLOR.HEX 'B8C1C1' },
    f6r = { COLOR.HEX 'EAA380' },
    f7r = { COLOR.HEX '70B5E1' },
    f8r = { COLOR.HEX 'F16A77' },
    f9r = { COLOR.HEX '3DA878' },
    f10r = { COLOR.HEX 'AD80F5' },
    fomg = { COLOR.HEX '00437A' },
}

local function refreshWidgets()
    scene.widgetList.account:setVisible(not MusicPlayer)
    scene.widgetList.album:setVisible(MusicPlayer)
    scene.widgetList.mp_prev5s:setVisible(MusicPlayer)
    scene.widgetList.mp_next5s:setVisible(MusicPlayer)
    scene.widgetList.mp_noLoop:setVisible(MusicPlayer)
    scene.widgetList.changeAboutme:setVisible(not MusicPlayer)
    scene.widgetList.changeName:setVisible(not MusicPlayer)
    scene.widgetList.export:setVisible(not MusicPlayer)
end

local function refreshSongInfo()
    if not MusicPlayer then return end
    playingBgmTitle = BgmPlaying == 'f0' and RevMusicMode() and songList.f0r or songList[BgmPlaying] or "Rewrite"
    playingBgmLength = BGM.getDuration()
    playingBgmLengthStr = STRING.time_simp(playingBgmLength)
    GAME.refreshRPC()
end

function scene.load()
    MSG.clear()
    bindBuffer = nil
    SetMouseVisible(true)
    if GAME.anyRev ~= colorRev then
        colorRev = GAME.anyRev
        for _, C in next, clr do
            C[1], C[3] = C[3], C[1]
        end
    end
    TASK.unlock('changeName')
    TASK.unlock('changeAboutme')
    TASK.unlock('export')
    TASK.unlock('import')
    TASK.unlock('rebind_control')
    refreshWidgets()
    refreshSongInfo()
end

-- function scene.unload()
--     SaveStat()
-- end

local bindHint = {
    "Bible cards-1",
    "Bible cards-2",
    "Bible cards-3",
    "Bible cards-4",
    "Bible cards-5",
    "Bible cards-6",
    "Bible cards-7",
    "Bible cards-8",
    "Bible cards-9",
    "Bible cards-1 (2nd)",
    "Bible cards-2 (2nd)",
    "Bible cards-3 (2nd)",
    "Bible cards-4 (2nd)",
    "Bible cards-5 (2nd)",
    "Bible cards-6 (2nd)",
    "Bible cards-7 (2nd)",
    "Bible cards-8 (2nd)",
    "Bible cards-9 (2nd)",
    "to break up",
    "changes",
    "There is no CLK",
    "Click the button on the right",
}

local KBisDown = love.keyboard.isDown
local function isLegalKey(key)
    if key:find('ctrl') or key:find('alt') or key == 'f1' or key == 'f2' or key == 'tab' or key == '`' then
        SFX.play('finessefault', .626)
        return false
    elseif key:match('^f%d%d?$') then
        return false
    else
        return true
    end
end
function scene.keyDown(key, isRep)
    if isRep then return true end
    if KBisDown('lctrl', 'rctrl') and (key:match('^f%d%d?$') and tonumber(key:match('%d+')) <= 10 or key == 'o' or key == 'pause' or key == 'break') then
        if key == 'o' then key = 'fomg' end
        if key == 'pause' or key == 'break' then key = 'tera' end
        TASK.removeTask_code(Task_MusicEnd)
        if KBisDown('lshift', 'rshift') then key = key .. 'r' end
        PlayBGM(key, true)
        if not MusicPlayer then
            MusicPlayer = true
            refreshWidgets()
        end
        refreshSongInfo()
    elseif key == 'escape' or (key == 'f1' and not bindBuffer) then
        if bindBuffer then
            bindBuffer = nil
            MSG('dark', "Some links have expired")
            SFX.play('staffwarning')
        else
            SFX.play('menuclick')
            SCN.back('none')
        end
    elseif bindBuffer and isLegalKey(key) then
        if TABLE.find(bindBuffer, key) then
            MSG('dark', "Do not copy the key!", 1)
            SFX.play('finessefault')
        else
            table.insert(bindBuffer, key)
            if #bindBuffer >= 22 then
                STAT.keybind = bindBuffer
                bindBuffer = nil
                SaveStat()
                MSG('dark', "Original link has been updated.")
                SFX.play('social_notify_major')
            else
                SFX.play('irs')
            end
        end
    elseif MusicPlayer then
        if key == 'left' then
            TASK.removeTask_code(Task_MusicEnd)
            BGM.set('all', 'seek', math.max(BGM.tell() - (KBisDown('lctrl', 'rctrl') and 26 or 5), 0))
        elseif key == 'right' then
            TASK.removeTask_code(Task_MusicEnd)
            BGM.set('all', 'seek', math.min(BGM.tell() + (KBisDown('lctrl', 'rctrl') and 26 or 5), BGM.getDuration()))
        elseif key == 'home' then
            TASK.removeTask_code(Task_MusicEnd)
            BGM.set('all', 'seek', 0)
        elseif key == 'end' then
            TASK.new(Task_MusicEnd, true)
        elseif key == 'space' then
            BgmLooping, BgmNeedSkip = false, false
        end
        return true
    end
    ZENITHA.setCursorVis(true)
    return true
end

scene.resize = refreshWidgets

-- Panel size
local w, h = 900, 830
local baseX, baseY = (1600 - w) / 2, (1000 - h) / 2

local gc = love.graphics
local gc_replaceTransform = gc.replaceTransform
local gc_setColor, gc_rectangle, gc_print, gc_printf = gc.setColor, gc.rectangle, gc.print, gc.printf
local gc_ucs_move, gc_ucs_back = GC.ucs_move, GC.ucs_back
local gc_setAlpha, gc_mRect, gc_mStr = GC.setAlpha, GC.mRect, GC.mStr

local function drawSliderComponents(y, title, t1, t2, value)
    gc_ucs_move('m', 0, y)
    gc_setColor(0, 0, 0, .26)
    gc_mRect('fill', w / 2, 0, w - 40, 65, 5)
    gc_mRect('fill', w - 90, 0, 123, 48, 3)
    FONT.set(30)
    gc_setColor(clr.T)
    gc_print(title, 40, -20, 0, .85, 1)
    gc_setAlpha(.42)
    gc_print(t1, 326, 5, 0, .5)
    gc_printf(t2, w - 355, 5, 355, 'right', 0, .5)
    gc_setColor(clr.T)
    gc_mStr(value, w - 100, -20)
    gc_setColor(clr.L)
    gc_print("%", w - 60, -20, 0, .85, 1)
    gc_ucs_back()
end

function scene.draw()
    DrawBG(STAT.bgBrightness)

    local t = love.timer.getTime()
    local playTime = 0
    local beatLen = 0
    local beatBar = 0
    if MusicPlayer then
        playTime = BGM.tell()
        beatLen = 60 / BgmData[BgmPlaying].bpm
        beatBar = BgmData[BgmPlaying].bar
    end

    -- Panel
    gc_replaceTransform(SCR.xOy)
    gc.translate(800 - w / 2, 510 - h / 2)
    if MusicPlayer then
        local dy = MATH.clamp(6 * math.sin(playTime / beatLen * 3.1416), -2.6, 2.6)
        gc.translate(0, dy)
        SCN.curScroll = -dy
    end
    gc_setColor(clr.D)
    gc_rectangle('fill', 0, 0, w, h)
    gc_setColor(0, 0, 0, .26)
    gc_rectangle('fill', 3, 3, w - 6, h - 6)
    gc_setColor(1, 1, 1, .1)
    gc_rectangle('fill', 0, 0, w, 3)
    gc_setColor(1, 1, 1, .04)
    gc_rectangle('fill', 0, 3, 3, h + 3)

    -- Sliders
    drawSliderComponents(310, "Limited products", "be silent (F3)", "from now on (F3)", STAT.sfx)
    drawSliderComponents(380, "Music", "be silent (F4)", "from now on (F4)", STAT.bgm)
    drawSliderComponents(520, "Show shortcut key", "Darkness (F5)", "Seen. (F6)", STAT.cardBrightness)
    drawSliderComponents(590, "PG Cos", "Darkness (F7)", "Seen. (F8)", STAT.bgBrightness)

    -- Keybind
    if bindBuffer then
        FONT.set(30)
        gc_print("Press key for...", 610, 680, 0, .872)
        gc_print(bindHint[#bindBuffer + 1], 610, 710, 0, .872)
    end

    -- Music player info
    if MusicPlayer then
        local sx, len = 260, 570

        FONT.set(30)
        gc_setColor(clr.T)
        gc_print(STRING.time_simp(playTime), sx, 249, 0, .626)
        gc_print(playingBgmLengthStr, sx + len - 45, 249, 0, .626)

        local data = BgmData[BgmPlaying]
        if BgmLooping then
            if data.loop[1] == 0 then
                gc_print('D.C.', sx + len * data.loop[2] / playingBgmLength, 235, 0, .3)
            else
                gc_print('S', sx + len * data.loop[1] / playingBgmLength, 235, 0, .3)
                gc_print('D.S.', sx + len * data.loop[2] / playingBgmLength, 235, 0, .3)
            end
        end

        gc_setColor(clr.L)
        gc_rectangle('fill', sx, 246, len, 4)
        if BgmPlaying == 'tera' or BgmPlaying == 'terar' then
            gc_setColor(COLOR.rainbow_light(2.6 * t))
        else
            gc_setColor(bgmColors[BgmPlaying] or clr.LT)
        end
        gc_rectangle('fill', sx, 246, len * playTime / playingBgmLength, 4)

        gc_mStr(playingBgmTitle, sx + len / 2, 200)
        gc_setColor(1, 1, 1, .35 - .26 * math.sin(playTime / (beatBar * beatLen) * 3.1416))
        gc_mStr(playingBgmTitle, sx + len / 2, 200)
        gc_setColor(clr.LT)
        gc_setAlpha(.26)
        gc_printf(data.meta, sx + len / 2, 256, 2 * len, 'center', 0, .42, .42, len)

        if BgmNeedSkip then
            local alpha = .26 + .62 * (-2.6 * t % 1)
            gc_setColor(COLOR.C)
            gc_setAlpha(alpha)
            gc_mRect('fill', sx + len * BgmNeedSkip[1] / playingBgmLength, 248, 2, 9)
            gc_setColor(COLOR.O)
            gc_setAlpha(alpha)
            gc_mRect('fill', sx + len * BgmNeedSkip[2] / playingBgmLength, 248, 2, 9)
        end
    end

    -- Top bar & title
    gc_replaceTransform(SCR.xOy_u)
    gc_setColor(clr.D)
    gc_rectangle('fill', -1300, 0, 2600, 70)
    gc_setColor(clr.L)
    gc_setAlpha(.626)
    gc_rectangle('fill', -1300, 70, 2600, 3)
    gc_replaceTransform(SCR.xOy_ul)
    gc_setColor(clr.L)
    FONT.set(50)
    if GAME.anyRev then
        gc_print("Stopping", 15, 68, 0, 1, -1)
    else
        gc_print("Stopping", 15, 0)
    end

    -- Bottom bar & text
    gc_replaceTransform(SCR.xOy_d)
    gc_setColor(clr.D)
    gc_rectangle('fill', -1300, 0, 2600, -50)
    gc_setColor(clr.L)
    gc_setAlpha(.626)
    gc_rectangle('fill', -1300, -50, 2600, -3)
    gc_replaceTransform(SCR.xOy_dl)
    gc_setColor(clr.L)
    FONT.set(30)
    gc_print("Adjust settings for better clicks", 15, -45, 0, .85, 1)
end

scene.widgetList = {
    -- ALBUM
    WIDGET.new {
        name = 'album',
        type = 'text', alignX = 'left',
        text = "album",
        color = clr.T,
        fontSize = 50,
        x = baseX + 30, y = baseY + 50,
    },
    WIDGET.new {
        name = 'mp_prev5s', type = 'button',
        x = baseX + 230, y = baseY + 115, w = 380, h = 50,
        color = clr.L,
        fontSize = 30, textColor = clr.LT, text = "5 seconds",
        sound_hover = 'menutap',
        onClick = function()
            TASK.removeTask_code(Task_MusicEnd)
            BGM.set('all', 'seek', math.max(BGM.tell() - 5, 0))
        end,
        visibleFunc = FALSE,
    },
    WIDGET.new {
        name = 'mp_next5s', type = 'button',
        x = baseX + 640, y = baseY + 115, w = 380, h = 50,
        color = clr.L,
        fontSize = 30, textColor = clr.LT, text = "5 more seconds",
        sound_hover = 'menutap',
        onClick = function()
            TASK.removeTask_code(Task_MusicEnd)
            BGM.set('all', 'seek', math.min(BGM.tell() + 5, BGM.getDuration()))
        end,
        visibleFunc = FALSE,
    },
    WIDGET.new {
        name = 'mp_noLoop', type = 'button',
        x = baseX + 230, y = baseY + 185, w = 380, h = 50,
        color = clr.L,
        fontSize = 30, textColor = clr.LT, text = "The bottom is not protected.",
        sound_hover = 'menutap',
        onClick = function()
            BgmLooping, BgmNeedSkip = false, false
        end,
        visibleFunc = FALSE,
    },

    -- ACCOUNT
    WIDGET.new {
        name = 'account',
        type = 'text', alignX = 'left',
        text = "Invoice",
        color = clr.T,
        fontSize = 50,
        x = baseX + 30, y = baseY + 50,
    },
    WIDGET.new {
        name = 'changeName', type = 'button',
        x = baseX + 230, y = baseY + 115, w = 380, h = 50,
        color = clr.L,
        fontSize = 30, textColor = clr.LT, text = "Change user.",
        sound_hover = 'menutap',
        sound_release = 'menuclick',
        onClick = function()
            -- MSG.clear()
            local newName = CLIPBOARD.get()
            if #newName == 0 then
                MSG('dark', "There is no content in the archive.")
                return
            end
            newName = newName:trim()
            if TASK.lock('changeName', 2.6) then
                SFX.play('notify')
                MSG('dark', "Do you want to change your name on the bulletin board? ('" .. newName .. "')\nClick again to confirm", 2.6)
                return
            end
            TASK.unlock('changeName')
            repeat
                newName = newName:upper()
                if #newName < 3 or #newName > 16 or newName:find('[^A-Z0-9_%-]') then
                    MSG('dark', "The new name must be 3 to 16 characters long and contain: A-Z, 0-9, -, _")
                    break
                end
                if newName == STAT.uid then
                    MSG('dark', "New name, old name.")
                    break
                end
                if newName:match('^ANON[-_]') then
                    MSG('dark', "ANON cannot be assigned a new name.")
                    break
                end
                STAT.uid = newName
                SaveStat()
                SFX.play('supporter')
                MSG('dark', "Your name has been changed " .. STAT.uid)
                if SCN.cur == 'stat' then RefreshProfile() end
                IssueAchv('identity')
                return
            until true
            SFX.play('staffwarning')
        end,
        visibleFunc = TRUE,
    },
    WIDGET.new {
        name = 'changeAboutme', type = 'button',
        x = baseX + 640, y = baseY + 115, w = 380, h = 50,
        color = clr.L,
        fontSize = 30, textColor = clr.LT, text = "Let's change that",
        sound_hover = 'menutap',
        sound_release = 'menuclick',
        onClick = function()
            -- MSG.clear()
            local newText = CLIPBOARD.get()
            if #newText == 0 then
                MSG('dark', "There is no content in the archive.")
                return
            end
            newText = newText:trim()
            if TASK.lock('changeAboutme', 2.6) then
                SFX.play('notify')
                MSG('dark', "Want to change your About Me text in the clipboard text?\nClick again to confirm", 2.6)
                return
            end
            TASK.unlock('changeAboutme')
            repeat
                if type(newText) ~= 'string' then
                    MSG('dark', "There is no content in the archive.")
                    break
                end
                if #newText < 1 or #newText > 260 or newText:find('[^\32-\126]') then
                    MSG('dark', "Text must be 1 to 260 characters long and contain visible ASCII characters.")
                    break
                end
                if newText == STAT.aboutme then
                    MSG('dark', "The new language is similar to the old.")
                    break
                end
                STAT.aboutme = newText
                SaveStat()
                SFX.play('supporter')
                MSG('dark', "The article has been updated.")
                if SCN.cur == 'stat' then RefreshProfile() end
                IssueAchv('identity')
                return
            until true
            SFX.play('staffwarning')
        end,
        visibleFunc = TRUE,
    },
    WIDGET.new {
        name = 'export', type = 'button',
        x = baseX + 230, y = baseY + 185, w = 380, h = 50,
        color = clr.L,
        fontSize = 30, textColor = clr.LT, text = "Overseas development",
        sound_hover = 'menutap',
        sound_release = 'menuclick',
        onClick = function()
            -- MSG.clear()
            if TestMode then
                SFX.play('staffwarning')
                MSG('dark', "You are not a good person")
                return
            end
            if TASK.lock('export', 2.6) then
                SFX.play('notify')
                MSG('dark', "Want to share your progress on the board?\nClick again to confirm", 2.6)
                return
            end
            TASK.unlock('export')
            CLIPBOARD.set(STRING.packTable(STAT) .. ',' .. STRING.packTable(BEST) .. ',' .. STRING.packTable(ACHV))
            MSG('dark', "Excellent delivery.")
            SFX.play('social_notify_minor')
        end,
        visibleFunc = TRUE,
    },
    WIDGET.new {
        name = 'import', type = 'button',
        x = baseX + 640, y = baseY + 185, w = 380, h = 50,
        color = clr.L,
        fontSize = 30, textColor = clr.LT, text = "The importance of development",
        sound_hover = 'menutap',
        sound_release = 'menuclick',
        onClick = function()
            -- MSG.clear()
            local data = CLIPBOARD.get():filterASCII():trim()
            if #data <= 26 then
                if data == '' then
                    MSG('dark', "There is no content in the archive.")
                elseif data == 'cmd' then
                    SFX.play('cutin_superlobby', 1, 0, Tone(-2))
                    SCN.go('_console')
                elseif data == 'cooldown' then
                    STAT.startCD = not STAT.startCD
                    MSG('dark', "Restart the cooler: " .. (STAT.startCD and "ON" or "OFF"))
                    SFX.play(STAT.startCD and 'social_online' or 'social_offline')
                elseif data == 'fps' then
                    STAT.showFPS = not STAT.showFPS
                    MSG('dark', "Show FPS. " .. (STAT.showFPS and "ON" or "OFF"))
                    SFX.play(STAT.showFPS and 'social_online' or 'social_offline')
                    ZENITHA.setShowFPS(STAT.showFPS)
                elseif data == 'old_hitbox' then
                    STAT.oldHitbox = not STAT.oldHitbox
                    MSG('dark', "Reinforce the previous section: " .. (STAT.oldHitbox and "ON" or "OFF"))
                    SFX.play(STAT.oldHitbox and 'social_online' or 'social_offline')
                    TEXTS.version:set(SYSTEM .. (STAT.oldHitbox and " T" or " V") .. (require 'version'.verStr))
                elseif data == 'true_ending' then
                    SFX.play('warp')
                    SCN.go('ending', 'warp')
                elseif data == 'test' then
                    TestMode = true
                    SFX.play('maintenance')
                elseif data == 'mp' or data == 'music' then
                    if not BGM.isPlaying() or MusicPlayer then return end
                    MusicPlayer = true
                    refreshWidgets()
                    refreshSongInfo()
                elseif data == 'dev' then
                    MSG('dark', OverDevProgressText)
                elseif songList[data] then
                    TASK.removeTask_code(Task_MusicEnd)
                    PlayBGM(data, true)
                    if not MusicPlayer then
                        MusicPlayer = true
                        refreshWidgets()
                    end
                    refreshSongInfo()
                elseif data == UAN then
                    _G[UAN]()
                    SFX.play('social_dm')
                else
                    local msg = "Invalid code '" .. data .. "' the world"
                    if MATH.roll(.26) then
                        msg = msg .. "\n" .. TABLE.getRandom {
                            "clarification 'cmd'",
                            "clarification 'cooldown'",
                            "clarification 'fps'",
                            "clarification 'old_hitbox'",
                            "clarification 'test'",
                            MATH.coin("clarification 'mp'", "clarification 'music'"),
                            "clarification 'f" .. STAT.maxFloor .. "'",
                            STAT.clicker and "clarification 'true_ending'" or nil,
                        }
                    end
                    MSG('dark', msg)
                    SFX.play('staffwarning')
                    return
                end
                LOG('info', "salary: " .. data)
                return
            end
            if TASK.lock('import', 4.2) then
                SFX.play('notify')
                MSG('dark',
                    "Import data from text into element?\nThey must have food; all your progress will be lost forever!\nClick again to confirm",
                    4.2)
                return
            end
            TASK.unlock('import')
            local d3 = STRING.split(data, ',')
            local suc1, res1 = pcall(STRING.unpackTable, d3[1])
            local suc2, res2 = pcall(STRING.unpackTable, d3[2])
            local suc3, res3
            if d3[3] then
                suc3, res3 = pcall(STRING.unpackTable, d3[3])
            else
                suc3, res3 = true, {}
            end
            if not suc1 or not suc2 or not suc3 then
                MSG('dark', "Invalid file type")
                SFX.play('staffwarning')
                return
            elseif res1.version > STAT.version then
                MSG('error', "Data from later versions will not be included.\nRaise your game!")
                SFX.play('staffwarning')
                return
            elseif res1.mod ~= 'vanilla' then
                MSG('dark', "You cannot import data from a modified version")
                SFX.play('staffwarning')
                return
            end
            TABLE.update(STAT, res1)
            BEST, ACHV = res2, res3
            setmetatable(BEST.highScore, Metatable.best_highscore)
            GAME.refreshLockState()
            setmetatable(BEST.speedrun, Metatable.best_speedrun)
            if STAT.system ~= SYSTEM then
                STAT.system = SYSTEM
                IssueAchv('zenith_relocation')
            end
            Initialize(true)
            MSG('dark', "Widespread!")
            SFX.play('social_notify_major')
        end,
    },

    -- AUDIO
    WIDGET.new {
        type = 'text', alignX = 'left',
        text = "AUDIO",
        color = clr.T,
        fontSize = 50,
        x = baseX + 30, y = baseY + 250,
    },
    WIDGET.new {
        type = 'slider',
        x = baseX + 240 + 85, y = baseY + 310, w = 400,
        axis = { 0, 100, 10 },
        frameColor = 'dD', fillColor = clr.D,
        disp = function() return STAT.sfx end,
        code = function(value)
            STAT.sfx = value
            ApplySettings()
        end,
        sound_drag = 'rotate',
    },
    WIDGET.new {
        type = 'slider',
        x = baseX + 240 + 85, y = baseY + 380, w = 400,
        axis = { 0, 100, 10 },
        frameColor = 'dD', fillColor = clr.D,
        disp = function() return STAT.bgm end,
        code = function(value)
            STAT.bgm = value
            ApplySettings()
        end,
        sound_drag = 'rotate',
    },

    -- VIDEO
    WIDGET.new {
        type = 'text', alignX = 'left',
        text = "video",
        color = clr.T,
        fontSize = 50,
        x = baseX + 30, y = baseY + 460,
    },
    WIDGET.new {
        type = 'slider',
        x = baseX + 240 + 85, y = baseY + 520, w = 400,
        axis = { 80, 100, 5 },
        frameColor = 'dD', fillColor = clr.D,
        disp = function() return STAT.cardBrightness end,
        code = function(value) STAT.cardBrightness = value end,
        sound_drag = 'rotate',
    },
    WIDGET.new {
        type = 'slider',
        x = baseX + 240 + 85, y = baseY + 590, w = 400,
        axis = { 30, 80, 10 },
        frameColor = 'dD', fillColor = clr.D,
        disp = function() return STAT.bgBrightness end,
        code = function(value) STAT.bgBrightness = value end,
        sound_drag = 'rotate',
    },
    WIDGET.new {
        type = 'checkBox',
        fillColor = clr.cbFill,
        frameColor = clr.cbFrame,
        textColor = clr.T, text = "It supports the light  (F9)",
        x = baseX + 55, y = baseY + 670,
        disp = function() return STAT.bg end,
        code = WIDGET.c_pressKey 'f9',
    },
    WIDGET.new {
        type = 'checkBox',
        fillColor = clr.cbFill,
        frameColor = clr.cbFrame,
        textColor = clr.T, text = "The power of the stars  (F10)",
        x = baseX + 55, y = baseY + 730,
        disp = function() return not STAT.syscursor end,
        code = WIDGET.c_pressKey 'f10',
    },
    WIDGET.new {
        type = 'checkBox',
        fillColor = clr.cbFill,
        frameColor = clr.cbFrame,
        textColor = clr.T, text = "Delivery service  (F11)",
        x = baseX + 55, y = baseY + 790,
        disp = function() return STAT.fullscreen end,
        code = WIDGET.c_pressKey 'f11',
    },

    -- KEYBIND
    WIDGET.new {
        name = 'keybind', type = 'button',
        x = baseX + 740, y = baseY + 790, w = 260, h = 50,
        color = clr.L,
        fontSize = 30, textColor = clr.LT, text = "OPENING",
        sound_hover = 'menutap',
        sound_release = 'menuclick',
        onClick = function()
            if bindBuffer then
                bindBuffer = {}
                SFX.play('b2bcharge_danger', .8)
            else
                -- MSG.clear()
                if TASK.lock('rebind_control', 12) then
                    SFX.play('notify')
                    MSG('dark', {
                            "Current mandatory key:\n" ..
                            table.concat(TABLE.sub(STAT.keybind, 1, 9), ', ') .. "\n" ..
                            table.concat(TABLE.sub(STAT.keybind, 10, 18), ', ') .. "\n" ..
                            "to break up: " .. STAT.keybind[19] .. "\n" ..
                            "changes: " .. STAT.keybind[20] .. "\n" ..
                            "Left/right click: " .. STAT.keybind[21] .. ", " .. STAT.keybind[22] .. "\n",
                            COLOR.F, "Click to resume\n",
                            COLOR.LD, "(F1-F12 'Ctrl Alt Tab not supported)"
                        },
                        12
                    )
                else
                    TASK.unlock('rebind_control')
                    bindBuffer = {}
                    SFX.play('b2bcharge_danger', .8)
                end
            end
        end,
    },

    WIDGET.new {
        name = 'back', type = 'button',
        pos = { 0, 0 }, x = 60, y = 140, w = 160, h = 60,
        color = { .15, .15, .15 },
        sound_hover = 'menutap',
        fontSize = 30, text = "    BACK", textColor = 'DL',
        onClick = function() love.keypressed('escape') end,
    },
}

return scene
