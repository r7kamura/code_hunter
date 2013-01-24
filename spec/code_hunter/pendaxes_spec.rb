require "spec_helper"

module CodeHunter
  describe Pendaxes do
    let(:instance) do
      described_class.new(:application_path => "./")
    end

    before do
      instance.stub(:` => result)
    end

    # Stub the result of pendaxes-oneshot command
    let(:result) do
      {
        :pendings => [
        :example  => {
            :file    => "dir/filename.rb",
            :line    => 1,
            :message => "message",
          },
        ],
      }.to_json
    end

    describe "#run" do
      it "returns an Array of parsed pendings data" do
        instance.run.should == [
          {
            :service => :pendaxes,
            :path    => "dir/filename.rb",
            :line    => 1,
            :message => "message",
          }
        ]
      end
    end
  end
end
