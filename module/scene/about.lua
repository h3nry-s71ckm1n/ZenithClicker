---@type Zenitha.Scene
local scene = {}

local scroll, scroll1 = 0, 0
local maxScroll = 620

local clr = {
    D = { COLOR.HEX '1F1F1F' },
    L = { COLOR.HEX '656565' },
}

AboutText = GC.newText(FONT.get(70))
local lines = {}

local tempY = 0

local function addText(text, x, y, scale, wraplimit)
    if type(text) == 'string' then text = { COLOR.L, text } end
    scale = scale or 1
    local w = (wraplimit or 900) / scale
    AboutText:addf(text, w, 'center', x - w / 2 * scale, tempY + y, 0, scale)
end

local function addSection(y)
    tempY = y
    table.insert(lines, y)
end

addText("Decorative", 40, 20)
addText("click", 80, 95)

addSection(220)

addText(STRING.trimIndent [[
    A card for free travel in this new country.
    Play with different sticks, improve your skills and earn CR.
    - Did it click?
]], 0, 23, .3, 800)

addSection(350)

-- THE TEAM

addText({ COLOR.O, "DEVICE" }, 0, 20, .3)

local function addMajorCredit(x, y, color, name, role, desc)
    addText({ color, name }, x, y, .5)
    addText({ COLOR.LD, role }, x, y + 40, .26)
    if desc then addText({ COLOR.LD, desc }, x, y + 60, .2) end
end

addMajorCredit(0000, 060, { COLOR.HEX '80CCFF' }, "MRZ", "Designers and manufacturers", "Programming, game design and general development")
addMajorCredit(-160, 160, { COLOR.HEX 'B966E3' }, "PETRTECH", "Music", "F10 music")
addMajorCredit(0160, 160, { COLOR.HEX '9DBCFF' }, "RONEZKJ15", "Music", "Other songs")
addMajorCredit(-320, 260, { COLOR.HEX 'DDFF80' }, "DJ  ASRIEL", "Visual Arts:", "Creating game scenes and graphics")
addMajorCredit(0000, 260, { COLOR.HEX '77DD66' }, "CREEPERCRAFTYT", "Visual Arts:", "Design blueprints and create maps")
addMajorCredit(0320, 260, { COLOR.HEX '5792FF' }, "ZYRIXIA", "Visual Arts:", "Symbol size")
addMajorCredit(-320, 360, { COLOR.HEX 'DD99FF' }, "OSK", "Designers and manufacturers", "Original game: TETR.IO")
addMajorCredit(0000, 360, { COLOR.HEX 'FF99CC' }, "DOKTOROCELOT", "Sound and music", "From TETR.IO and Decorative click")
addMajorCredit(0320, 360, { COLOR.HEX '3A66DD' }, "GARBO", "Interact and learn with the world", "Original game: TETR.IO")
addMajorCredit(-320, 460, { COLOR.HEX 'F880F0' }, "FLOWERLING", "Word processing")
addMajorCredit(0000, 460, { COLOR.HEX 'B7A0FF' }, "FLOMIKEL", "Creation and the world", "Workbook and international plan")
addMajorCredit(0320, 460, { COLOR.HEX 'FFE590' }, "MATTMAYUGA", "Word processing")
addMajorCredit(-320, 560, { COLOR.HEX '8BD6C3' }, "OBSIDIAN", "One sentence", "This is a good story.")
addMajorCredit(0000, 560, { COLOR.HEX 'FF82F0' }, "SPRITZY SHEEP", "global project", "Many international houses")
addMajorCredit(0320, 560, { COLOR.HEX 'E9C6FF' }, "FCSPLAYZ", "other questions")

addSection(1010)

addText({ COLOR.O, "Beautiful" }, 0, 20, .3)

addMajorCredit(-390, 62, COLOR.L, "LARGEONIONS", "country 1-5")
addMajorCredit(-130, 62, COLOR.L, "S. ZHANG", "country 6-8")
addMajorCredit(0130, 62, COLOR.L, "LAUREN SHENG", "country 9-10")
addMajorCredit(0390, 62, COLOR.L, "RICMAN", "A staple in the card industry")

addSection(1160)

addText({
    COLOR.O, "the source ",
    COLOR.L, "ADRIAN FRUTIGER (D-DIN-PRO) ",
    COLOR.O, "& ",
    COLOR.L, "MOONIAK (ABHAYALIBRE)"
}, 0, 20, .32)

addText({
    COLOR.O, "Author of several ACHV symbols ",
    COLOR.L, "LORC, DELAPOUITE, QUOTING ",
    COLOR.O, "FROM ",
    COLOR.L, "GAME-ICONS.NET"
}, 0, 60, .32)

