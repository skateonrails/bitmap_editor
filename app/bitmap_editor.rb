class BitmapEditor

  def run
    @running = true
    puts 'type ? for help'
    image_processor = ImageProcessor.new

    while @running
      print '> '
      input_string = gets.chomp

      begin
        input = Input.new(input_string)
        image_processor.process(input)
        puts image_processor.output if image_processor.output
      rescue StandardError => e
        puts e.message
      end

      @running = false if image_processor.terminate
    end
  end
end
