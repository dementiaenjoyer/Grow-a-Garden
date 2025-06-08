-- writefile("PetName.txt", "Raccoon");
-- POETRY

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TeleportService = game:GetService("TeleportService");
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");

local GameEvents = ReplicatedStorage:WaitForChild("GameEvents", 9e9);
local PetEggService = GameEvents.PetEggService;

local LocalPlayer = Players.LocalPlayer;
local PlaceId = game.PlaceId;

repeat task.wait(); until game:IsLoaded();

local Connections = getconnections(PetEggService.OnClientEvent);

repeat task.wait() until Connections ~= 0;

local HatchFunction = debug.getupvalue(debug.getupvalue(Connections[1].Function, 1), 2);
local Pets = debug.getupvalue(HatchFunction, 2);

local function Count(Table)
    local Current = 0;

    for Index, Object in Table do
        Current += 1;
    end

    return Current;
end

repeat task.wait() until Count(Pets) ~= 0;

table.foreach(Pets, print);

local Found = false;
local function Retry()
    queue_on_teleport(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/Grow-a-Garden/refs/heads/main/Main.lua"));
    TeleportService:Teleport(PlaceId, LocalPlayer);
end

for _ = 0, 100 do
    for Index, Descendant in Workspace:GetDescendants() do
        if (not Descendant:GetAttribute("EggName")) then
            continue;
        end

        if (Descendant:GetAttribute("OWNER") ~= LocalPlayer.Name) then
            continue;
        end

        local WantedPet = readfile("PetName.txt");
        local Name = Pets[Descendant:GetAttribute("OBJECT_UUID")];

        if (Name == WantedPet) then
            Found = true;
        end
    end

    task.wait(0.01);
end

if (not Found) then
    Retry();
end
