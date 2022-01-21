--êòî îòêðîåò êîä òîò ïåäèê
script_version('3')
require 'lib.moonloader'
local imgui = require('imgui')
local encoding = require 'encoding'
encoding.default = 'CP1251' 
u8 = encoding.UTF8
local inicfg = require 'inicfg'
imgui.ToggleButton = require('imgui_addons').ToggleButton
local bruh = require ('moonloader').audiostream_state
local notf = import('imgui_notf.lua')
local event = require 'lib.samp.events'
local dlstatus = require('moonloader').download_status
local mem = require 'memory'
local fa = require 'fAwesome5' -- ICONS LIST: https://fontawesome.com/v5.15/icons?d=gallery&s=solid&m=free
local logo_url = "https://raw.githubusercontent.com/DeDsEk0/settings_gh/main/gh_logo.jpg"
local logo_path = getWorkingDirectory() .. "/config/gh_logo.jpg"
local themes_url = 'https://raw.githubusercontent.com/DeDsEk0/settings_gh/main/imgui_themes.lua'
local themes_path = getWorkingDirectory()..'/GettoHelper/imgui_themes.lua'

function update()
    local raw = 'https://raw.githubusercontent.com/DeDsEk0/settings_gh/main/update.json'
    local dlstatus = require('moonloader').download_status
    local requests = require('requests')
    local f = {}
    function f:getLastVersion()
        local response = requests.get(raw)
        if response.status_code == 200 then
            return decodeJson(response.text)['last']
        else
            return 'UNKNOWN'
        end
    end
    function f:download()
        local response = requests.get(raw)
        if response.status_code == 200 then
            downloadUrlToFile(decodeJson(response.text)['url'], thisScript().path, function (id, status, p1, p2)
                print('Ñêà÷èâàþ '..decodeJson(response.text)['url']..' â '..thisScript().path)
                if status == dlstatus.STATUSEX_ENDDOWNLOAD then
                    sampAddChatMessage('Ñêðèïò îáíîâëåí, ïåðåçàãðóçêà...', -1)
                    thisScript():reload()
                end
            end)
        else
            sampAddChatMessage('Îøèáêà, íåâîçìîæíî óñòàíîâèòü îáíîâëåíèå, êîä: '..response.status_code, -1)
        end
    end
    return f
end

local script_vers = 1
local mx, my = getScreenResolution()
local delay = 500
local hp_state = false

local fa = require 'fAwesome5' -- ICONS LIST: https://fontawesome.com/v5.15/icons?d=gallery&s=solid&m=free

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true
        
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end

--˜˜˜˜˜
bike = {[481] = true, [509] = true, [510] = true}
moto = {[448] = true, [461] = true, [462] = true, [463] = true, [468] = true, [471] = true, [521] = true, [522] = true, [523] = true, [581] = true, [586] = true}
local directIni = 'gh_settings.ini'
local mainIni = inicfg.load({
    settings = {
        command = '/gh',
        window = false,
        onewindow = false,
        twowindow = false,
        threewindow = false,
        server = 0,
        many_drug = 1,
        sbiv_drug = 1,
        acctive_drug = true,
        acctive_armour = true,
        acctive_mask = true,
        RP_drug = true,
        allow_bunnyhop = true,
        acctive_phone = true,
        acctive_lock = true,
        acctive_style = true,
        auto_bike = true,
        auto_time = true,
        beg = true,
        say_kill = '',
        acctive_kill = true,
        command_heal = '/healme',
        hp_heal = '40',
        acctive_heal = true,
        acctive_scroll = true,
        number_scroll = 2,
        scroll = 1,
        fast_run = true,
        anti_stan = true,
        automask = true,
        combo_eat = 0,
        eat_acctive = true,
        sbiv_eat = 1,
        say_eat = 'íÿìêà',
        acctive_eat = true,
        auto_c = true,
        noradio = true,
        auto_login = true,
        password = '961835',
        gm_car = true,
        nobike = true,
        extra_ws = true,
        fixalt = true,
        style = 1,
    },
}, directIni)

if not doesFileExist(getWorkingDirectory()..'/config/gh_settings.ini') then -- â êîâû÷êàõ íàçâàíèå èíè ôàéëèêà èëè ÷å òàì ïóòü
    inicfg.save(mainIni, directIni)
end

