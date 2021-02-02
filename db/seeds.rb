# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Result.delete_all
result_list = []
Dir.children('data').each do |yaml|
  result_list.append({
                       name: yaml.gsub(".yaml", ""),
                       data: File.read("data/#{yaml}")
                       # interpreter: SciolyFF::Interpreter.new(File.read("data/#{yaml}"))
                     })
end

results = Result.create(result_list)
