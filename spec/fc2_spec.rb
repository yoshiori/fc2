require "spec_helper"

describe Fc2 do
  describe ".fetch" do
    let(:m) do
      Module.new do
        def self.a
          Fc2.fetch do
            b
          end
        end

        def self.b
          1
        end
      end
    end

    it "Create cache and use cache" do
      expect(m).to receive(:b).once.and_call_original
      expect(m.a).to be 1

      expect(m.a).to be 1
    end

    context "with expires_in params" do
      let(:m2) do
        Module.new do
          def self.a
            Fc2.fetch(expires_in: 0) do
              b
            end
          end

          def self.b
            1
          end
        end
      end
      it "Use expires_in time" do
        expect(m2).to receive(:b).twice.and_call_original
        expect(m2.a).to be 1
        expect(m2.a).to be 1
      end
    end
  end
  describe ".use_cache" do
    let(:object) { klass.new }

    let(:klass) do
      Class.new do
        include Fc2
        use_cache def a
          b
        end

        def b
          1
        end
      end
    end

    it "Create cache and use cache" do
      expect(object).to receive(:b).once.and_call_original
      expect(object.a).to be 1

      expect(object.a).to be 1
    end

    context "setting in two places" do
      let(:object2) { klass2.new }

      let(:klass2) do
        Class.new do
          include Fc2
          use_cache def a
            b
          end

          def b
            2
          end
        end
      end

      it "Use cache for each" do
        expect(object).to receive(:b).once.and_call_original
        expect(object2).to receive(:b).once.and_call_original
        expect(object.a).to be 1
        expect(object2.a).to be 2

        expect(object.a).to be 1
        expect(object2.a).to be 2
      end
    end
  end
end
