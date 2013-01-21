require "spec_helper"
require "active_support/core_ext/string/strip"

module CodeHunter
  describe Renderer do
    describe ".render(warnings, options = {})" do
      subject do
        described_class.render(warnings, options)
      end

      let(:warnings) do
        [{ :a => :b }]
      end

      let(:options) do
        { :format => format }
      end

      shared_examples_for "render warnings with yaml" do
        it "renders warnings as yaml" do
          should == <<-EOS.strip_heredoc
            ---
            - :a: :b
          EOS
        end
      end

      context "when options[:format] is not specified" do
        let(:format) do
          nil
        end
        include_examples "render warnings with yaml"
      end

      context "when options[:format] is :yaml" do
        let(:format) do
          :yaml
        end
        include_examples "render warnings with yaml"
      end

      context "when options[:format] is :json" do
        let(:format) do
          :json
        end
        it "renders warnings as json" do
          should == '[{"a":"b"}]'
        end
      end

      context "when options[:format] is invalid" do
        let(:format) do
          :invalid
        end
        it { expect { subject }.to raise_error(ArgumentError) }
      end
    end
  end
end
