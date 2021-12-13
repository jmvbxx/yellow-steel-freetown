# frozen_string_literal: true

module Cli
  def prompt_user(prompt)
    print "#{prompt} (Y/n) "
    STDIN.gets.chomp.downcase.start_with?('y')
  end
end
