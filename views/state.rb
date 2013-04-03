require "rubygems"
require "rubygame"
class State
	def initialize
		@screen = Rubygame::Screen.new [640,480],0,[Rubygame::HWSURFACE,Rubygame::DOUBLEBUF]
		@screen.title = "Pong"
		
		@queue = Rubygame::EventQueue.new

		@clock = Rubygame::Clock.new

		@clock.target_framerate = 60
	end

	def draw(screen_text = [])
		screen_text.each do |text|
        	text.draw @screen
        end
		# Everything we're drawing, isn't actually being drawn to the screen, 
		# it's being drawn on a different surface that's off-screen. 
		# Rubygame::Surface#flip displays what we've been drawing to the actual screen.
		@screen.flip
	end

	def run
		loop do
			draw
			update
			@clock.tick
		end
	end
end