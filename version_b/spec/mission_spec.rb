require '../yellow_steel_freetown'

RSpec.describe Mission, "#initialize" do
  context "start with a new mission" do
    it "starts with no elapsed time" do
      name = 'Minerva'
      mission = Mission.new(name)
      expect(mission.elapsed_time).to eq 0
    end
  end
end
