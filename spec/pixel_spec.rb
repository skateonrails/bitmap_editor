require 'spec_helper.rb'

describe Pixel do
  let(:pixel) { Pixel.new }

  describe "#colour" do
    it "should init as white colour (O)" do
      expect(pixel.colour).to eq("O")
    end
  end

  describe '#colour=' do
    context "using only one letter" do
      context "using capital letter as colour" do
        it "should set colour" do
          pixel.colour = "A"
          expect(pixel.colour).to eq("A")
        end
      end

      context "using lowercase letter as colour" do
        it "should raise error" do
          expect{ pixel.colour = "a" }.to raise_error(Pixel::InvalidColour)
        end
      end
    end

    context "using more than one letter" do
      it "should raise error" do
        expect{ pixel.colour = "AA" }.to raise_error(Pixel::InvalidColour)
      end
    end

    context "using numbers" do
      it "should not set colour" do
        expect{ pixel.colour = 1 }.to raise_error(Pixel::InvalidColour)
      end
    end
  end

  describe "#to_s" do
    it "should print colour that was set" do
      pixel.colour = "Z"
      expect(pixel.to_s).to eq("Z")
    end
  end
end
