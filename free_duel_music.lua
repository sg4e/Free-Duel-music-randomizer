local music = {
    ["Random"] = 0x0,
    ["Main Menu"] = 0x7000,
    ["Input Name Menu"] = 0x7010,
--    ["You Lose - does not repeat"] = 0x7020,
    ["Tournament Announcement"] = 0x7030,
    ["Modern Times"] = 0x7040,
    ["Inside The Puzzle"] = 0x7050,
    ["Preliminary Face-Off"] = 0x7060,
    ["Final's Face-Off"] = 0x7070,
    ["Seto Kaiba Face-Off"] = 0x7080,
    ["Card Shop (Modern Times)"] = 0x7090,
    ["Metropolis"] = 0x70A0,
    ["Metropolis 2"] = 0x70B0,
    ["Pharaoh's Palace"] = 0x70C0,
    ["Egypt in Ruins"] = 0x70D0,
    ["Build Deck"] = 0x70E0,
    ["Duel Grounds"] = 0x70F0,
    ["King's Valley"] = 0x7100,
    ["Sea Shrine"] = 0x7110,
    ["Forest Shrine"] = 0x7120,
    ["Desert Shrine"] = 0x7130,
    ["Meadow Shrine"] = 0x7140,
    ["Mountain Shrine"] = 0x7150,
    ["Vast Shrine"] = 0x7160,
    ["Dark Shrine"] = 0x7170,
    ["Seto's Betrayal"] = 0x7180,
    ["Forbidden Ruins"] = 0x7190,
    ["Heishin Millennium Puzzle Confrontation"] = 0x71A0,
    ["Heishin's Invasion"] = 0x71B0,
    ["DarkNite's Arrival"] = 0x71C0,
    ["Preliminary Match"] = 0x71D0,
    ["Final's Match"] = 0x71E0,
    ["Seto Kaiba (Tournament Final)"] = 0x71F0,
    ["Egyptian Duel"] = 0x7200,
    ["Mages"] = 0x7210,
    ["High Mages"] = 0x7220,
    ["Heishin Millennium Puzzle Confrontation 2"] = 0x7230,
    ["Seto"] = 0x7240,
    ["DarkNite (Final Duel)"] = 0x7250,
--    ["DarkNite (Final Duel)"] = 0x7260,
    ["Free Duel"] = 0x7270,
    ["3D Duel (Free Duel)"] = 0x7280,
    ["3D Duel Tournament Final"] = 0x7290,
    ["3D Duel (Egypt)"] = 0x72A0,
    ["3D Duel Final Duel"] = 0x72B0,
    ["Free Duel Menu"] = 0x72C0,
    ["Library"] = 0x72D0,
--    ["You Win - does not repeat"] = 0x72E0,
--    ["You Lose - does not repeat"] = 0x72F0,
--    ["Game Over - does not repeat"] = 0x7300,
--    ["Exodia - does not repeat"] = 0x7310,
    ["Epilogue"] = 0x7320,
    ["Credits"] = 0x7330,
    ["Town Plaza"] = 0x7340,
    ["Password"] = 0x7350,
--    ["Millenium Item Found - does not repeat"] = 0x7360,
--    ["Forbidden Ruins"] = 0x7370,   -- repeat
--    ["Pharaoh's Palace"] = 0x7380  -- repeat
--    ["Build Deck"] = 0x7390,
--    ["Build Deck"] = 0x73A0,
--    ["Build Deck"] = 0x73B0,
--    ["Build Deck"] = 0x73C0,
--    ["Build Deck"] = 0x7400
}

local magic_address = 0x024DC8
local frames_per_refresh = 60 * 10
local current_frames = 0

local menu_choices = {}
for key, _ in pairs(music) do
    table.insert(menu_choices, key)
end

local menu_values = {}
for _, value in pairs(music) do
    table.insert(menu_values, value)
end

function get_random_music_track()
    if #menu_values == 0 then return nil end
    return menu_values[math.random(1, #menu_values)]
end


local music_form = forms.newform(320, 70, "Free Duel music")
local selection = forms.dropdown(music_form, menu_choices, 0, 0, 300, 25)
forms.setproperty(selection, "SelectedItem", "Random")



while true do
    if current_frames >= frames_per_refresh then
        current_frames = 0
        local music_track = forms.gettext(selection)
        local music_byte = 0x7270  -- Free Duel default
        if music_track == "Random" then
            music_byte = get_random_music_track()
        else
            music_byte = music[music_track]
        end
        memory.write_u16_le(magic_address, music_byte)
    end
    current_frames = current_frames + 1
    emu.frameadvance()
end
