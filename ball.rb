require_relative "game_object"
class Ball < GameObject
	attr_accessor :speed_x, :speed_y
	def initialize(x,y)
		# Surface.load gets an image from a file and turns it into a Rubygame::Surface object
		surface = Rubygame::Surface.load "media/ball.png"
		@speed_x = 5
		@speed_y = 5
		super x, y, surface
	end

	# if the ball hits the left or right side, we reverse the x velocity, 
	# if it hits the top or bottom, we reverse the y velocity
	def update(screen, player, enemy)
		@x += @speed_x
		@y += @speed_y
		# LEFT side of the screen, enemy scores
		if @x <= 5
			enemy.increment_score
			when_scores(screen)
		end
		# RIGHT side of the screen, player scores
		if @x+@width >= screen.width-5
			player.increment_score
			when_scores(screen)
		end
		# TOP or BOTTOM side of the scree
		if @y <= 5 or @y+@height >= screen.height-5
			@speed_y *= -1
		end
	end

	def when_scores(screen)
		@speed_x *= -1
		@x = screen.width/4 + rand(screen.width/2)
		@y = rand(screen.height-50)+25
	end

	# Determine which paddle we have hit
	def collision(paddle, screen)
		# if collision is with player who is in the left side
		# move the ball one pixel in front of the paddle 
		# (so it isn't continuously colliding with the paddle), 
		# and we reverse the ball's direction.
		if paddle.x < screen.width/2
			unless @x < paddle.x-5
				@x = paddle.x+paddle.width+1
				@speed_x *= -1
			end
		else
		# else the collision is with the enemy who is in the right side
			unless @x > paddle.x+5
				@x = paddle.x-@width-1
				@speed_x *= -1
			end
		end
	end
end