--window
local command = imgui.ImBuffer(''..mainIni.settings.command, 100)
local window = imgui.ImBool(mainIni.settings.window)
local onewindow = imgui.ImBool(mainIni.settings.onewindow)
local twowindow = imgui.ImBool(mainIni.settings.twowindow)
local threewindow = imgui.ImBool(mainIni.settings.threewindow)
--element
local combo_server = imgui.ImInt(mainIni.settings.server)
local many_drug = imgui.ImInt(mainIni.settings.many_drug)
local sbiv_drug = imgui.ImInt(mainIni.settings.sbiv_drug)
local acctive_drug = imgui.ImBool(mainIni.settings.acctive_drug)
local RP_drug = imgui.ImBool(mainIni.settings.RP_drug)
local acctive_armour = imgui.ImBool(mainIni.settings.acctive_armour)
local acctive_mask = imgui.ImBool(mainIni.settings.acctive_mask)
local allow_bunnyhop = imgui.ImBool(mainIni.settings.allow_bunnyhop)
local acctive_phone = imgui.ImBool(mainIni.settings.acctive_phone)
local acctive_lock = imgui.ImBool(mainIni.settings.acctive_lock)
local acctive_style = imgui.ImBool(mainIni.settings.acctive_style)
local auto_bike = imgui.ImBool(mainIni.settings.auto_bike)
local beg = imgui.ImBool(mainIni.settings.beg)
local say_kill = imgui.ImBuffer(''..mainIni.settings.say_kill, 100)
local acctive_kill = imgui.ImBool(mainIni.settings.acctive_kill)
local command_heal = imgui.ImBuffer(''..mainIni.settings.command_heal, 100)
local hp_heal = imgui.ImBuffer(''..mainIni.settings.hp_heal, 10)
local acctive_heal = imgui.ImBool(mainIni.settings.acctive_heal)
local acctive_scroll = imgui.ImBool(mainIni.settings.acctive_scroll)
local number_scroll = imgui.ImBuffer(''..mainIni.settings.number_scroll, 2)
local scroll = imgui.ImInt(mainIni.settings.scroll)
local pt = tonumber(mainIni.settings.number_scroll)
local fast_run = imgui.ImBool(mainIni.settings.fast_run)
local anti_stan = imgui.ImBool(mainIni.settings.anti_stan)
local automask = imgui.ImBool(mainIni.settings.automask)
local combo_eat = imgui.ImInt(mainIni.settings.combo_eat)
local acctive_eat = imgui.ImBool(mainIni.settings.acctive_eat)
local sbiv_eat = imgui.ImInt(mainIni.settings.sbiv_eat)
--local say_eat = imgui.ImBuffer(''..mainIni.settings.say_eat, 100)
local auto_c = imgui.ImBool(mainIni.settings.auto_c)
local noradio = imgui.ImBool(mainIni.settings.noradio)
local auto_login = imgui.ImBool(mainIni.settings.auto_login)
local password = imgui.ImBuffer(''..mainIni.settings.password, 100)
local gm_car = imgui.ImBool(mainIni.settings.gm_car)
local nobike = imgui.ImBool(mainIni.settings.nobike)
local extra_ws = imgui.ImBool(mainIni.settings.extra_ws)
local fixalt = imgui.ImBool(mainIni.settings.fixalt)
local style = imgui.ImInt(mainIni.settings.style)

