=begin
Use this file to define Before and After hooks for scenarios
Use a tag(s) as param

Before("@foo") do
  puts "This will run before each scenario tagged with @foo"
end

=end
Before( "@app_start") do
    app_path = "http://localhost:3000/en"
    puts "Hook"
end
