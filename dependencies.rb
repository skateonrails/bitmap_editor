Dir[File.join(File.dirname(__FILE__), %w(lib *.rb))].each {|file| require file }
Dir[File.join(File.dirname(__FILE__), %w(app *.rb))].each {|file| require file }
