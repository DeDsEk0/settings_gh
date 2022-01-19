--кто откроет код тот педик

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
local mem = require 'memory'
local fa = require 'fAwesome5' -- ICONS LIST: https://fontawesome.com/v5.15/icons?d=gallery&s=solid&m=free


local script_vers = 1
local script_vers_text = "1.1"
local mx, my = getScreenResolution()
local delay = 500
local hp_state = false
local raw = 'https://raw.githubusercontent.com/DeDsEk0/settings_gh/main/update.json'
local dlstatus = require('moonloader').download_status

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 15.0
    style.FramePadding = ImVec2(5, 5)
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(8, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 15.0
    style.GrabMinSize = 15.0
    style.GrabRounding = 7.0
    style.ChildWindowRounding = 8.0
    style.FrameRounding = 6.0
   
 
    colors[clr.Text] = ImVec4(0.95, 0.96, 0.98, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.36, 0.42, 0.47, 1.00)
    colors[clr.WindowBg] = ImVec4(0.00, 0.00, 0.00, 1.00)
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
end
--�����
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
        command_heal = '',
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
        say_eat = 'нямка',
        acctive_eat = true,
        auto_c = true,
        noradio = true,
        auto_login = true,
        password = '961835',
        gm_car = true,
        nobike = true,
        extra_ws = true,
    },
}, directIni)


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
local hp_heal = tonumber(mainIni.settings.hp_heal)
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

function main()
    while not isSampAvailable() do wait(200) end
    menu = 4
    sampRegisterChatCommand('usedrugs',use_drug)
    image = imgui.CreateTextureFromFile("moonloader/config/gh.png")
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
            if isKeyJustPressed(0x58) and not sampIsCursorActive() then
                if many_drug.v == 1 then
                    if RP_drug.v then
                        sampSendChat('/me съел конфету белого цвета')
                        wait(500)
                    end
                    sampSendChat('/usedrugs 1')
                    if sbiv_drug.v == 1 then
                        sampSendChat('q')
                    end
                end
                if  many_drug.v == 2 then
                    if RP_drug.v then
                        sampSendChat('/me съел конфету белого цвета')
                        wait(500)
                    end
                    sampSendChat('/usedrugs 2')
                    if sbiv_drug.v == 1 then
                        sampSendChat('q')
                    end
                end
                if many_drug.v == 3 then
                    if RP_drug.v then
                        sampSendChat('/me съел конфету белого цвета')
                        wait(500)
                    end
                    sampSendChat('/usedrugs 3')
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
        if acctive_heal.v then
            if health > 0 and health < 40 and hp_state then
                sampSendChat(u8:decode(mainIni.settings.command_heal))
                hp_state = false
            elseif health >= 39 then hp_state = true end
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
        inicfg.save(mainIni, directIni)
    end
end

