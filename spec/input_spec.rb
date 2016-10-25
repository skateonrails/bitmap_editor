require 'spec_helper.rb'

describe Input do
  let(:input){ Input.new(input_string) }

  describe "#initialize" do
    context "invalid command" do
      let(:input_string){ "D 3 4" }
      it "should raise error" do
        expect{ input }.to raise_error(Input::UnsupportedCommand)
      end
    end

    context "valid commands" do
      context "'I' command" do
        context "valid input" do
          let(:input_string){ "I 5 6" }

          it "should set command, row and col variables" do
            expect(input.command).to eq('I')
            expect(input.col).to eq(5)
            expect(input.row).to eq(6)
          end
        end

        context "invalid input" do
          context "missing values" do
            let(:input_string){ "I  6" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end

          context "more values than expected" do
            let(:input_string){ "I 10 6 33" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end
        end
      end

      context "'C' command" do
        context "valid input" do
          let(:input_string){ "C" }

          it "should set command, row and col variables" do
            expect(input.command).to eq('C')
            expect(input.col).to be_nil
            expect(input.row).to be_nil
          end
        end

        context "invalid input" do
          context "more values than expected" do
            let(:input_string){ "C 10" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end
        end
      end

      context "'L' command" do
        context "valid input" do
          let(:input_string){ "L 5 6 A" }

          it "should set command, row, col and colour variables" do
            expect(input.command).to eq('L')
            expect(input.col).to eq(5)
            expect(input.row).to eq(6)
            expect(input.colour).to eq("A")
          end
        end

        context "invalid input" do
          context "missing values" do
            let(:input_string){ "L 6" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end

          context "more values than expected" do
            let(:input_string){ "L 10 6 33 B" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end
        end
      end

      context "'V' command" do
        context "valid input" do
          let(:input_string){ "V 10 4 6 A" }

          it "should set command, row, col and colour variables" do
            expect(input.command).to eq('V')
            expect(input.col).to eq(10)
            expect(input.row).to eq(4..6)
            expect(input.colour).to eq("A")
          end
        end

        context "invalid input" do
          context "missing values" do
            let(:input_string){ "V 6" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end

          context "more values than expected" do
            let(:input_string){ "V 10 4 6 A 33" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end
        end
      end

      context "'H' command" do
        context "valid input" do
          let(:input_string){ "H 10 4 6 A" }

          it "should set command, row, col and colour variables" do
            expect(input.command).to eq('H')
            expect(input.col).to eq(10..4)
            expect(input.row).to eq(6)
            expect(input.colour).to eq("A")
          end
        end

        context "invalid input" do
          context "missing values" do
            let(:input_string){ "H 6" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end

          context "more values than expected" do
            let(:input_string){ "H 10 4 6 A 33" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end
        end
      end

      context "'S' command" do
        context "valid input" do
          let(:input_string){ "S" }

          it "should set command variables" do
            expect(input.command).to eq('S')
            expect(input.col).to be_nil
            expect(input.row).to be_nil
          end
        end

        context "invalid input" do
          context "more values than expected" do
            let(:input_string){ "S 10 Z" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end
        end
      end

      context "'?' command" do
        context "valid input" do
          let(:input_string){ "?" }

          it "should set command variables" do
            expect(input.command).to eq('?')
            expect(input.col).to be_nil
            expect(input.row).to be_nil
          end
        end

        context "invalid input" do
          context "more values than expected" do
            let(:input_string){ "? 10 Z" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end
        end
      end

      context "'X' command" do
        context "valid input" do
          let(:input_string){ "X" }

          it "should set command variables" do
            expect(input.command).to eq('X')
            expect(input.col).to be_nil
            expect(input.row).to be_nil
          end
        end

        context "invalid input" do
          context "more values than expected" do
            let(:input_string){ "X 1 BA" }

            it "should raise error" do
              expect{ input }.to raise_error(Input::InvalidInput)
            end
          end
        end
      end

    end
  end
end
