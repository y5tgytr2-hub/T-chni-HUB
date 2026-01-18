-- =====================================================
-- FLOAT ICON HUB | DELTA FRIENDLY | ALL IN ONE + TAB
-- WalkSpeed | JumpPower | InfJump | NoClip | Scroll UI
-- =====================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local LP = Players.LocalPlayer

-- ================= STATES =================
local humanoid
local wsEnabled, jpEnabled, infJumpEnabled, noclipEnabled = false, false, false, false
local wsValue, jpValue = 16, 50

-- ================= CHARACTER =================
local function onChar(char)
humanoid = char:WaitForChild("Humanoid")
humanoid.UseJumpPower = true
end
onChar(LP.Character or LP.CharacterAdded:Wait())
LP.CharacterAdded:Connect(onChar)

-- ================= GUI =================
local gui = Instance.new("ScreenGui", LP.PlayerGui)
gui.ResetOnSpawn = false
-- ===== FLOAT TEXT BUTTON =====
local icon = Instance.new("TextButton", gui)
icon.Size = UDim2.fromOffset(140,36)
icon.Position = UDim2.fromScale(0.03,0)
icon.Text = "📂 OPEN UI"
icon.Font = Enum.Font.GothamBold
icon.TextSize = 14
icon.TextColor3 = Color3.new(1,1,1)
icon.BackgroundColor3 = Color3.fromRGB(0,120,255)
icon.Active = true
icon.Draggable = true
icon.AutoButtonColor = true
Instance.new("UICorner", icon).CornerRadius = UDim.new(0,8)

icon.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
	icon.Text = main.Visible and "❌ CLOSE UI" or "📂 OPEN UI"
end)

-- ===== MAIN =====
local main = Instance.new("Frame", gui)
main.Size = UDim2.fromOffset(280,300)
main.Position = UDim2.fromScale(0.33,0)
main.BackgroundColor3 = Color3.fromRGB(25,25,25)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

icon.MouseButton1Click:Connect(function()
main.Visible = not main.Visible
end)

-- ===== TITLE =====
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,35)
title.Text = "🇹🇭 T-chni Hub"
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

-- ================= TAB BAR =================
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0,0,0,35)
tabBar.Size = UDim2.new(1,0,0,35)
tabBar.BackgroundColor3 = Color3.fromRGB(30,30,30)

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Padding = UDim.new(0,6)

local TAB_ACTIVE = Color3.fromRGB(0,120,255)
local TAB_IDLE   = Color3.fromRGB(70,70,70)

local function createTab(text)
local b = Instance.new("TextButton", tabBar)
b.Size = UDim2.new(0,120,1,-6)
b.Text = text
b.Font = Enum.Font.GothamBold
b.TextSize = 13
b.TextColor3 = Color3.new(1,1,1)
b.BackgroundColor3 = TAB_IDLE
Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)
return b
end

local tabScript = createTab("📜 Script")
local tabOther  = createTab("⚙️ Other")

-- ================= PAGES =================
local pages = Instance.new("Frame", main)
pages.Position = UDim2.new(0,0,0,70)
pages.Size = UDim2.new(1,0,1,-70)
pages.BackgroundTransparency = 1

-- ===== VERTICAL PAGE (ใช้ทั้ง Script + Other) =====
local function createVerticalPage()
local page = Instance.new("Frame", pages)
page.Size = UDim2.new(1,0,1,0)
page.Visible = false
page.BackgroundTransparency = 1

local scroll = Instance.new("ScrollingFrame", page)  
scroll.Size = UDim2.new(1,0,1,0)  
scroll.ScrollBarThickness = 5  
scroll.ScrollingDirection = Enum.ScrollingDirection.Y  
scroll.CanvasSize = UDim2.new(0,0,0,0)  
scroll.BackgroundTransparency = 1  

local layout = Instance.new("UIListLayout", scroll)  
layout.Padding = UDim.new(0,8)  
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center  

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()  
	scroll.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y + 10)  
end)  

return page, scroll

end

local pageScript, scrollScript = createVerticalPage()
local pageOther,  scrollOther  = createVerticalPage()

-- ===== PAGE SWITCH =====
local function setActiveTab(tabBtn, page)
for _,b in pairs(tabBar:GetChildren()) do
if b:IsA("TextButton") then b.BackgroundColor3 = TAB_IDLE end
end
tabBtn.BackgroundColor3 = TAB_ACTIVE

for _,p in pairs(pages:GetChildren()) do  
	if p:IsA("Frame") then p.Visible = false end  
end  
page.Visible = true

end

tabScript.MouseButton1Click:Connect(function()
setActiveTab(tabScript, pageScript)
end)

tabOther.MouseButton1Click:Connect(function()
setActiveTab(tabOther, pageOther)
end)

setActiveTab(tabScript, pageScript)

-- ================= UI MAKER =================
local function button(parent, text)
local b = Instance.new("TextButton", parent)
b.Size = UDim2.new(1,-20,0,35)
b.Text = text
b.Font = Enum.Font.GothamBold
b.TextSize = 14
b.TextColor3 = Color3.new(1,1,1)
b.BackgroundColor3 = Color3.fromRGB(120,0,0)
Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
return b
end

