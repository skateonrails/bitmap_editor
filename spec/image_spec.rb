require 'spec_helper.rb'

describe Image do
  describe "#initialize" do
    it "should receive rows and cols (X and Y) to create a initial pixel mapping" do
      image = Image.new(rows: 1, cols:1)
      expect( image.rows ).to eq(1)
      expect( image.cols ).to eq(1)
      expect( image.get_pixel(0, 0) ).to be_a(Pixel)
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

  describe "#get_pixel" do
    let(:image) { Image.new(rows: 3, cols: 4) }

    context "get element in valid range" do
      it "should return a Pixel object" do
        expect( image.get_pixel(1, 2) ).to be_a(Pixel)
      end
    end

    context "get element in invalid range" do
      it "should raise error" do
        expect{ image.get_pixel(5, 6) }.to raise_error(Image::PixelNotFound)
      end
    end
  end

  describe "#set_pixel_colour" do
    let(:image) { Image.new(rows: 3, cols: 4) }

    context "using a valid range" do
      it "should set new color for pixel" do
        image.set_pixel_colour(1, 2, "A")
        expect( image.get_pixel(1,2).to_s ).to eq("A")
      end
    end

    context "using an invalid range" do
      it "should raise error" do
        expect{ image.set_pixel_colour(5, 6, "A") }.to raise_error(Image::PixelNotFound)
      end
    end
  end

  describe "#to_s" do
    it "should print the representation of image bitmap" do
      image = Image.new(rows: 3, cols: 4)
      expect( image.to_s ).to eq("OOOO\nOOOO\nOOOO")
    end
  end

  describe "#clear" do
    it "should reset pixel matrix to it's default value" do
    end
  end
end
