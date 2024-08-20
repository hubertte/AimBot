local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local function aimAtTarget(target)
    -- Rotate the player to face the target
    local character = player.Character
    local head = character:FindFirstChild("Head")
    
    -- Calculate the direction to aim at the target
    local direction = (target.Position - head.Position).unit
    
    -- Aim the player's head in the direction of the target
    head.CFrame = CFrame.new(head.Position, head.Position + direction)
end

-- Detect when the player clicks and aim at an opponent in front
mouse.Button1Down:Connect(function()
    local ray = Ray.new(player.Character.Head.Position, mouse.Hit.p - player.Character.Head.Position)
    local hit, position = workspace:FindPartOnRay(ray, player.Character)
    
    if hit and hit.Parent:FindFirstChild("Humanoid") then
        aimAtTarget(hit)
    end
end)

local function getNearestEnemy()
    local nearestDistance = math.huge
    local nearestEnemy = nil
    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
        local enemyHumanoid = enemy:FindFirstChild("Humanoid")
        if enemyHumanoid and enemyHumanoid.Health > 0 then
            local distance = (enemy.Position - player.Character.Head.Position).magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestEnemy = enemy
            end
        end
    end
    return nearestEnemy
end

-- Aim at the nearest enemy when the player clicks
mouse.Button1Down:Connect(function()
    local nearestEnemy = getNearestEnemy()
    if nearestEnemy then
        aimAtTarget(nearestEnemy)
    end
end)


