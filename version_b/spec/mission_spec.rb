require '../yellow_steel_freetown'

RSpec.describe Mission, "#initialize" do
  context "start with a new mission" do
    it "starts with no elapsed time" do
      name = 'Minerva'
      mission = Mission.new(name)
      expect(mission.elapsed_time).to eq 0
    end
    it "starts with no distance traveled" do
      expect(Mission.new('Minerva').distance_traveled).to eq 0
    end
  end
end
