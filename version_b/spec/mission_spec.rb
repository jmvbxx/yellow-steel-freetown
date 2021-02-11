require '../mission'

RSpec.describe Mission do
  let(:mission) { Mission.new('Minerva') }
  context "#initialize" do

    it "starts with no elapsed time" do
      expect(mission.elapsed_time).to eq 0
    end

    it "starts with no distance traveled" do
      expect(mission.distance_traveled).to eq 0
    end
  end

  # context "#distance_traveled" do
  #
  #   it "should have no distance_traveled if mission aborted" do
  #
  #   end
  # end

  context "#failed?" do

    it "should be true if mission aborted" do
      expect(mission).to receive(:aborted).and_return(true)
      expect(mission.failed?).to be_truthy
    end

    it "should be true if rocket exploded" do
      expect(mission).to receive(:exploded).and_return(true)
      expect(mission.failed?).to be_truthy
    end

    it "should be false if neither aborted or exploded" do
      expect(mission).to receive(:aborted).and_return(false)
      expect(mission).to receive(:exploded).and_return(false)
      expect(mission.failed?).to be_falsey
    end

  end

  context "#aborted" do

    it "should be false on a new mission" do
      expect(mission.aborted).to be_falsey
    end
  end

  context "#exploded" do

    it "should be false on a new mission" do
      expect(mission.exploded).to be_falsey
    end
  end
end
