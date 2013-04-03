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
	
	def update
		
	end

	def draw
		
	end

	def run
		loop do
			draw
			update
			@clock.tick
		end
	end
end