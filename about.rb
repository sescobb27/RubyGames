require_relative "state"
class About < State
	def initialize
		super
		@title_text = Text.new 0, 35, "Pong", 100
		@created_by = Text.new 0, 200, "Created By: Simon Escobar", 30
		@for_the = Text.new 0, 250, "For the Making Games", 25
		@for_the2 = Text.new 0, 300, "With Ruby Tutorial", 25

		[@title_text, @created_by, @for_the, @for_the2].each do |text|
			text.center_x @screen.width
		end

		def update
			@queue.each do |event|
				case event
					when Rubygame::QuitEvent
						Title.new.run
					when Rubygame::KeyDownEvent
						case event.key
							when Rubygame::K_ESCAPE
								Title.new.run
						end
				end
			end
		end

		def draw
			@screen.fill [0, 0, 0]
	        [@title_text, @created_by, @for_the, @for_the2].each do |text|
	        	text.draw @screen
	        end
	        @screen.flip
		end

	end
	
	
end