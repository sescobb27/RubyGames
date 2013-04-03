class GameObject
	attr_accessor :x, :y, :width, :height, :surface

	def initialize(x,y,surface)
		@x = x
		@y = y
		@surface = surface
		@width = surface.width
		@height = surface.height
	end

	def update
		
	end

	def draw(screen)
		# @surface.blit is used to draw a surface onto another surface, blit takes 
		#3 arguments, the third one is optional. The two we provide here are: 
		# Which surface we are drawing to, in this case it's the screen
		# And where on that surface to draw the surface, we use the GameObject's x, y position for this.
		@surface.blit screen,[@x,@y]
	end

	def handle_event(event)
		
	end

	def center_x(screen_width)
		# center the object in the x-axis
		@x = screen_width/2 - @width/2
	end

	def center_y(screen_height)
		# center the object in the y-axis
		@y = screen_height/2 - @height/2
	end
end

class Background < GameObject
	# color of background
	WHITE = [255,255,255]
	def initialize(width, height)
		surface = Rubygame::Surface.new [width,height]

		# draws a filled-in box
		# The arguments draw_box_s takes are:
		# The upper-left corner
		# The bottom-right corner
		# The color to draw with

		# Top
		surface.draw_box_s [0,0], [surface.width, 5], WHITE
		# Left
		surface.draw_box_s [0,0], [5, surface.height], WHITE
		# Bottom
		surface.draw_box_s [0,surface.height-5], [surface.width, surface.height], WHITE
		# Right
		surface.draw_box_s [surface.width-5,0], [surface.width, surface.height], WHITE
		# Middle Divide
		surface.draw_box_s [surface.width/2 - 5,0], [surface.width/2 +2.5, surface.height], WHITE

		super 0,0,surface
	end
end