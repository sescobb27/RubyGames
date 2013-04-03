# #!/usr/bin/env ruby
require "rubygems"
require "rubygame"
require_relative "jugador"
require_relative "game_object"
require_relative "ball"
require_relative "text"
require_relative "title"
require_relative "state"

class Game < State
	@@music = Rubygame::Music.load("media/background.ogg")
	def initialize
		super
		# sets the number of times the music will repeat, -1 makes it repeat indefinitely.
		@@music.play repeats: -1
		@background = Background.new @screen.width, @screen.height

		initialize_players

		# creating the ball in the center of the screen
		@ball = Ball.new @screen.width/2, @screen.height/2

		initialize_win_variables

		pause_state
	end

	def pause_state
		@paused = false
		@pause_text = Text.new 0,0,"Paused",25
		@pause_text.center_x @screen.width
		@pause_text.center_y @screen.height
	end

	def initialize_players
		top_limit = 5
		bottom_limit = @screen.height-5
		# score placeholders
		# use percentages of the screen width to hopefully keep the 
		# scores in a good position no matter what the resolution is
		player_score_x = @screen.width * 0.20
		enemy_score_x = @screen.width * 0.70
		paddles_score_y = 35
		# setting the coordinates of paddles, the moving keys and the top, bottom limits
		@player = Paddle.new 50, 10, 
					Rubygame::K_W, Rubygame::K_S, top_limit, bottom_limit,
					player_score_x, paddles_score_y
		@enemy = Paddle.new @screen.width-50-@player.width, 10,
					Rubygame::K_UP, Rubygame::K_DOWN, top_limit, bottom_limit,
					enemy_score_x, paddles_score_y
		# center the paddles
		@player.center_y @screen.height
		@enemy.center_y @screen.height
	end

	def initialize_win_variables
		@won = false
		@win_text = Text.new
		@play_again_text = Text.new 0, 0, "Play Again? Press Y or N", 25
	end

	def win(player)
		case player
			when 1
				@win_text.text = "Player 1 wins the match"
			when 2
				@win_text.text = "Player 2 wins the match"
		end
		@won = true
		@win_text.center_x @screen.width
		@win_text.center_y @screen.height
		@play_again_text.center_x @screen.width
		@play_again_text.y = @win_text.y + 60
	end

	def update
			@player.update
			@enemy.update
			@ball.update @screen,@player,@enemy if !@paused and !@won
			if @player.score == 11
				win 1
			elsif @enemy.score == 11
				win 2
			end
			# if there is a collision call the collision method on ball object
			if collision? @ball, @player
				@ball.collision @player, @screen
			elsif collision? @ball, @enemy
				@ball.collision @enemy, @screen
			end
		@queue.each do |event|
			@player.handle_event event
			@enemy.handle_event event
			case event
				when Rubygame::QuitEvent
					Title.new.run
				when Rubygame::KeyDownEvent
					case event.key
						when Rubygame::K_ESCAPE
							@@music.stop
							Title.new.run
						when Rubygame::K_Y
							if @won
								@player.center_y @screen.height
								@enemy.center_y @screen.height
								@player.reset_score
								@enemy.reset_score
								@won = false
							end
						when Rubygame::K_P
							if @paused
								@paused = false
								@@music.unpause
							else
								@paused = true
								@@music.pause
							end
						when Rubygame::K_N
							if @won
								@queue.push Rubygame::QuitEvent.new
							end
					end
			end
		end
	end

	def draw
		screen_text = []
		if @won
			screen_text << @win_text
			screen_text << @play_again_text
		elsif @paused
			@pause_text.draw @screen
		else
			# fill screen with black color in RGB
			@screen.fill [0,0,0]
			@background.draw @screen
			# draw the players after the background or else you won't be able to see them!
			@player.draw @screen
			@enemy.draw @screen
			# draw the ball
			@ball.draw @screen
		end
		super screen_text
	end

	# It works by seeing if it can rule out the possibility of a collision
	def collision?(ball, paddle)
		if ball.y + ball.height < paddle.y
			return false
		end
        if ball.y > paddle.y + paddle.height
         	return false 
     	end
        if ball.x + ball.width < paddle.x
        	return false
        end
        if ball.x > paddle.x + paddle.width
        	return false
        end
        return true

	end
end