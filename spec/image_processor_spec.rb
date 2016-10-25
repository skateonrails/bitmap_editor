require 'spec_helper.rb'

describe ImageProcessor do
  let(:image_processor){ ImageProcessor.new }
  let(:input){ Input.new(input_string) }

  describe "#process" do
    context "with invalid input object" do
      it "should raise error" do
        expect{ image_processor.process("lalala") }.to raise_error(ImageProcessor::InvalidInputType)
      end
    end

    context "with valid input object" do
      context "using 'I' command" do
        let(:input_string){ "I 5 6" }

        it "should create a new image object" do
          expect(Image).to receive(:new).with(rows: 6, cols: 5)
          image_processor.process(input)
        end
      end

      context "using 'C' command" do
        let(:input_string){ "C" }

        context "image was not created" do
          it "should raise error" do
            expect{ image_processor.process(input) }.to raise_error(ImageProcessor::ImageNotFound)
          end
        end

        context "image was created" do
          before :each do
            image_processor.process( Input.new("I 5 6") )
          end

          it "should call clear method of image object" do
            expect_any_instance_of(Image).to receive(:clear)
            image_processor.process(input)
          end
        end
      end

      context "using 'L' command" do
        let(:input_string){ "L 2 3 A" }

        context "image was not created" do
          it "should raise error" do
            expect{ image_processor.process(input) }.to raise_error(ImageProcessor::ImageNotFound)
          end
        end

        context "image was created" do
          before :each do
            image_processor.process( Input.new("I 5 6") )
          end

          it "should call set_pixel_colour method of image object" do
            expect_any_instance_of(Image).to receive(:set_pixel_colour).with(3,2,"A")
            image_processor.process(input)
          end
        end
      end

      context "using 'V' command" do
        let(:input_string){ "V 2 3 6 W" }

        context "image was not created" do
          it "should raise error" do
            expect{ image_processor.process(input) }.to raise_error(ImageProcessor::ImageNotFound)
          end
        end

        context "image was created" do
          before :each do
            image_processor.process( Input.new("I 5 6") )
          end

          it "should call set_vertical_pixel_colour_segment method of image object" do
            expect_any_instance_of(Image).to receive(:set_vertical_pixel_colour_segment).with(2, 3..6, "W")
            image_processor.process(input)
          end
        end
      end

      context "using 'H' command" do
        let(:input_string){ "H 3 5 2 Z" }

        context "image was not created" do
          it "should raise error" do
            expect{ image_processor.process(input) }.to raise_error(ImageProcessor::ImageNotFound)
          end
        end

        context "image was created" do
          before :each do
            image_processor.process( Input.new("I 5 6") )
          end

          it "should call set_vertical_pixel_colour_segment method of image object" do
            expect_any_instance_of(Image).to receive(:set_horizontal_pixel_colour_segment).with(3..5, 2, "Z")
            image_processor.process(input)
          end
        end
      end

      context "using 'S' command" do
        let(:input_string){ "S" }

        context "image was not created" do
          it "should puts nothing" do
            image_processor.process(input)
            expect(image_processor.output).to eq("")
          end
        end

        context "image was created" do
          before :each do
            image_processor.process( Input.new("I 5 6") )
          end

          it "should call to_s method of image object" do
            expect_any_instance_of(Image).to receive(:to_s)
            image_processor.process(input)
          end
        end
      end

      context "using '?' command" do
        let(:input_string){ "?" }

        it "should print help message" do
          image_processor.process(input)
          expect(image_processor.output).to eq("? - Help
I M N - Create a new M x N image with all pixels coloured white (O).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image
X - Terminate the session")
        end
      end

      context "using 'X' command" do
        let(:input_string){ "X" }

        it "should set terminate to true" do
          image_processor.process(input)
          expect(image_processor.terminate).to be true
          expect(image_processor.output).to eq('goodbye!')
        end
      end
    end
  end
end
