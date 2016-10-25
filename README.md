# Bitmap Editor

This program is a test, based on this gist file https://gist.github.com/soulnafein/8ee4e60def4e5468df2f.

## Running program
To run the program, use the following command
```ruby runner.rb```

You can use the ```?``` as a input for help.

## Running specs
To run specs, you can use the ```rspec``` command


### Explaining the code
I've divided the code into following classes:
* `Pixel`: responsible to hold colour information and validations about colour value;
* `Image`: responsible to have a matrix of pixels, with operations to set colour or retrieve pixels. It also holds validations of maximum or minimum value for cols and rows;
* `Input`: responsible to parse the string from STDIN and validates command type and extra params for the command. This class do not validates the values passed as parameters because Pixel and Image classes are already doing this job;
* `ImageProcessor`: get input object and use it's command value to send methods to image, to transform/show image. It's also responsible for doing terminating the app and show help.

`BitmapEditor` class was refactored to use new classes. It also has a "begin/rescue" block in it because when something wrong occurs, the code raise a error with a message and that is used as a feedback for the user.
