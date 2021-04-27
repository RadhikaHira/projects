
-- to start game
function love.load()
    love.graphics.setBackgroundColor(0, 0.6, 0.1)

	-- loading images (card, numbers, symbols)
		image = {}
		for indexN, name in ipairs({
			1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
			'medium_heart', 'medium_diamond', 'medium_club', 'medium_spade',
			'small_heart', 'small_diamond', 'small_club', 'small_spade',
			'card', 'hidden',
			'jack', 'queen', 'king',
		}) do
			image[name] = love.graphics.newImage('image/'..name..'.png')
		end
	
	function add(C)
        table.insert(C, table.remove(d, love.math.random(#d)))
    end

	-- getting total is here because you want to see in other functions what the total
	-- is when the game is over
	-- funcion to finding total of the card number that the player or dealer has 
	-- which returns the total
    function totalling(C)
        local total = 0
        local ace = false

        for indexC, card in ipairs(C) do
            if card.number > 10 then
                total = total + 10
            else
                total = total + card.number
            end

            if card.number == 1 then
                ace = true
            end
        end

        if ace and total <= 11 then
            total = total + 10
        end

        return total
    end

    
	
	local ButtY = 230
    local heightB = 25
    local mLY = 6

    HB = {
        x = 10,
        y = ButtY,
        width = 53,
        height = heightB,
        message = 'Hit!',
        mLX = 16,
        mLY = mLY,
    }

    SB = {
        x = 70,
        y = ButtY,
        width = 53,
        height = heightB,
        message = 'Stand',
        mLX = 8,
        mLY = mLY,
    }

    PAB = {
        x = 10,
        y = ButtY,
        width = 113,
        height = heightB,
		message = 'Play again',
        mLX = 24,
        mLY = mLY,
    }
	
	function onTop(B)
        return love.mouse.getX() >= B.x 
		and love.mouse.getX() < B.x + B.width
        and love.mouse.getY() < B.y + B.height 
		and love.mouse.getY() >= B.y 
    end
	
	function startover()
		-- for deck
		d = {}
		for indexS, suit in ipairs({'club', 'diamond', 'heart', 'spade'}) do
			for number = 1, 13 do
				table.insert(d, {suit = suit, number = number})
			end
		end

		--getting cards for player and dealer
		player = {}
		add(player)
		add(player)

		dealer = {}
		add(dealer)
		add(dealer)

		-- for the round to be over the player has to click stand till then it is false
		gameover = false
	end
	
	startover()
end

-- global function to add a card if player clicks 'hit', 'stand' or 'play again'

function love.mousereleased()
	-- if the game is not over (true), then see if player clicks 'hit' button
	-- if 'stand' is clicked then game is over 
	-- or else reload game if the game is over
	if not gameover then 
		if onTop(HB) then
			add(player)
			if totalling(player) >= 21 then
                gameover = true
            end
		elseif onTop(SB) then
			gameover = true
		end
		
		--if the player stands, is at 21, or goes over, have the dealer add more cards
        if gameover then
            while totalling(dealer) < 17 do
                add(dealer)
            end
        end
		-- to reload game
	elseif onTop(PAB) then
		startover()
	end	
end

function love.draw()
	
    -- making a function to draw/get the cards
    local function drawing(card, x, y)
		
		-- displaying card which is set to white, rgb = 1,1,1
		love.graphics.setColor(1, 1, 1)
        love.graphics.draw(image.card, x, y)
		
		-- variables
		local widthC = 53
        local heightC = 73
		
		-- if its hearts or diamonds they are red, or else spades or clubs are black
        if card.suit == 'heart' or card.suit == 'diamond' then
            love.graphics.setColor(1, 0, .1)
        else
            love.graphics.setColor(0, 0, 0)
        end

		-- displaying the image of the numbers and symbol in the corner of the cards
        local function corner(picture, locationX, locationY)
            love.graphics.draw(picture, x + locationX, y + locationY)
            love.graphics.draw(picture, x + widthC - locationX, y + heightC - locationY, 0, -1)
        end

        corner(image[card.number], 3, 4)
        corner(image['small_'..card.suit], 3, 14)

		-- for numbers higher than 10, it is jack then queen then king
        if card.number > 10 then
            --make variable
			local kqj
			
			if card.number == 11 then
                kqj = image.jack
            elseif card.number == 12 then
                kqj = image.queen
            elseif card.number == 13 then
                kqj = image.king
            end
			
			--displaying the king, queen and jack according to how the width and height
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(kqj, x + 12, y + 11)
        else
            
			local function drawingMedium(locationX, locationY, flipX, flipY)
                local Image = image['medium_'..card.suit]
                local mediumW = 11
				
				-- display the symbols on the card according to the width and height
                love.graphics.draw( Image, x + locationX, y + locationY)
				
                if flipX then
                    love.graphics.draw(Image, x + widthC - locationX - mediumW, y + locationY)
                end
                if flipY then
                    love.graphics.draw(Image, x + locationX + mediumW, y + heightC - locationY, 0, -1)
                end
                if flipX and flipY then
                    love.graphics.draw(Image, x + widthC - locationX, y + heightC - locationY, 0, -1)
				end
			end
			
			-- for the numbers <= 10 and how the symbols should be displayed
            if card.number == 1 then
                drawingMedium(21, 31)

            elseif card.number == 2 then
                drawingMedium(21, 7, false, true)

            elseif card.number == 3 then
                drawingMedium(21, 7, false, true)
                drawingMedium(21, 31)

            elseif card.number == 4 then
                drawingMedium(11, 7, true, true)

            elseif card.number == 5 then
                drawingMedium(11, 7, true, true)
                drawingMedium(21, 31)

            elseif card.number == 6 then
                drawingMedium(11, 7, true, true)
                drawingMedium(11, 31, true)

            elseif card.number == 7 then
                drawingMedium(11, 7, true, true)
                drawingMedium(11, 31, true)
                drawingMedium(21, 19)

            elseif card.number == 8 then
                drawingMedium(11, 7, true, true)
                drawingMedium(11, 31, true)
                drawingMedium(21, 19, false, true)

            elseif card.number == 9 then
                drawingMedium(11, 7, true, true)
                drawingMedium(11, 23, true, true)
                drawingMedium(21, 31)

            elseif card.number == 10 then
                drawingMedium(11, 7, true, true)
                drawingMedium(11, 23, true, true)
                drawingMedium(21, 16, false, true)
            end
        end
    end
	
	-- variable
	local space = 60
	local MX = 10
	
    -- the dealer's cards
    for indexC, card in ipairs(dealer) do
        local dealerMY = 30
        if not gameover and indexC == 1 then
            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(image.hidden, MX, dealerMY)
        else
            drawing(card, ((indexC - 1) * space) + MX, dealerMY)
        end
    end

	-- cards for the player
    for indexC, card in ipairs(player) do
        drawing(card, ((indexC - 1) * space) + MX, 140)
    end
	
	-- displaying totals only when round is over
	-- make writing black 
    love.graphics.setColor(0, 0, 0)
    if gameover then
        love.graphics.print('Dealer Total: '..totalling(dealer), MX, 10)
    else
        love.graphics.print('Dealer Total: ?', MX, 10)
    end

    love.graphics.print('Player Total: '..totalling(player), MX, 120)

    if gameover then
        local function Won(thisperson, otherperson)
            return totalling(thisperson) <= 21 and (totalling(otherperson) > 21 or totalling(thisperson) > totalling(otherperson))
        end

        local function printWin(winner)
            love.graphics.print(winner, MX, 268)
        end

        if Won(player, dealer) then
            printWin('Congratulations! The Player Wins.')
        elseif Won(dealer, player) then
            printWin('Sorry, Dealer wins. ')
        else
            printWin('It is A Draw!!!')
        end
    end
	
	-- function on creating buttons 
	local function buttons(B)
		
		if onTop(B) then
            love.graphics.setColor(1, .5, .2)
        else
            love.graphics.setColor(0, .1, .8)
		end
		
		love.graphics.rectangle('fill', B.x, B.y, B.width, B.height)
		love.graphics.setColor(1, 1, 1)
		love.graphics.print(B.message, B.x + B.mLX, B.y + B.mLY)
	end
	-- enabling the function to make these buttons
	if gameover then	
		buttons(PAB)
	else	
		buttons(HB)
		buttons(SB)
	end
end



	