--***********************************************************
--**              	  ROBERT JOHNSON                       **
--**            UI display with a question or text         **
--**          can display a yes/no button or ok btn        **
--***********************************************************

ISModalRichTextOpening = ISPanelJoypad:derive("ISModalRichText");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

--************************************************************************--
--** ISModalRichTextOpening:initialise
--**
--************************************************************************--

function ISModalRichTextOpening:initialise()


    if PCUModalTable and #PCUModalTable > 10 then
        -- Close the oldest modal and remove it from the UI manager
        local oldestModal = table.remove(PCUModalTable, 1) -- Remove and return the first modal
        if oldestModal then
            oldestModal:removeFromUIManager()
        end
    end

    
	ISPanelJoypad.initialise(self);
	local btnWid = 100
	local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
	local padBottom = 10
	if self.yesno then
		self.yes = ISButton:new((self:getWidth() / 2) - btnWid - 5, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("UI_Yes"), self, ISModalRichTextOpening.onClick);
		self.yes.internal = "YES";
		self.yes.anchorTop = false
		self.yes.anchorBottom = true
		self.yes:initialise();
		self.yes:instantiate();
		self.yes.borderColor = {r=1, g=1, b=1, a=0.1};
		self:addChild(self.yes);

		self.no = ISButton:new((self:getWidth() / 2) + 5, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("UI_No"), self, ISModalRichTextOpening.onClick);
		self.no.internal = "NO";
		self.no.anchorTop = false
		self.no.anchorBottom = true
		self.no:initialise();
		self.no:instantiate();
		self.no.borderColor = {r=1, g=1, b=1, a=0.1};
		self:addChild(self.no);
	else
		self.ok = ISButton:new((self:getWidth() / 2) - btnWid / 2, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("Close"), self, ISModalRichTextOpening.onClick);
		self.ok.internal = "OK";
		self.ok.anchorTop = false
		self.ok.anchorBottom = true
		self.ok:initialise();
		self.ok:instantiate();
		self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
		self:addChild(self.ok);
    end

    self.chatText = ISRichTextPanel:new(2, 2, self.width - 4, self.height - padBottom - btnHgt);
    self.chatText.marginRight = self.chatText.marginLeft;
    self.chatText:initialise();
    self:addChild(self.chatText);
    self.chatText:addScrollBars()
    
    self.chatText.background = false;
    self.chatText.clip = true
    self.chatText.autosetheight = false
    self.chatText.text = self.text;
    self.chatText:paginate();
end

function ISModalRichTextOpening:updateButtons()
	local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local padBottom = 10
    if self.yesno then
        self.yes:setY(self:getHeight() - padBottom - btnHgt);
        self.no:setY(self:getHeight() - padBottom - btnHgt);
    else
        self.ok:setY(self:getHeight() - padBottom - btnHgt);
    end
end

function ISModalRichTextOpening:destroy()
	UIManager.setShowPausedMessage(true);
	self:setVisible(false);
    if self.destroyOnClick then
	    self:removeFromUIManager();
    end
	if UIManager.getSpeedControls() then
		UIManager.getSpeedControls():SetCurrentGameSpeed(1);
	end
	if self.player and JoypadState.players[self.player+1] then
		setJoypadFocus(self.player, self.prevFocus);
	elseif self.joyfocus and self.joyfocus.focus == self then
		self.joyfocus.focus = self.prevFocus
		updateJoypadFocus(self.joyfocus)
	end
end

function ISModalRichTextOpening:onClick(button)

    if PCUModalTable then
        for i, modal in ipairs(PCUModalTable) do
            if modal and modal:isVisible() then
                modal:removeFromUIManager()
                modal:setVisible(false)
            end
        end
        -- Clear the table after closing all modals
        PCUModalTable = {}
    end


	self:destroy();
	if self.onclick ~= nil then
		self.onclick(self.target, button, self.param1, self.param2);
	end
end

function ISModalRichTextOpening:prerender()
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
--	self:drawTextCentre(self.text, self:getWidth() / 2, (self:getHeight() / 2) - 10, 1, 1, 1, 1, UIFont.Small);
end