function main()
    while not isSampAvailable() do wait(200) end
    local lastver = update():getLastVersion()
    if thisScript().version ~= lastver then
        sampRegisterChatCommand('scriptupd', function()
            update():download()
        end)
        --notf.addNotification('Âûøëî îáíîâëåíèå ñêðèïòà\n('..thisScript().version..' -> '..lastver..') \nÂâåäèòå /scriptupd äëÿ îáíîâëåíèÿ!', 5)
        update_window()
    end
    notf.addNotification('GettoHelper Loaded!\nVersion:'..thisScript().version..'. \nAuthor: Lill_Chich', 5)
    menu = 4
    sampRegisterChatCommand('usedrugs',use_drug)
    sampRegisterChatCommand('proverka', function()
        sampAddChatMessage('îëåã õàðîø', -1)
    end)
    imgui.Process = false
    window.v = false
    onewindow.v = false
    sound = loadAudioStream('moonloader//resource//bruh.mp3')
    while true do
        wait(0)
        health = getCharHealth(PLAYER_PED)
        imgui.Process = window.v
        if not isKeyDown(VK_MENU) or not isKeyDown(VK_RBUTTON) or not isKeyDown(VK_LBUTTON) then
            fast_no_alt = true
        end
        if acctive_drug.v then
            if isKeyJustPressed(0x58) then
                if many_drug.v == 1 then
                    if RP_drug.v then
                            sampSendChat('/me ñúåë êîíôåòó áåëîãî öâåòà')
                        end
                        sampSendChat('/usedrugs 1')
                        if sbiv_drug.v == 1 then
                            sampSendChat('q')
                        end
                    end
                    if  many_drug.v == 2 then
                        if RP_drug.v then
                            sampSendChat('/me ñúåë êîíôåòó áåëîãî öâåòà')
                            wait(500)
                        end
                        sampSendChat(u8:decode('/usedrugs 2'))
                        if sbiv_drug.v == 1 then
                            sampSendChat('q')
                        end
                    end
                    if many_drug.v == 3 then
                        if RP_drug.v then
                            sampSendChat('/me ñúåë êîíôåòó áåëîãî öâåòà')
                            wait(500)
                        end
                        sampSendChat(u8:decode('/usedrugs 2'))
                        if sbiv_drug.v == 1 then
                            sampSendChat('q')
                        end
                    end
                end
            end

        if acctive_armour.v then
            if testCheat('arm') and not sampIsCursorActive() and not imgui.Process == true then
                sampSendChat('/armour')
            end
        end
        if acctive_mask.v then
            if testCheat("msk") and not sampIsCursorActive() and not imgui.Process == true then
                sampSendChat('/mask')
            end
        end
        if acctive_phone.v then
            if isKeyJustPressed(VK_P) and not sampIsCursorActive() and not imgui.Process == true then
                sampSendChat('/phone')
            end
        end
        if acctive_lock.v then
            if isKeyJustPressed(VK_L) and not sampIsCursorActive() and not imgui.Process == true then
                sampSendChat('/lock')
            end
        end
        if acctive_style.v then
            if testCheat('sly') and not sampIsCursorActive() and not imgui.Process == true then
                sampSendChat('/style')
            end
        end
        if beg.v then
			mem.setint8(0xB7CEE4, 1)
		end
        if getAmmoInClip() == pt then
            if acctive_scroll.v then
                if scroll.v == 1 then
                    setCurrentCharWeapon(PLAYER_PED, 0)
                    sampForceOnfootSync()
                    wait(200)
                    setCurrentCharWeapon(PLAYER_PED, 24)
                end
                if scroll.v == 2 then
                    setAudioStreamState(sound, bruh.PLAY)
                    printStringNow('Scroll!!!', 1000)
                end
            end
        end
        if auto_bike.v then
            if isCharOnAnyBike(PLAYER_PED) and isKeyCheckAvailable() and isKeyDown(0xA0) then
                if bike[getCarModel(storeCarCharIsInNoSave(PLAYER_PED))] then
                    setGameKeyState(16, 255)
                    wait(10)
                    setGameKeyState(16, 0)
                elseif moto[getCarModel(storeCarCharIsInNoSave(PLAYER_PED))] then
                    setGameKeyState(1, -128)
                    wait(10)
                    setGameKeyState(1, 0)
                end
            end
        end
        if anti_stan.v then
            setCharUsesUpperbodyDamageAnimsOnly(PLAYER_PED, 0)
        else
            setCharUsesUpperbodyDamageAnimsOnly(PLAYER_PED, 1)
        end
        if fast_run.v then
            if isCharOnFoot(PLAYER_PED) and isKeyDown(0x31) and isKeyCheckAvailable() then
                setGameKeyState(16, 256)
                wait(10)
                setGameKeyState(16, 0)
            elseif isCharInWater(PLAYER_PED) and isKeyDown(0x31) and isKeyCheckAvailable() then
                setGameKeyState(16, 256)
                wait(10)
                setGameKeyState(16, 0)
            end
        end
        if isCharInAnyCar(PLAYER_PED) then
            noradio_func()
            if gm_car.v then
                setCarProofs(storeCarCharIsInNoSave(PLAYER_PED), true, true, true, true, true)
            end
        end
        if isCharOnAnyBike(PLAYER_PED) then
            if nobike.v then
                setCharCanBeKnockedOffBike(PLAYER_PED, true)
            else
                setCharCanBeKnockedOffBike(PLAYER_PED, false)
            end
        end
        if extra_ws.v then
            mem.write(0x5109AC, 235, 1, true)
            mem.write(0x5109C5, 235, 1, true)
            mem.write(0x5231A6, 235, 1, true)
            mem.write(0x52322D, 235, 1, true)
            mem.write(0x5233BA, 235, 1, true)
        end
        if acctive_heal.v then
            hp_number = getCharHealth(PLAYER_PED)
            if hp_number < tonumber(mainIni.settings.hp_heal) then
                sampSendChat(u8:decode(mainIni.settings.command_heal))
                hp_state = true
            end
        end
        mainIni.settings.command = command.v
        mainIni.settings.auto_bike = auto_bike.v
        mainIni.settings.combo_server = combo_server.v
        mainIni.settings.many_drug = many_drug.v
        mainIni.settings.sbiv_drug = sbiv_drug.v
        mainIni.settings.acctive_drug = acctive_drug.v
        mainIni.settings.RP_drug = RP_drug.v
        mainIni.settings.acctive_armour = acctive_armour.v
        mainIni.settings.acctive_mask = acctive_mask.v
        mainIni.settings.allow_bunnyhop = allow_bunnyhop.v
        mainIni.settings.acctive_phone = acctive_phone.v
        mainIni.settings.acctive_lock = acctive_lock.v
        mainIni.settings.acctive_style = acctive_style.v
        mainIni.settings.beg = beg.v
        mainIni.settings.say_kill = say_kill.v
        mainIni.settings.acctive_kill = acctive_kill.v
        mainIni.settings.acctive_heal = acctive_heal.v
        mainIni.settings.command_heal = command_heal.v
        mainIni.settings.acctive_scroll = acctive_scroll.v
        mainIni.settings.number_scroll = number_scroll.v
        mainIni.settings.scroll = scroll.v
        mainIni.settings.fast_run = fast_run.v
        mainIni.settings.anti_stan = anti_stan.v
        mainIni.settings.automask = automask.v
        mainIni.settings.combo_eat = combo_eat.v
        mainIni.settings.acctive_eat = acctive_eat.v
        mainIni.settings.sbiv_eat = sbiv_eat.v
        mainIni.settings.auto_c = auto_c.v
        mainIni.settings.noradio = noradio.v
        mainIni.settings.auto_login = auto_login.v
        mainIni.settings.password = password.v
        mainIni.settings.gm_car = gm_car.v
        mainIni.settings.nobike = nobike.v
        mainIni.settings.extra_ws = extra_ws.v
        mainIni.settings.fixalt = fixalt.v
        mainIni.settings.style = style.v
        mainIni.settings.hp_heal = hp_heal.v
        inicfg.save(mainIni, directIni)
    end
