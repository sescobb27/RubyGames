# To be able to use text in Ruby game
require_relative "game_object"
Rubygame::TTF.setup

class Text < GameObject
	attr_reader :score
	def initialize(x = 0, y = 0, score = "0", size = 28)
		# To use a font, first we have to load it up by creating a new instance of the Rubygame::TTF class.
		@font = Rubygame::TTF.new "../media/font.ttf", size
		@score = score
		
		super x,y, re_render_text
	end

	def re_render_text
		@width,@height = @font.size_text(@score)
		# TTF#render takes a string and turns it into a Rubygame::Surface for us.
		# It takes four arguments:
		# The string to be rendered
		# Whether or not to anti-alias the text (which makes it look nicer, so I enabled it)
		# The color to render the text in
		# (optional) The background color, defaults to transparent
		@surface = @font.render(@score, true, [0, 255, 0])
	end

	# set score text
	def score=(value)
		@score = value
		re_render_text
	end

	# same as score= but, for readabillity i put this code too
	def text=(value)
		@score = value
		re_render_text
	end
end