require_relative "game_object"
class Paddle < GameObject

	attr_reader :score

	# What we'll do is create two variables called @up_key and @down_key, 
	# and when we create the paddles in Game#initialize we'll give each 
	# paddle separate keys to react to.
	def initialize(x, y, up_key, down_key,
						top_limit, bottom_limit, score_x, score_y)
		# se crea una nueva superficie la cual sera roja
		surface = Rubygame::Surface.new [20,100]
		surface.fill [255,0,0]
		@moving_up = false
		@moving_down = false
		@up_key = up_key
		@down_key = down_key
		@top_limit = top_limit
		@bottom_limit = bottom_limit
		@score = 0
		@score_text = Text.new score_x, score_y, @score.to_s, 100
		super x,y,surface
	end

	def increment_score
		@score += 1
		@score_text.score = @score.to_s
	end

	def reset_score
		@score = 0
		@score_text.score = @score.to_s
	end

	def draw(screen)
		super
		@score_text.draw screen
	end

	def handle_event(event)
		case event
			when Rubygame::KeyDownEvent
				# the event object has a quite useful attribute called key, which tells us 
				# which key we're interacting with. The value of event.key is an integer
				if event.key == @up_key
					@moving_up = true
				elsif event.key == @down_key
					@moving_down = true
				end
			when Rubygame::KeyUpEvent
				if event.key == @up_key
					@moving_up = false
				elsif event.key == @down_key
					@moving_down = false
				end
		end
	end

	def update
		if @moving_up and @y > @top_limit
			@y -= 5
		elsif @moving_down and @y+@height < @bottom_limit
			@y += 5
		end
	end
end