end
local themes = {
    colorThemes = {u8"Äåôîëòû÷ òåìà", u8"Ò¸ìíî-Îðàíæåâàÿ òåìà", u8"Ôèîëåòîâàÿ òåìà", u8"Ñåðàÿ òåìà", u8"Ðîçîâàÿ"},

    SwitchColorTheme = function(theme)
        local style = imgui.GetStyle()
        local colors = style.Colors
        local clr = imgui.Col
        local ImVec4 = imgui.ImVec4

        style.IndentSpacing = 25.0
        style.WindowRounding = 15.0
        style.ChildWindowRounding = 8.0
        style.FrameRounding = 6
        style.ItemSpacing = imgui.ImVec2(12, 8)
        style.ScrollbarSize = 15.0
        style.ScrollbarRounding = 15.0
        style.GrabMinSize = 15.0
        style.GrabRounding = 7.0
        style.WindowPadding = imgui.ImVec2(15, 15)
        style.FramePadding = imgui.ImVec2(5, 5)
        style.ItemInnerSpacing = imgui.ImVec2(8, 6)

        if theme == 1 or theme == nil then
            colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
            colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
            colors[clr.WindowBg] = ImVec4(0.11, 0.15, 0.17, 1.00)
            colors[clr.ChildWindowBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.PopupBg] = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.Border] = ImVec4(0.43, 0.43, 0.50, 0.50)
            colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.FrameBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.FrameBgHovered] = ImVec4(0.12, 0.20, 0.28, 1.00)
            colors[clr.FrameBgActive] = ImVec4(0.09, 0.12, 0.14, 1.00)
            colors[clr.TitleBg] = ImVec4(0.09, 0.12, 0.14, 0.65)
            colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.51)
            colors[clr.TitleBgActive] = ImVec4(0.08, 0.10, 0.12, 1.00)
            colors[clr.MenuBarBg] = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.ScrollbarBg] = ImVec4(0.02, 0.02, 0.02, 0.39)
            colors[clr.ScrollbarGrab] = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
            colors[clr.ScrollbarGrabActive] = ImVec4(0.09, 0.21, 0.31, 1.00)
            colors[clr.ComboBg] = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.CheckMark] = ImVec4(0.28, 0.56, 1.00, 1.00)
            colors[clr.SliderGrab] = ImVec4(0.28, 0.56, 1.00, 1.00)
            colors[clr.SliderGrabActive] = ImVec4(0.37, 0.61, 1.00, 1.00)
            colors[clr.Button] = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.ButtonHovered] = ImVec4(0.28, 0.56, 1.00, 1.00)
            colors[clr.ButtonActive] = ImVec4(0.06, 0.53, 0.98, 1.00)
            colors[clr.Header] = ImVec4(0.20, 0.25, 0.29, 0.55)
            colors[clr.HeaderHovered] = ImVec4(0.26, 0.59, 0.98, 0.80)
            colors[clr.HeaderActive] = ImVec4(0.26, 0.59, 0.98, 1.00)
            colors[clr.ResizeGrip] = ImVec4(0.26, 0.59, 0.98, 0.25)
            colors[clr.ResizeGripHovered] = ImVec4(0.26, 0.59, 0.98, 0.67)
            colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
            colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
            colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
            colors[clr.PlotLines] = ImVec4(0.61, 0.61, 0.61, 1.00)
            colors[clr.PlotLinesHovered] = ImVec4(1.00, 0.43, 0.35, 1.00)
            colors[clr.PlotHistogram] = ImVec4(0.90, 0.70, 0.00, 1.00)
            colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
            colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
            colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
        elseif theme == 2 then
            colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
            colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
            colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
            colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
            colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
            colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
            colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
            colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
            colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
            colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
            colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
            colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
            colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
            colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
            colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
            colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
            colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
            colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
            colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
            colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
            colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
            colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
            colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
            colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
            colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
            colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
            colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
            colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
            colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
            colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
            colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
            colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
            colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
            colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
            colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
        elseif theme == 3 then
            colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00)
            colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00)
            colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90)
            colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30)
            colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00)
            colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68)
            colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45)
            colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35)
            colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78)
            colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57)
            colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00)
            colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31)
            colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78)
            colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00)
            colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00)
            colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24)
            colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44)
            colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86)
            colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00)
            colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76)
            colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86)
            colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20)
            colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78)
            colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75)
            colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59)
            colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00)
            colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63)
            colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63)
            colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00)
            colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43)
            colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35)
        elseif theme == 4 then
            colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
            colors[clr.TextDisabled]           = ImVec4(1.00, 1.00, 1.00, 1.00)
            colors[clr.WindowBg]               = ImVec4(0.00, 0.00, 0.00, 1.00)
            colors[clr.ChildWindowBg]          = ImVec4(0.00, 0.00, 0.00, 1.00)
            colors[clr.PopupBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
            colors[clr.Border]                 = ImVec4(0.82, 0.77, 0.78, 1.00)
            colors[clr.BorderShadow]           = ImVec4(0.35, 0.35, 0.35, 0.66)
            colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 0.28)
            colors[clr.FrameBgHovered]         = ImVec4(0.68, 0.68, 0.68, 0.67)
            colors[clr.FrameBgActive]          = ImVec4(0.79, 0.73, 0.73, 0.62)
            colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
            colors[clr.TitleBgActive]          = ImVec4(0.46, 0.46, 0.46, 1.00)
            colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 1.00)
            colors[clr.MenuBarBg]              = ImVec4(0.00, 0.00, 0.00, 0.80)
            colors[clr.ScrollbarBg]            = ImVec4(0.00, 0.00, 0.00, 0.60)
            colors[clr.ScrollbarGrab]          = ImVec4(1.00, 1.00, 1.00, 0.87)
            colors[clr.ScrollbarGrabHovered]   = ImVec4(1.00, 1.00, 1.00, 0.79)
            colors[clr.ScrollbarGrabActive]    = ImVec4(0.80, 0.50, 0.50, 0.40)
            colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 0.99)
            colors[clr.CheckMark]              = ImVec4(0.99, 0.99, 0.99, 0.52)
            colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 0.42)
            colors[clr.SliderGrabActive]       = ImVec4(0.76, 0.76, 0.76, 1.00)
            colors[clr.Button]                 = ImVec4(0.51, 0.51, 0.51, 0.60)
            colors[clr.ButtonHovered]          = ImVec4(0.68, 0.68, 0.68, 1.00)
            colors[clr.ButtonActive]           = ImVec4(0.67, 0.67, 0.67, 1.00)
            colors[clr.Header]                 = ImVec4(0.72, 0.72, 0.72, 0.54)
            colors[clr.HeaderHovered]          = ImVec4(0.92, 0.92, 0.95, 0.77)
            colors[clr.HeaderActive]           = ImVec4(0.82, 0.82, 0.82, 0.80)
            colors[clr.Separator]              = ImVec4(0.73, 0.73, 0.73, 1.00)
            colors[clr.SeparatorHovered]       = ImVec4(0.81, 0.81, 0.81, 1.00)
            colors[clr.SeparatorActive]        = ImVec4(0.74, 0.74, 0.74, 1.00)
            colors[clr.ResizeGrip]             = ImVec4(0.80, 0.80, 0.80, 0.30)
            colors[clr.ResizeGripHovered]      = ImVec4(0.95, 0.95, 0.95, 0.60)
            colors[clr.ResizeGripActive]       = ImVec4(1.00, 1.00, 1.00, 0.90)
            colors[clr.CloseButton]            = ImVec4(0.45, 0.45, 0.45, 0.50)
            colors[clr.CloseButtonHovered]     = ImVec4(0.70, 0.70, 0.90, 0.60)
            colors[clr.CloseButtonActive]      = ImVec4(0.70, 0.70, 0.70, 1.00)
            colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
            colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00)
            colors[clr.PlotHistogram]          = ImVec4(1.00, 1.00, 1.00, 1.00)
            colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00)
            colors[clr.TextSelectedBg]         = ImVec4(1.00, 1.00, 1.00, 0.35)
            colors[clr.ModalWindowDarkening]   = ImVec4(0.88, 0.88, 0.88, 0.35)
        
        elseif theme == 5 then
            colors[clr.FrameBg]                = ImVec4(0.46, 0.11, 0.29, 1.00)
            colors[clr.FrameBgHovered]         = ImVec4(0.69, 0.16, 0.43, 1.00)
            colors[clr.FrameBgActive]          = ImVec4(0.58, 0.10, 0.35, 1.00)
            colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
            colors[clr.TitleBgActive]          = ImVec4(0.61, 0.16, 0.39, 1.00)
            colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            colors[clr.CheckMark]              = ImVec4(0.94, 0.30, 0.63, 1.00)
            colors[clr.SliderGrab]             = ImVec4(0.85, 0.11, 0.49, 1.00)
            colors[clr.SliderGrabActive]       = ImVec4(0.89, 0.24, 0.58, 1.00)
            colors[clr.Button]                 = ImVec4(0.46, 0.11, 0.29, 1.00)
            colors[clr.ButtonHovered]          = ImVec4(0.69, 0.17, 0.43, 1.00)
            colors[clr.ButtonActive]           = ImVec4(0.59, 0.10, 0.35, 1.00)
            colors[clr.Header]                 = ImVec4(0.46, 0.11, 0.29, 1.00)
            colors[clr.HeaderHovered]          = ImVec4(0.69, 0.16, 0.43, 1.00)
            colors[clr.HeaderActive]           = ImVec4(0.58, 0.10, 0.35, 1.00)
            colors[clr.Separator]              = ImVec4(0.69, 0.16, 0.43, 1.00)
            colors[clr.SeparatorHovered]       = ImVec4(0.58, 0.10, 0.35, 1.00)
            colors[clr.SeparatorActive]        = ImVec4(0.58, 0.10, 0.35, 1.00)
            colors[clr.ResizeGrip]             = ImVec4(0.46, 0.11, 0.29, 0.70)
            colors[clr.ResizeGripHovered]      = ImVec4(0.69, 0.16, 0.43, 0.67)
            colors[clr.ResizeGripActive]       = ImVec4(0.70, 0.13, 0.42, 1.00)
            colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.78, 0.90, 0.35)
            colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            colors[clr.TextDisabled]           = ImVec4(0.60, 0.19, 0.40, 1.00)
            colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
            colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
            colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.ComboBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.Border]                 = ImVec4(0.49, 0.14, 0.31, 1.00)
            colors[clr.BorderShadow]           = ImVec4(0.49, 0.14, 0.31, 0.00)
            colors[clr.MenuBarBg]              = ImVec4(0.15, 0.15, 0.15, 1.00)
            colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
            colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
            colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
            colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
        end

    end
}

