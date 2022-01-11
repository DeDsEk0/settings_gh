local imgui = require('imgui')
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local fa = require 'fAwesome5'
local window = imgui.ImBool(false)

EXPORTS.type = {
    --[[INFO]]  INFO = 1,
    --[[OK]]    OK = 2,
    --[[WARN]]  WARN = 3,
    --[[ERROR]] ERROR = 4,
}

EXPORTS.type_colors = {
    --[[INFO]]  [1] = {0.24, 0.55, 0.84, 1},
    --[[OK]]    [2] = {0.14, 0.71, 0.2, 1},
    --[[WARN]]  [3] = {0.93, 0.5, 0, 1},
    --[[ERROR]] [4] = {0.73, 0.01, 0.01, 1},
}

EXPORTS.type_icons = {
    --[[INFO]]  [1] = fa.ICON_FA_INFO_CIRCLE,
    --[[OK]]    [2] = fa.ICON_FA_CHECK,
    --[[WARN]]  [3] = fa.ICON_FA_EXCLAMATION_TRIANGLE,
    --[[ERROR]] [4] = fa.ICON_FA_TIMES,
}

local list = {}

function main()
    imgui.Process = false
    window.v = true
    while true do
        wait(0)
        imgui.Process = window.v
        window.v = #list > 0
    end
end

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 20.0, font_config, fa_glyph_ranges)
    end
end

function imgui.OnDrawFrame()
    if window.v then
        local resX, resY = getScreenResolution()
        local GOVNOCODED = calcWinSize()--500, 500
        local WINSIZEX, WINSIZEY = GOVNOCODED.x, GOVNOCODED.y
        imgui.SetNextWindowPos(imgui.ImVec2(resX - WINSIZEX - 10, 10), imgui.Cond.Always)
        imgui.SetNextWindowSize(imgui.ImVec2(WINSIZEX, WINSIZEY), imgui.Cond.Always)
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0, 0, 0, 0))
        imgui.Begin('ChapoToast', window, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize)
        imgui.ShowCursor = false
        for i = 1, #list do
            if list[i] ~= nil then
                local data = list[i]
                imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 6)
                imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(EXPORTS.type_colors[data.type][1], EXPORTS.type_colors[data.type][2], EXPORTS.type_colors[data.type][3], EXPORTS.type_colors[data.type][4]))
                local logoSize = 20
                local textSize = getNotfSize(data.title, data.text)
                local minSizeX = 100
                local size = {x = logoSize + textSize.x, y = textSize.y }
                if size.x < minSizeX then size.x = minSizeX end
                local logoPos = {x = 10, y = size.y / 2 - 5}
                imgui.SetCursorPosX(WINSIZEX - size.x - 10 - logoSize)
                imgui.BeginChild(tostring(i), imgui.ImVec2(size.x + logoSize, size.y), false)
                    imgui.SetCursorPos(imgui.ImVec2(logoPos.x, logoPos.y))
                    imgui.Text(EXPORTS.type_icons[data.type])
                    imgui.SetCursorPos(imgui.ImVec2(logoPos.x + 30, logoPos.y - 4))
                    imgui.Text(data.text)
                imgui.EndChild()
                imgui.PopStyleVar()
                imgui.PopStyleColor()
                if imgui.IsItemClicked() then
                    table.remove(list, i)
                end
            end
        end
        imgui.End()
        imgui.PopStyleColor()
    end
end

function getNotfSize(title, text)
    local x, y = 100, 50
    local title, text = u8(title), u8(text)
    local size_title = imgui.CalcTextSize(title).x
    local size_text = imgui.CalcTextSize(text)
    if size_title > size_text.x then
        x = size_title
    else
        x = size_text.x
    end
    return {x = x + 10, y = y}
end

function EXPORTS.toast(text, time, type)
    if type > 0 and type < 5 then
        local text = u8(text)
        local title = ''
        local index = #list + 1
        lua_thread.create(function()
            list[index] = {title = title, text = text, type = type}
            print(tostring(list[index]))
            addOneOffSound(0.0, 0.0, 0.0, 1139)
            wait(time)
            list[index] = nil
        end)
    end
end

function calcWinSize()
    local x, y = 400, 100
    local notfs = {}
    local totalX = 0
    local biggest_x = 0
    for i = 1, #list do
        if list[i] ~= nil then
            local data = list[i]
            local s = getNotfSize(data.title, data.text)
            y = y + s.y
            if s.x > biggest_x then x = s.x end
        end
    end
    return {x = x + 100, y = y + 50}
end