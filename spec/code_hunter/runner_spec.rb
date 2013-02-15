require "spec_helper"

module CodeHunter
  describe Runner do
    let(:instance) do
      described_class.new(argv)
    end

    let(:argv) do
      []
    end

    describe "#services" do
      subject(:services) do
        instance.send(:services)
      end

      context "by default" do
        it "returns all service instances" do
          services.should have(3).services
          services[0].should be_a Pendaxes
          services[1].should be_a RailsBestPractices
          services[2].should be_a Brakeman
        end
      end

      context "with --no-pendaxes option" do
        before do
          argv << "--no-pendaxes"
        end
        it "returns services without pendaxes" do
          services.should have(2).services
          services[0].should be_a RailsBestPractices
          services[1].should be_a Brakeman
        end
      end

      context "with --no-rails-best-practices option" do
        before do
          argv << "--no-rails-best-practices"
        end
        it "returns services without rails-best-practices" do
          services.should have(2).services
          services[0].should be_a Pendaxes
          services[1].should be_a Brakeman
        end
      end

      context "with --no-brakeman option" do
        before do
          argv << "--no-brakeman"
        end
        it "returns services without brakeman" do
          services.should have(2).services
          services[0].should be_a Pendaxes
          services[1].should be_a RailsBestPractices
        end
      end
    end
  end
end
