=begin
this file can be used to customize the World object that runs steps
eg

module MyHelper
  def some_helper
  ...
  end
end

World(MyHelper)

or

class MyWorld
  def some_helper
  ...
  end
end


World do
  MyWorld.new
end

=end
