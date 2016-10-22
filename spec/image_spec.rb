require 'spec_helper.rb'

describe Image do
  describe "#initialize" do
    it "should receive rows and cols (X and Y) to create a initial pixel mapping" do
      image = Image.new(rows: 1, cols:1)
      expect(image.rows).to eq(1)
      expect(image.cols).to eq(1)
      expect(image[0, 0]).to be_a(Pixel)
    end

    context "setting rows value" do
      context "using rows value greater than 250" do
        it "should raise error" do
          expect{ Image.new(rows: 251) }.to raise_error(Image::InvalidRowsCount)
        end
      end

      context "using rows value lower than 1" do
        it "should raise error" do
          expect{ Image.new(rows: -1) }.to raise_error(Image::InvalidRowsCount)
        end
      end

      context "using rows value different than a integer" do
        it "should raise error" do
          expect{ Image.new(rows: 2.3) }.to raise_error(Image::InvalidRowsCount)
        end
      end
    end

    context "setting cols value" do
      context "using cols value greater than 250" do
        it "should raise error" do
          expect{ Image.new(cols: 251) }.to raise_error(Image::InvalidColsCount)
        end
      end

      context "using cols value lower than 1" do
        it "should raise error" do
          expect{ Image.new(cols: -1) }.to raise_error(Image::InvalidColsCount)
        end
      end

      context "using cols value different than a integer" do
        it "should raise error" do
          expect{ Image.new(cols: 2.3) }.to raise_error(Image::InvalidColsCount)
        end
      end
    end
  end

  describe "#[]" do
    let(:image) { Image.new(rows: 3, cols: 4) }

    context "get element in valid range" do
      it "should return a Pixel object" do
        expect(image[1, 2]).to be_a(Pixel)
      end
    end

    context "get element in invalid range" do
      it "should return nil" do
        expect(image[5, 6]).to be_nil
      end
    end
  end

  describe "#to_s" do
    it "should print the representation of image bitmap" do
      image = Image.new(rows: 3, cols: 4)
      expect(image.to_s).to eq("OOOO\nOOOO\nOOOO")
    end
  end
end
