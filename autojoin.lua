-- KHAI BÁO LINK JSON KEY
local keyJsonUrl = "https://raw.githubusercontent.com/PhongYTB/Keysytems/refs/heads/main/keys.json"
local HttpService = game:GetService("HttpService")

-- LẤY TẤT CẢ KEY
local function GetKeys()
    local data = game:HttpGet(keyJsonUrl)
    local decoded = HttpService:JSONDecode(data)
    return decoded.keys -- JSON: {"keys":["KEY1","KEY2",...]}
end

local KeyList = GetKeys()

local keyLink = "https://phongytb.github.io/Keysytems/"

local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeySystem"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- FRAME
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(45,45,45)
Frame.Size = UDim2.new(0,300,0,160)
Frame.Position = UDim2.new(0.5,-150,0.5,-80)
local UICorner = Instance.new("UICorner", Frame)

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Frame
CloseButton.Text = "X"
CloseButton.Size = UDim2.new(0,25,0,25)
CloseButton.Position = UDim2.new(1,-30,0,5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255,60,60)
CloseButton.TextColor3 = Color3.fromRGB(255,255,255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
local closeCorner = Instance.new("UICorner", CloseButton)
closeCorner.CornerRadius = UDim.new(0,5)
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- TextBox
local TextBox = Instance.new("TextBox")
TextBox.Parent = Frame
TextBox.PlaceholderText = "Nhập key tại đây"
TextBox.Size = UDim2.new(0.9,0,0,35)
TextBox.Position = UDim2.new(0.05,0,0.25,0)
TextBox.BackgroundColor3 = Color3.fromRGB(70,70,70)
TextBox.TextColor3 = Color3.fromRGB(255,255,255)
local tbCorner = UICorner:Clone()
tbCorner.Parent = TextBox

-- Check Button
local CheckButton = Instance.new("TextButton")
CheckButton.Parent = Frame
CheckButton.Text = "Kiểm tra key"
CheckButton.Size = UDim2.new(0.4,0,0,30)
CheckButton.Position = UDim2.new(0.05,0,0.65,0)
CheckButton.BackgroundColor3 = Color3.fromRGB(80,170,80)
UICorner:Clone().Parent = CheckButton

-- Get Key Button
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Parent = Frame
GetKeyButton.Text = "Lấy key"
GetKeyButton.Size = UDim2.new(0.4,0,0,30)
GetKeyButton.Position = UDim2.new(0.55,0,0.65,0)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(100,100,255)
UICorner:Clone().Parent = GetKeyButton

GetKeyButton.MouseButton1Click:Connect(function()
    setclipboard(keyLink)
    game.StarterGui:SetCore("SendNotification", {
        Title = "Đã copy link",
        Text = "Dán lên trình duyệt để lấy key.",
        Duration = 4,
    })
end)

local keyOk = false
CheckButton.MouseButton1Click:Connect(function()
    local input = TextBox.Text:match("^%s*(.-)%s*$") -- loại bỏ khoảng trắng
    for _, key in ipairs(KeyList) do
        if input == key then
            keyOk = true
            ScreenGui:Destroy()
            game.StarterGui:SetCore("SendNotification", {
                Title = "Thành công",
                Text = "Key đúng.",
                Duration = 3,
            })
            return
        end
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "Sai key",
        Text = "Ấn 'Lấy key' để lấy key mới.",
        Duration = 3,
    })
end)

repeat task.wait() until keyOk == true
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PhongHubAutoJoin"
ScreenGui.Parent = PlayerGui

-- Menu Frame
local MenuFrame = Instance.new("Frame")
MenuFrame.Size = UDim2.new(0,320,0,180)
MenuFrame.Position = UDim2.new(0.5,-160,0.5,-90)
MenuFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
MenuFrame.BorderSizePixel = 0
MenuFrame.Parent = ScreenGui
MenuFrame.Active = true
MenuFrame.Draggable = true
MenuFrame.ClipsDescendants = true
MenuFrame.AnchorPoint = Vector2.new(0.5,0.5)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundColor3 = Color3.fromRGB(200,0,0)
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Text = "Auto Join (m/s)"
Title.Font = Enum.Font.GothamBold
Title.TextScaled = true
Title.Parent = MenuFrame

-- Input Box
local MSBox = Instance.new("TextBox")
MSBox.PlaceholderText = "Enter max m/s (1-500)"
MSBox.Size = UDim2.new(1,-20,0,35)
MSBox.Position = UDim2.new(0,10,0,45)
MSBox.BackgroundColor3 = Color3.fromRGB(60,60,60)
MSBox.TextColor3 = Color3.fromRGB(255,255,255)
MSBox.ClearTextOnFocus = true
MSBox.Font = Enum.Font.Gotham
MSBox.TextScaled = true
MSBox.Parent = MenuFrame

-- Auto Join Button
local MSButton = Instance.new("TextButton")
MSButton.Text = "Auto Join"
MSButton.Size = UDim2.new(1,-20,0,35)
MSButton.Position = UDim2.new(0,10,0,85)
MSButton.BackgroundColor3 = Color3.fromRGB(180,0,0)
MSButton.TextColor3 = Color3.fromRGB(255,255,255)
MSButton.Font = Enum.Font.GothamBold
MSButton.TextScaled = true
MSButton.Parent = MenuFrame

-- Error Label
local ErrorLabel = Instance.new("TextLabel")
ErrorLabel.Size = UDim2.new(1,0,0,20)
ErrorLabel.Position = UDim2.new(0,0,0,130)
ErrorLabel.TextColor3 = Color3.fromRGB(255,0,0)
ErrorLabel.BackgroundTransparency = 1
ErrorLabel.Text = ""
ErrorLabel.TextScaled = true
ErrorLabel.Font = Enum.Font.GothamBold
ErrorLabel.Parent = MenuFrame

-- Overlay
local Overlay = Instance.new("Frame")
Overlay.Size = UDim2.new(1,0,1,0)
Overlay.Position = UDim2.new(0,0,0,0)
Overlay.BackgroundColor3 = Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency = 0.7
Overlay.Visible = false
Overlay.Parent = ScreenGui

local OverlayLabel = Instance.new("TextLabel")
OverlayLabel.Size = UDim2.new(1,0,1,0)
OverlayLabel.BackgroundTransparency = 1
OverlayLabel.TextColor3 = Color3.fromRGB(255,255,255)
OverlayLabel.Text = ""
OverlayLabel.TextScaled = true
OverlayLabel.Font = Enum.Font.GothamBold
OverlayLabel.Parent = Overlay

-- Auto Join Logic
MSButton.MouseButton1Click:Connect(function()
    local value = tonumber(MSBox.Text)
    if not value or value <=0 or value>500 then
        ErrorLabel.Text = "Error: Enter a number 1-500"
        return
    end
    ErrorLabel.Text = ""
    
    Overlay.Visible = true
    for i=1,400 do
        OverlayLabel.Text = "Looking for server "..i.."/400"
        wait(0.01)
    end
    OverlayLabel.Text = "Connecting..."
    wait(0.5)
    Overlay.Visible = false
    MSButton.Text = "Auto Join"
    
    -- Teleport example (replace PlaceId with your game's)
    -- TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)