function ISModalRichTextOpening:onMouseDown(x, y)
--	ISPanelJoypad.onMouseDown(self, x, y)
	-- FIXME: this prevents clicks being passed to windows behind, but need to swallow clicks outside and mouse-move events as well
	return true
end

function ISModalRichTextOpening:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData);
	if self.yesno then
		self:setISButtonForA(self.yes)
		self:setISButtonForB(self.no)
	else
		self:setISButtonForA(self.ok)
	end
end

function ISModalRichTextOpening:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	if self.yesno then
		self.yes:clearJoypadButton()
		self.no:clearJoypadButton()
	else
		self.ok:clearJoypadButton()
	end
end

function ISModalRichTextOpening:onJoypadDown(button)
	ISPanelJoypad.onJoypadDown(self, button)
--[[
	if button == Joypad.AButton then
		if self.yesno then
			if self.yes.mouseOver then
				self.yes.player = self.player;
				self.yes.onclick(self.yes.target, self.yes);
			else
				self.no.player = self.player;
				self.no.onclick(self.no.target, self.no);
			end
		else
			self.ok.onclick(self.ok.target, self.ok);
		end
	end
	if button == Joypad.BButton then
		if self.yesno then
			self.no.player = self.player;
			self.no.onclick(self.no.target, self.no);
		else
			self.ok.onclick(self.ok.target, self.ok);
		end
	end
--]]
end

--[[
function ISModalRichTextOpening:onJoypadDirRight()
	if self.yesno then
		self.no.mouseOver = true;
		self.yes.mouseOver = false;
	end
end

function ISModalRichTextOpening:onJoypadDirLeft()
	if self.yesno then
		self.no.mouseOver = false;
		self.yes.mouseOver = true;
	end
end
--]]

function ISModalRichTextOpening:update()
	ISPanelJoypad.update(self)
	local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
	local minHeight = self.chatText:getScrollHeight() + btnHgt + 10
	maxHeight = getCore():getScreenHeight() - 40
	minHeight = math.min(minHeight, maxHeight)
	if self:getHeight() < minHeight then
		local dh = minHeight - self:getHeight()
		self:setHeight(minHeight)
		self:ignoreHeightChange()
		self:setY(math.max(self:getY() - dh / 2, 20))
		self:updateButtons()
	elseif self:getHeight() > maxHeight then
		local dh = self:getHeight() - maxHeight
		self:setHeight(maxHeight)
		self:ignoreHeightChange()
		self:setY(20)
		self:updateButtons()
    end
	self.chatText:setHeight(self.height - btnHgt - 10)
	self.chatText:updateScrollbars()
    if self.alwaysOnTop then
        self:bringToTop();
    end
end

function ISModalRichTextOpening:setHeightToContents()
	local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
	local minHeight = self.chatText:getScrollHeight() + btnHgt + 10
	self:setHeight(minHeight)
	self:ignoreHeightChange()
	self:updateButtons()
end

--************************************************************************--
--** ISModalRichTextOpening:new
--**
--************************************************************************--
function ISModalRichTextOpening:new(x, y, width, height, text, yesno, target, onclick, player, param1, param2)
	local o = {}
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self)
    self.__index = self
	local playerObj = player and getSpecificPlayer(player) or nil
	if y == 0 then
		if playerObj and playerObj:getJoypadBind() ~= -1 then
			o.y = getPlayerScreenTop(player) + (getPlayerScreenHeight(player) - height) / 2
		else
			o.y = o:getMouseY() - (height / 2)
		end
		o:setY(o.y)
	end
	if x == 0 then
		if playerObj and playerObj:getJoypadBind() ~= -1 then
			o.x = getPlayerScreenLeft(player) + (getPlayerScreenWidth(player) - width) / 2
		else
			o.x = o:getMouseX() - (width / 2)
		end
		o:setX(o.x)
	end
	o.name = nil;
    o.backgroundColor = {r=0, g=0, b=0, a=0.0};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=0};
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o.text = text;
	o.yesno = yesno;
	o.target = target;
	o.onclick = onclick;
	o.yes = nil;
    o.player = player;
	o.no = nil;
	o.ok = nil;
	o.param1 = param1;
	o.param2 = param2;
    o.destroyOnClick = true;
    return o;
end

