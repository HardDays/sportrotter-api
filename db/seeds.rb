# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.new(email: :admin, password: :admin, user_type: :professional)
if !@user.save
    puts json: @user.errors
end
@prof = Professional.new()
@prof.user = @user
if !@prof.save
    puts json: @prof.errors
end