function getStyle()
    if tonumber(mainIni.settings.style) == 1 then themes.SwitchColorTheme(1) end
    if tonumber(mainIni.settings.style) == 2 then themes.SwitchColorTheme(2) end
    if tonumber(mainIni.settings.style) == 3 then themes.SwitchColorTheme(3) end
    if tonumber(mainIni.settings.style) == 4 then themes.SwitchColorTheme(4) end
    if tonumber(mainIni.settings.style) == 5 then themes.SwitchColorTheme(5) end
end

function imgui.Ques(text)
    imgui.TextDisabled("(?)")
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.TextUnformatted(u8(text))
        imgui.EndTooltip()
    end
end

function imgui.OnDrawFrame()
    getStyle()

    if window.v then
        imgui.SetNextWindowPos(imgui.ImVec2(mx/2, my/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(920, 620), imgui.Cond.FirstUseEver)
        imgui.Begin('Getto Helper || by Lill_Chich', window, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
            img = imgui.CreateTextureFromFile('moonloader\\config\\gh_logo.jpg')
            imgui.BeginChild('##window1', imgui.ImVec2(280, 590))
                imgui.Text(' ')
                imgui.Text('    ')
                imgui.SameLine()
                if imgui.Button(fa.ICON_FA_CHILD..u8'  Ãëàâíîå Ìåíþ', imgui.ImVec2(230,130)) then
                    menu = 4
                end
                imgui.Text('    ')
                imgui.SameLine()
                if imgui.Button(fa.ICON_FA_FILE_ALT..u8'  Îñíîâíîå', imgui.ImVec2(230,130)) then
                    menu = 1
                end
                imgui.Text('    ')
                imgui.SameLine()
                if imgui.Button(fa.ICON_FA_EXCLAMATION_TRIANGLE..u8'  ×èòû    ', imgui.ImVec2(230,130)) then
                    menu = 2
                end
                imgui.Text('    ')
                imgui.SameLine()
                if imgui.Button(fa.ICON_FA_COGS..u8'  Íàñòðîéêè', imgui.ImVec2(230,130)) then
                    menu = 3
                end
            imgui.EndChild()
            imgui.SameLine()
            imgui.BeginChild('##window2', imgui.ImVec2(600,590))
                if menu == 1 then
                    imgui.Text(' ')
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.PushItemWidth(100)
                    imgui.Combo(u8'Ñåðâåðà', combo_server, {'Phenix', 'Tucson', 'Scottdale', 'Chandler', 'Brainburg', 'Sait Rose', 'Mesa', 'Red Rock', 'Yuma', 'Surprise', 'Prescott', 'Glendale', 'Kingman', 'Winslow', 'Payson', 'Gilbert', 'Show-Low', 'Casa Grande'})
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Text(u8'×òîáû óçíàòü ïðàâèëà ÃÅÒÒÎ âàøåãî ñåðâåðà íàæìèòå íà êíîïêó -->')
                    imgui.SameLine()
                    if imgui.Button(u8'Ïðàâèëà') then
                        if combo_server.v  == 0 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3624540/"))
                        end
                        if combo_server.v  == 1 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/2865756/"))
                        end
                        if combo_server.v  == 2 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3886258/"))
                        end
                        if combo_server.v  == 3 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3121557/"))
                        end
                        if combo_server.v  == 4 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/1756770/"))
                        end
                        if combo_server.v  == 5 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/1187085/"))
                        end
                        if combo_server.v  == 6 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3783479/"))
                        end
                        if combo_server.v  == 7 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/2744257/"))
                        end
                        if combo_server.v  == 8 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/1703078/"))
                        end
                        if combo_server.v  == 9 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3196406/"))
                        end
                        if combo_server.v  == 10 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3644741/"))
                        end
                        if combo_server.v  == 11 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/1945524/"))
                        end
                        if combo_server.v  == 12 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/2445345/"))
                        end
                        if combo_server.v  == 13 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3764116/"))
                        end
                        if combo_server.v  == 14 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3785785/"))
                        end
                        if combo_server.v  == 15 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3125228/"))
                        end
                        if combo_server.v  == 16 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3894479/"))
                        end
                        if combo_server.v  == 17 then
                            os.execute(('explorer.exe "%s"'):format("https://forum.arizona-rp.com/threads/3898282/"))
                        end
                    end
                    --íàðêîòèêè
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Íàðêîòèêè áóäóò èñïîëüçîâàòüñÿ íàæàâ íà êëàâèøó X')
                    imgui.SameLine()
                    imgui.Text(u8'Íàðêîòèêè')
                    imgui.SameLine()
                    imgui.ToggleButton('##1', acctive_drug)
                    if acctive_drug.v then
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.Text(u8'Ñêîëüêî èñïîëüçîâàòü:')
                        imgui.SameLine()
                        imgui.RadioButton(u8'1', many_drug, 1)
                        imgui.SameLine()
                        imgui.RadioButton(u8'2', many_drug, 2)
                        imgui.SameLine()
                        imgui.RadioButton(u8'3', many_drug, 3)
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.Text(u8'Ñáèâàòü:')
                        imgui.SameLine()
                        imgui.RadioButton(u8'Äà', sbiv_drug, 1)
                        imgui.SameLine()
                        imgui.RadioButton(u8'Íåò', sbiv_drug, 2)
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.Text(u8'RP îòûãðîâêà')
                        imgui.SameLine()
                        imgui.ToggleButton('##2', RP_drug)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áóäåò èñïîëüçîâàòüñÿ íàæàòèåì êëàâèø A + R + M')
                    imgui.SameLine()
                    imgui.Text(u8'Àðìîð')
                    imgui.SameLine()
                    imgui.ToggleButton('##3', acctive_armour)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áóäåò èñïîëüçîâàòüñÿ íàæàòèåì êëàâèø M + S + K')
                    imgui.SameLine()
                    imgui.Text(u8'Ìàñêà')
                    imgui.SameLine()
                    imgui.ToggleButton('##4', acctive_mask)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áóäåò èñïîëüçîâàòüñÿ íàæàòèåì êëàâèøè P')
                    imgui.SameLine()
                    imgui.Text(u8'Òåëåôîí')
                    imgui.SameLine()
                    imgui.ToggleButton('##5', acctive_phone)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áóäåò èñïîëüçîâàòüñÿ íàæàòèåì êëàâèøè L')
                    imgui.SameLine()
                    imgui.Text(u8'Çàêðûòü àâòî')
                    imgui.SameLine()
                    imgui.ToggleButton('##6', acctive_lock)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áóäåò ïèñàòü â ÷àò ïðè óáèéñòâå')
                    imgui.SameLine()
                    imgui.Text('KillSay')
                    imgui.SameLine()
                    imgui.ToggleButton('##7', acctive_kill)
                    if acctive_kill.v then
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.PushItemWidth(200)
                        imgui.InputText(u8'##8', say_kill)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Text(u8'Ïîëíûé ðàçãîí íà ìîòî íà ØÈÔÒ')
                    imgui.SameLine()
                    imgui.ToggleButton('##9', auto_bike)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áóäåò êóøàòü åñëè áóäåòå ãîëîäíû')
                    imgui.SameLine()
                    imgui.Text(u8'ÀâòîÅäà')
                    imgui.SameLine()
                    imgui.ToggleButton('##10', acctive_eat)
                    if acctive_eat.v then
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.PushItemWidth(150)
                        imgui.Combo('##11', combo_eat, {u8'Æàðåííàÿ ðûáà', u8'Æàðåííîå ìÿñî', u8'×èïñû'})
                        imgui.SameLine()
                        imgui.RadioButton(u8'Ñáèâàòü', sbiv_eat, 1)
                        imgui.SameLine()
                        imgui.RadioButton(u8'Íå ñáèâàòü', sbiv_eat, 2)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Óáèðàåò ðàäèî')
                    imgui.SameLine()
                    imgui.Text('NoRadio')
                    imgui.SameLine()
                    imgui.ToggleButton('##12', noradio)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Èãðà íå áóäåò ñâîðà÷èâàòüñÿ ïðè íàæàòèå ALT + ENTER')
                    imgui.SameLine()
                    imgui.Text('FixAlt+Enter')
                    imgui.SameLine()
                    imgui.ToggleButton('##22', fixalt)
                end
                if menu == 2 then
                    imgui.Text(' ')
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áûñòðûé Áåã/Ïëàâàíèå - w + 1')
                    imgui.SameLine()
                    imgui.Text('Fast run/swim')
                    imgui.SameLine()
                    imgui.ToggleButton('##13', fast_run)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Íå áóäåò óñòàâàòü')
                    imgui.SameLine()
                    imgui.Text(u8'Áåñêîíå÷íûé áåã')
                    imgui.SameLine()
                    imgui.ToggleButton('##14', beg)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Õèë áóäåò èñïîëüçîâàòüñÿ, åñëè õï áóäåò <= 40')
                    imgui.SameLine()
                    imgui.Text('AutoHeal')
                    imgui.SameLine()
                    imgui.ToggleButton('##15', acctive_heal)
                    if acctive_heal.v then
                        imgui.SameLine()
                        imgui.PushItemWidth(100)
                        imgui.InputText(u8'Êîìàíäà ïðè õèëå', command_heal)
                        imgui.SameLine()
                        imgui.PushItemWidth(50)
                        imgui.InputText(u8'Ïðè ÕÏ', hp_heal)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áóäåò àâòîìàòè÷åñêè ïåðåçàðÿæàòü îðóæåå')
                    imgui.SameLine()
                    imgui.Text('AutoScroll')
                    imgui.SameLine()
                    imgui.ToggleButton(u8'##16', acctive_scroll)
                    if acctive_scroll.v then
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.PushItemWidth(50)
                        imgui.InputText(u8'Ïîñëå ñêîëüêè ñêðîëëèòü', number_scroll)
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.RadioButton(u8'Ñêðîëèòü', scroll, 1)
                        imgui.SameLine()
                        imgui.Ques('Ïðåäóïðåäèòü - âûâåäèòñÿ íà ýêðàí è çâóê ÷òî íàäî ñêðîëëèòü')
                        imgui.SameLine()
                        imgui.RadioButton(u8'Ïðåäóïðåäèòü', scroll, 2)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Áåñêîíå÷íîå çäîðîâüå ìàøèíû')
                    imgui.SameLine()
                    imgui.Text(u8'GMCar')
                    imgui.SameLine()
                    imgui.ToggleButton('##17', gm_car)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Ïåðñîíàæ íå áóäåò ïàäàòü ñ âåëèêà/ìîòèêà')
                    imgui.SameLine()
                    imgui.Text('NoBike')
                    imgui.SameLine()
                    imgui.ToggleButton('##18', nobike)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Íå áóäåò âàñ ñòîïèòü ïðè ïîïàäåíèè èç îðóæèÿ')
                    imgui.SameLine()
                    imgui.Text('AntiStan')
                    imgui.SameLine()
                    imgui.ToggleButton('##19', anti_stan)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Êàìåðà íå áóäåò âçîâðàùàòüñÿ íà äåôîëòíîå ìåñòî')
                    imgui.SameLine()
                    imgui.Text('ExtraWS')
                    imgui.SameLine()
                    imgui.ToggleButton('##20', extra_ws)
                end
                if menu == 3 then
                    imgui.Text(' ')
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.PushItemWidth(200)
                    imgui.InputText(u8'Àêòèâàöèÿ ñêðèïòà(êîìàíäà)', command)
                    imgui.Text(' ')
                    imgui.Text(' ')
                    imgui.Text(' ')
                    --password
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Text('AutoLogin')
                    imgui.SameLine()
                    imgui.ToggleButton('##21', auto_login)
                    if auto_login.v then
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.PushItemWidth(200)
                        imgui.InputText('Password', password)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Text(u8'Ñìåíèòü òåìó')
                    for i, value in ipairs(themes.colorThemes) do
                        imgui.Text(' ')
                        imgui.SameLine()
                        if imgui.RadioButton(value, style, i) then
                            themes.SwitchColorTheme(i)
                        end
                    end
                end
                if menu == 4 then
                    imgui.Text('      ')
                    imgui.SameLine()
                    imgui.Image(img, imgui.ImVec2(500, 380))
                    imgui.Text(' ')
                    imgui.SameLine()
                    if imgui.Button(u8'Âûãðóçèòü', imgui.ImVec2(183, 150)) then
                        showCursor(false)
                        thisScript():unload()
                    end
                    imgui.SameLine()
                    if imgui.Button(u8'Ïåðåçàãðóçèòü', imgui.ImVec2(183, 150)) then
                        showCursor(false)
                        thisScript():reload()
                    end
                    imgui.SameLine()
                    if imgui.Button(u8'Óäàëèòü', imgui.ImVec2(183,150)) then
                        onewindow.v = true
                    end
                end
            imgui.EndChild()
        imgui.End()
    end
    if onewindow.v then
        imgui.SetNextWindowPos(imgui.ImVec2(mx/2, my/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(340, 140), imgui.Cond.FirstUseEver)
        imgui.Begin('Delete', onewindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
            imgui.CenterText(u8'Âû òî÷íî õîòèòå óäàëèòü ñêðèïò?')
            if imgui.Button(u8'Äà', imgui.ImVec2(150,50)) then
                os.remove(thisScript().path)
                thisScript():unload()
            end
            imgui.SameLine()
            if imgui.Button(u8'Íåò', imgui.ImVec2(150,50)) then
                onewindow.v = false
            end
        imgui.End()
    end
    if twowindow.v then
        imgui.SetNextWindowPos(imgui.ImVec2(mx/2, my/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(340, 140), imgui.Cond.FirstUseEver)
        imgui.Begin('Update', onewindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove)
            imgui.CenterText(u8'Âûøëà íîâàÿ âåðñèÿ ñêðèïòà.')
            imgui.CenterText(u8'Âû õîòèòå îáíîâèòü ñêðèïò?')
            if imgui.Button(u8'Äà', imgui.ImVec2(150,50)) then
                sampAddChatMessage('Îáíàâëåíèå íà÷àëîñü',-1)
                update():download()
                twowindow.v = false
                window.v = false
                imgui.Process = false
            end
            imgui.SameLine()
            if imgui.Button(u8'Íåò', imgui.ImVec2(150,50)) then
                twowindow.v = false
            end
        imgui.End()
    end
end

function onWindowMessage(m, p)
    if p == 0x1B and window.v then
        consumeWindowMessage()
        window.v = false
    end
end

function update_window()
    twowindow.v = not twowindow.v
    imgui.Process = twowindow.v
end

function event.onSendPlayerSync(data)
	if bit.band(data.keysData, 0x28) == 0x28 and allow_bunnyhop.v then
		data.keysData = bit.bxor(data.keysData, 0x20)
	end
end

event.onSendGiveDamage = function(playerId, damage, weapon, bodypart)
	if playerId ~= nil and acctive_kill.v then
		if not isPlayerDead(PLAYER_HANDLE) and not damage ~= nil then
			hp = sampGetPlayerHealth(playerId)
			new_hp = hp - damage
			
			lua_thread.create(function()
				wait(0)
				if new_hp == 0 then
					--sampSendChat(u8:decode(mainIni.settings.say_kill))
                end
			end)
		end
		playerId = nil
	end
end

function getAmmoInClip()
    return mem.getuint32(getCharPointer(PLAYER_PED) + 0x5A0 + getWeapontypeSlot(getCurrentCharWeapon(PLAYER_PED)) * 0x1C + 0x8)
end

function isKeyCheckAvailable()
	if not isSampLoaded() then
		return true
	end
	if not isSampfuncsLoaded() then
		return not sampIsChatInputActive() and not sampIsDialogActive()
	end
	return not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive()
end

function event.onDisplayGameText(style, time, text)
	if acctive_eat.v then
		if text:find('You are hungry!') or text:find('You are very hungry!') then
			if combo_eat.v == 0 then
                --sampSendChat(u8'/jfish')
            end
            if combo_eat.v == 1 then
               -- sampSendChat(u8'/jmeat')
            end
            if combo_eat.v == 2 then
                --sampSendChat(u8'/cheeps')
            end
		end
		--if sbiv_eat.v == 1 then
        --    sampSendChat(u8'q')
        --end
	end
end

function noradio_func()
    if getRadioChannel(PLAYER_PED) < 12 and noradio.v then
		setRadioChannel(12)
	end
end

function event.onShowDialog(dialogId, style, title, button1, button2, text)
	if dialogId == 2 and text:find('Ââåäèòå ñâîé ïàðîëü') and password ~= '' and not text:find('Íåâåðíûé ïàðîëü') and auto_login then
		sampSendDialogResponse(dialogId, 1, nil, mainIni.settings.password)
		return false
	end
end

function event.onSendCommand(command)
    if command == mainIni.settings.command then
        window.v = not window.v
        imgui.Process = window.v
        return false
    end
end

function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end

function event.onServerMessage(text)
    if hp_state and text:find('Ó âàñ íåòó àïòå÷êè') then
        return false
    end
    hp_state = false
end
