# frozen_string_literal: true

require_relative 'spec_helper'
require '../lib/space_craft'

RSpec.describe SpaceCraft do
  let(:space_craft) { SpaceCraft.new }

  context '#current_speed' do
    it 'returns a speed within range' do
      expect(space_craft.current_speed).to be_within(0.027778).of(0.416667)
    end
  end
end