local function box(parent, ph)
local t = Instance.new("TextBox", parent)
t.Size = UDim2.new(1,-20,0,30)
t.PlaceholderText = ph
t.Font = Enum.Font.Code
t.TextSize = 14
t.TextColor3 = Color3.new(1,1,1)
t.BackgroundColor3 = Color3.fromRGB(35,35,35)
t.ClearTextOnFocus = false
Instance.new("UICorner", t).CornerRadius = UDim.new(0,6)
return t
end

-- ================= SCRIPT TAB =================
local wsBtn = button(scrollScript,"🏃 WalkSpeed : OFF")
local wsBox = box(scrollScript,"<WALKSPEED> (0-300)")

wsBtn.MouseButton1Click:Connect(function()
wsEnabled = not wsEnabled
wsBtn.Text = wsEnabled and "🏃 WalkSpeed : ON" or "🏃 WalkSpeed : OFF"
wsBtn.BackgroundColor3 = wsEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(120,0,0)
end)

wsBox.FocusLost:Connect(function()
local n = tonumber(wsBox.Text)
if n then wsValue = math.clamp(n,1,300) end
end)

local jpBtn = button(scrollScript,"🧍 JumpPower : OFF")
local jpBox = box(scrollScript,"<JUMPPOWER> (0-300)")

jpBtn.MouseButton1Click:Connect(function()
jpEnabled = not jpEnabled
jpBtn.Text = jpEnabled and "🧍 JumpPower : ON" or "🧍 JumpPower : OFF"
jpBtn.BackgroundColor3 = jpEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(120,0,0)
end)

jpBox.FocusLost:Connect(function()
local n = tonumber(jpBox.Text)
if n then jpValue = math.clamp(n,10,300) end
end)

local infBtn = button(scrollScript,"🌀 InfJump : OFF")
infBtn.MouseButton1Click:Connect(function()
infJumpEnabled = not infJumpEnabled
infBtn.Text = infJumpEnabled and "🌀 InfJump : ON" or "🌀 InfJump : OFF"
infBtn.BackgroundColor3 = infJumpEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(120,0,0)
end)

UIS.JumpRequest:Connect(function()
if infJumpEnabled and humanoid then
humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end
end)

local ncBtn = button(scrollScript,"🚪 NoClip : OFF")
ncBtn.MouseButton1Click:Connect(function()
noclipEnabled = not noclipEnabled
ncBtn.Text = noclipEnabled and "🚪 NoClip : ON" or "🚪 NoClip : OFF"
ncBtn.BackgroundColor3 = noclipEnabled and Color3.fromRGB(0,170,0) or Color3.fromRGB(120,0,0)
end)

-- ================= OTHER TAB =================
-- ===== UI SIZE DROPDOWN =====
local sizeState = false
local sizeBtn = button(scrollOther,"📐 UI Size : Medium")

local sizeFrame = Instance.new("Frame", scrollOther)
sizeFrame.Size = UDim2.new(1,-20,0,0)
sizeFrame.ClipsDescendants = true
sizeFrame.BackgroundTransparency = 1

local sizeLayout = Instance.new("UIListLayout", sizeFrame)
sizeLayout.Padding = UDim.new(0,6)
sizeLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function sizeOption(text, w, h)
	local b = Instance.new("TextButton", sizeFrame)
	b.Size = UDim2.new(1,0,0,30)
	b.Text = text
	b.Font = Enum.Font.Gotham
	b.TextSize = 13
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,6)

	b.MouseButton1Click:Connect(function()
		main.Size = UDim2.fromOffset(w,h)
		sizeBtn.Text = "📐 UI Size : "..text
	end)
end

-- options
sizeOption("Small", 240,260)
sizeOption("Medium",280,300)
sizeOption("Large", 320,340)

-- toggle dropdown
sizeBtn.MouseButton1Click:Connect(function()
	sizeState = not sizeState
	sizeFrame.Size = sizeState
		and UDim2.new(1,-20,0,110)
		or  UDim2.new(1,-20,0,0)
end)

local dragLock = false
local lockBtn = button(scrollOther,"🔓 Drag : ON")
lockBtn.MouseButton1Click:Connect(function()
dragLock = not dragLock
main.Draggable = not dragLock
icon.Draggable = not dragLock
lockBtn.Text = dragLock and "🔒 Drag : OFF" or "🔓 Drag : ON"
lockBtn.BackgroundColor3 = dragLock and Color3.fromRGB(120,0,0) or Color3.fromRGB(0,170,0)
end)

button(scrollOther,"📍 Reset UI Position").MouseButton1Click:Connect(function()
main.Position = UDim2.fromScale(0.32,0)
icon.Position = UDim2.fromScale(0.03,0)
end)

button(scrollOther,"🔄 Rejoin Server").MouseButton1Click:Connect(function()
TeleportService:Teleport(game.PlaceId, LP)
end)

button(scrollOther,"❌ Close HUB").MouseButton1Click:Connect(function()
gui:Destroy()
end)

-- ================= LOOP =================
RunService.Stepped:Connect(function()
if noclipEnabled and LP.Character then
for _,v in pairs(LP.Character:GetDescendants()) do
if v:IsA("BasePart") then v.CanCollide = false end
end
end
end)

RunService.RenderStepped:Connect(function()
if humanoid then
if wsEnabled then humanoid.WalkSpeed = wsValue end
if jpEnabled then humanoid.JumpPower = jpValue end
end
end)
