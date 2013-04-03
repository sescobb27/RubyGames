#!/usr/bin/env ruby
require_relative "game"
require_relative "about"
class Title < State
	def initialize
		super
		@title_text = Text.new 0, 35, "Pong", 100
		@play_text = Text.new 0, 200, "Play Game", 30
		@about_text = Text.new 0, 275, "About", 30
		@quit_text = Text.new 0, 350, "Quit", 30
		[@title_text, @play_text, @about_text, @quit_text].each do |text|
			text.center_x @screen.width
		end
	end

	def update
		@queue.each do |event|
			case event
				when Rubygame::QuitEvent
					Rubygame.quit
					exit
				when Rubygame::KeyDownEvent
					case event.key
						when Rubygame::K_ESCAPE
							@queue.push Rubygame::QuitEvent.new
					end
				when Rubygame::MouseDownEvent
					case event.button
						when Rubygame::MOUSE_LEFT
							selector event.pos					
					end
			end
		end
	end

	def selector(event_position)
		pos_x = event_position[0]
		pos_y = event_position[1]
		[@play_text, @about_text, @quit_text].each do |text|
			if text.x + text.width >= pos_x and text.y + text.height >= pos_y
				exec_action text.score
				break
			end
		end
	end

	def exec_action(action)
		case action
			when "Play Game"
				g = Game.new
				g.run
			when "About"
				about = About.new
				about.run
			when "Quit"
				Rubygame.quit
				exit
		end
	end

	def draw
		@screen.fill [0, 0, 0]
        [@title_text, @play_text, @about_text, @quit_text].each do |text|
        	text.draw @screen
        end
        @screen.flip
	end
end

title = Title.new
title.run