function use_drug(arg)
    if RP_drug.v then
        lua_thread.create(function()
            sampSendChat('/me съел конфету белого цвета')
            wait(delay)
            sampSendChat('/usedrugs '..arg..'')
        end)
        if sbiv_drug.v then
            lua_thread.create(function()
                wait(delay)
                sampSendChat('q')
            end)
        end
    end
    sampSendChat('/usedrugs '..arg..'')
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
    apply_custom_style()
    if window.v then
        imgui.SetNextWindowPos(imgui.ImVec2(mx/2, my/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(920, 620), imgui.Cond.FirstUseEver)
        imgui.Begin('Getto Helper || by Lill_Chich', window, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
            img = imgui.CreateTextureFromFile('moonloader\\GettoHelper\\gh_logo.png')
            imgui.BeginChild('##window1', imgui.ImVec2(280, 590))
                imgui.Text(' ')
                imgui.Text('    ')
                imgui.SameLine()
                if imgui.Button(u8'Главное Меню', imgui.ImVec2(230,130)) then
                    menu = 4
                end
                imgui.Text('    ')
                imgui.SameLine()
                if imgui.Button(u8'Основное', imgui.ImVec2(230,130)) then
                    menu = 1
                end
                imgui.Text('    ')
                imgui.SameLine()
                if imgui.Button(u8'Читы', imgui.ImVec2(230,130)) then
                    menu = 2
                end
                imgui.Text('    ')
                imgui.SameLine()
                if imgui.Button(u8'Настройки', imgui.ImVec2(230,130)) then
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
                    imgui.Combo(u8'Сервера', combo_server, {'Phenix', 'Tucson', 'Scottdale', 'Chandler', 'Brainburg', 'Sait Rose', 'Mesa', 'Red Rock', 'Yuma', 'Surprise', 'Prescott', 'Glendale', 'Kingman', 'Winslow', 'Payson', 'Gilbert', 'Show-Low', 'Casa Grande'})
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Text(u8'Чтобы узнать правила ГЕТТО вашего сервера нажмите на кнопку -->')
                    imgui.SameLine()
                    if imgui.Button(u8'Правила') then
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
                    --наркотики
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Наркотики будут использоваться нажав на клавишу X')
                    imgui.SameLine()
                    imgui.Text(u8'Наркотики')
                    imgui.SameLine()
                    imgui.ToggleButton('##1', acctive_drug)
                    if acctive_drug.v then
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.Text(u8'Сколько использовать:')
                        imgui.SameLine()
                        imgui.RadioButton(u8'1', many_drug, 1)
                        imgui.SameLine()
                        imgui.RadioButton(u8'2', many_drug, 2)
                        imgui.SameLine()
                        imgui.RadioButton(u8'3', many_drug, 3)
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.Text(u8'Сбивать:')
                        imgui.SameLine()
                        imgui.RadioButton(u8'Да', sbiv_drug, 1)
                        imgui.SameLine()
                        imgui.RadioButton(u8'Нет', sbiv_drug, 2)
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.Text(u8'RP отыгровка')
                        imgui.SameLine()
                        imgui.ToggleButton('##2', RP_drug)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Будет использоваться нажатием клавиш A + R + M')
                    imgui.SameLine()
                    imgui.Text(u8'Армор')
                    imgui.SameLine()
                    imgui.ToggleButton('##3', acctive_armour)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Будет использоваться нажатием клавиш M + S + K')
                    imgui.SameLine()
                    imgui.Text(u8'Маска')
                    imgui.SameLine()
                    imgui.ToggleButton('##4', acctive_mask)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Будет использоваться нажатием клавиши P')
                    imgui.SameLine()
                    imgui.Text(u8'Телефон')
                    imgui.SameLine()
                    imgui.ToggleButton('##5', acctive_phone)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Будет использоваться нажатием клавиши L')
                    imgui.SameLine()
                    imgui.Text(u8'Закрыть авто')
                    imgui.SameLine()
                    imgui.ToggleButton('##6', acctive_lock)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Будет писать в чат при убийстве')
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
                    imgui.Text(u8'Полный разгон на мото на ШИФТ')
                    imgui.SameLine()
                    imgui.ToggleButton('##9', auto_bike)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Будет кушать если будете голодны')
                    imgui.SameLine()
                    imgui.Text(u8'АвтоЕда')
                    imgui.SameLine()
                    imgui.ToggleButton('##10', acctive_eat)
                    if acctive_eat.v then
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.PushItemWidth(150)
                        imgui.Combo('##11', combo_eat, {u8'Жаренная рыба', u8'Жаренное мясо', u8'Чипсы'})
                        imgui.SameLine()
                        imgui.RadioButton(u8'Сбивать', sbiv_eat, 1)
                        imgui.SameLine()
                        imgui.RadioButton(u8'Не сбивать', sbiv_eat, 2)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Убирает радио')
                    imgui.SameLine()
                    imgui.Text('NoRadio')
                    imgui.SameLine()
                    imgui.ToggleButton('##12', noradio)
                end
                if menu == 2 then
                    imgui.Text(' ')
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Быстрый Бег/Плавание - w + 1')
                    imgui.SameLine()
                    imgui.Text('Fast run/swim')
                    imgui.SameLine()
                    imgui.ToggleButton('##13', fast_run)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Не будет уставать')
                    imgui.SameLine()
                    imgui.Text(u8'Бесконечный бег')
                    imgui.SameLine()
                    imgui.ToggleButton('##14', beg)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Хил будет использоваться, если хп будет <= 40')
                    imgui.SameLine()
                    imgui.Text('AutoHeal')
                    imgui.SameLine()
                    imgui.ToggleButton('##15', acctive_heal)
                    if acctive_heal.v then
                        imgui.SameLine()
                        imgui.PushItemWidth(100)
                        imgui.InputText(u8'Команда при хиле', command_heal)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Будет автоматически перезаряжать оружее')
                    imgui.SameLine()
                    imgui.Text('AutoScroll')
                    imgui.SameLine()
                    imgui.ToggleButton(u8'##16', acctive_scroll)
                    if acctive_scroll.v then
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.PushItemWidth(50)
                        imgui.InputText(u8'После скольки скроллить', number_scroll)
                        imgui.Text(' ')
                        imgui.SameLine()
                        imgui.RadioButton(u8'Скролить', scroll, 1)
                        imgui.SameLine()
                        imgui.Ques('Предупредить - выведится на экран и звук что надо скроллить')
                        imgui.SameLine()
                        imgui.RadioButton(u8'Предупредить', scroll, 2)
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Бесконечное здоровье машины')
                    imgui.SameLine()
                    imgui.Text(u8'GMCar')
                    imgui.SameLine()
                    imgui.ToggleButton('##17', gm_car)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Персонаж не будет падать с велика/мотика')
                    imgui.SameLine()
                    imgui.Text('NoBike')
                    imgui.SameLine()
                    imgui.ToggleButton('##18', nobike)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Не будет вас стопить при попадении из оружия')
                    imgui.SameLine()
                    imgui.Text('AntiStan')
                    imgui.SameLine()
                    imgui.ToggleButton('##19', anti_stan)
                    imgui.Text(' ')
                    imgui.SameLine()
                    imgui.Ques('Камера не будет взовращаться на дефолтное место')
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
                    imgui.InputText(u8'Активация скрипта(команда)', command)
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
                    imgui.TextColoredRGB(u8'{808080}Связаться {808080}со {808080}мною')
                    imgui.TextColoredRGB(u8'{00008B}ВК: ')
                    imgui.SameLine()
                end
                if menu == 4 then
                    imgui.Text('      ')
                    imgui.SameLine()
                    imgui.Image(img, imgui.ImVec2(500, 347))
                    imgui.Text(' ')
                    imgui.SameLine()
                    if imgui.Button(u8'Выгрузить', imgui.ImVec2(183, 150)) then
                        showCursor(false)
                        thisScript():unload()
                    end
                    imgui.SameLine()
                    if imgui.Button(u8'Перезагрузить', imgui.ImVec2(183, 150)) then
                        showCursor(false)
                        thisScript():reload()
                    end
                    imgui.SameLine()
                    if imgui.Button(u8'Удалить', imgui.ImVec2(183,150)) then
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
            imgui.CenterText(u8'Вы точно хотите удалить скрипт?')
            if imgui.Button(u8'Да', imgui.ImVec2(150,50)) then
                os.remove(thisScript().path)
                thisScript():unload()
            end
            imgui.SameLine()
            if imgui.Button(u8'Нет', imgui.ImVec2(150,50)) then
                onewindow.v = false
            end
        imgui.End()
    end
    if twowindow.v then
        imgui.SetNextWindowPos(imgui.ImVec2(mx/2, my/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(340, 140), imgui.Cond.FirstUseEver)
        imgui.Begin('Update', onewindow, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
            imgui.CenterText(u8'Вышла новая версия скрипта.')
            imgui.CenterText(u8'Вы хотите обновить скрипт?')
            if imgui.Button(u8'Да', imgui.ImVec2(150,50)) then
                sampAddChatMessage('Обнавление началось',-1)
            end
            imgui.SameLine()
            if imgui.Button(u8'Нет', imgui.ImVec2(150,50)) then
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
					sampSendChat(u8:decode(mainIni.settings.say_kill))
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
                sampSendChat(u8'/jfish')
            end
            if combo_eat.v == 1 then
                sampSendChat(u8'/jmeat')
            end
            if combo_eat.v == 2 then
                sampSendChat(u8'/cheeps')
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
	if dialogId == 2 and text:find('Введите свой пароль') and password ~= '' and not text:find('Неверный пароль') and auto_login then
		sampSendDialogResponse(dialogId, 1, nil, mainIni.settings.password)
		return false
	end
end

function event.onSendCommand(command)
    if command == mainIni.settings.command then
        window.v = not window.v
        imgui.Process = window.v
        if thisScript().version ~= lastver then
            twowindow.v = true
        end
        return false
    end
end

function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end

function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end

    render_text(text)
end
