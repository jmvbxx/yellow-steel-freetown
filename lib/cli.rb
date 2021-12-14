# frozen_string_literal: true

module Cli
  def prompt_user(prompt)
    print "#{prompt} (Y/n) "
    input = STDIN.gets.chomp.downcase
    input = "y" if input.empty?

    input.start_with?("y")
  end
end