addSection(1270)

addText({ COLOR.O, "Everything has an effect" }, 0, 20, .3)

addText({
    table.concat({
        "5HAN",
        "ADRIAN FRUTIGER",
        "BARON",
        "CREEPERCRAFTYT",
        "DELAPOUITE",
        "DJ ASRIEL",
        "DOKTOROCELOT",
        "FCSPLAYZ",
        "FLOMIKEL",
        "FLOWERLING",
        "GAMETILDEAD",
        "GARBO",
        "LARGEONIONS",
        "LAUREN SHENG",
        "LORC",
        "MATTMAYUGA",
        "MOONIAK",
        "MRZ",
        "OBSIDIAN",
        "OSK",
        "PETRTECH",
        "QUOTING",
        "RICMAN",
        "RONEZKJ15",
        -- "RTXTILE",
        "S. ZHANG",
        "SPRITZY SHEEP",
        "THE_111THBLITZER",
        "TIZAGO",
        "WAH",
        "ZYRIXIA",
    }, ",  ")
}, 0, 60, .26)

local timer
function scene.load()
    MSG.clear()
    timer = 0
    SetMouseVisible(true)
    scroll, scroll1 = 0, -620
end

function scene.mouseMove(_, _, _, dy)
    if love.mouse.isDown(1, 2) then
        scroll = MATH.clamp(scroll - dy, 0, maxScroll)
    end
end

function scene.touchMove(_, _, _, dy)
    scroll = MATH.clamp(scroll - dy, 0, maxScroll)
end

function scene.keyDown(key, isRep)
    if isRep then return true end
    if key == 'escape' or key == 'f2' then
        SFX.play('menuclick')
        SCN.back('none')
    end
    ZENITHA.setCursorVis(true)
    return true
end

function scene.wheelMove(_, dy)
    scroll = MATH.clamp(scroll - dy * 42, 0, maxScroll)
end

function scene.update(dt)
    if timer < 26 then
        timer = timer + dt
        if timer > 26 then
            IssueAchv('respectful')
        end
    end
    if GAME.mod.EX == 2 then scroll = math.min(scroll + .26, maxScroll) end
    local y0 = scroll1
    scroll1 = MATH.expApproach(scroll1, scroll, dt * 26)
    GAME.bgH = math.max(GAME.bgH + (y0 - scroll1) / 355, 0)
    GAME.height = GAME.bgH
end

local gc = love.graphics
local gc_replaceTransform, gc_translate = gc.replaceTransform, gc.translate
local gc_setColor, gc_rectangle, gc_print = gc.setColor, gc.rectangle, gc.print
local gc_setAlpha, gc_setLineWidth = GC.setAlpha, GC.setLineWidth
local gc_draw, gc_mDraw = GC.draw, GC.mDraw
local gc_line = GC.line
function scene.draw()
    DrawBG(26)

    gc_replaceTransform(SCR.xOy_u)
    gc_translate(0, 100 - scroll1)

    gc_setColor(1, 1, 1)
    local icon, kx, ky
    if GAME.mod.EX > 0 then
        icon = TEXTURE.logo_old
        kx, ky = .5, .5
    else
        icon = TEXTURE.logo
        kx, ky = .3, .3
    end
    if GAME.anyRev then ky = -ky end
    gc_mDraw(icon, -170, 100, 0, kx, ky)
    gc_draw(AboutText)

    gc_setColor(1, 1, 1, .2)
    gc_setLineWidth(0.5)
    for i = 1, #lines do
        gc_line(-600, lines[i], 600, lines[i])
    end

    -- Grid
    if love.keyboard.isDown('space') then
        gc_setColor(1, 1, 0)
        FONT.set(30)
        for x = -600, 600 - 100, 100 do
            for y = 0, 1300 - 100, 100 do
                gc_rectangle('line', x, y, 100, 100)
                gc_print(x .. ',' .. y, x + 2.6, y, 0, .355)
            end
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
        gc_print("ABOUT", 15, 68, 0, 1, -1)
    else
        gc_print("ABOUT", 15, 0)
    end

    -- Bottom bar & thanks
    gc_replaceTransform(SCR.xOy_d)
    gc_setColor(clr.D)
    gc_rectangle('fill', -1300, 0, 2600, -50)
    gc_setColor(clr.L)
    gc_setAlpha(.626)
    gc_rectangle('fill', -1300, -50, 2600, -3)
    gc_replaceTransform(SCR.xOy_dl)
    gc_setColor(clr.L)
    FONT.set(30)
    gc_print("Thanks for playing Decorative click!", 15, -45, 0, .85, 1)
end

scene.widgetList = {
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
