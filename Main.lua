-- writefile("PetName.txt", "Raccoon");

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local TeleportService = game:GetService("TeleportService");
local Players = game:GetService("Players");

local PetEggService = ReplicatedStorage.GameEvents.PetEggService;

local Player = Players.LocalPlayer;
local PlaceId = game.PlaceId;

local HatchFunction = debug.getupvalue(debug.getupvalue(getconnections(PetEggService.OnClientEvent)[1].Function, 1), 2)
local Pets = debug.getupvalue(HatchFunction, 2)

local Found = false;
local function Retry()
    queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/Grow-a-Garden/refs/heads/main/Main.lua"));
    TeleportService:Teleport(PlaceId, Player);
end

for Index, Collected in CollectionService:GetTagged("EggName") do
    local TimeToHatch = Collected:GetAttribute("TimeToHatch");

    if (TimeToHatch > 0) then
        continue;
    end

    local WantedPet = readfile("PetName.txt");
    local Name = Pets[Collected:GetAttribute("OBJECT_UUID")];

    if (Name == WantedPet) then
        Found = true;
    end
end

if (not Found) then
    Retry();
end
