
require "unirest"
require "pp"
while true
  system "clear"

puts "Choose an option:"
puts "[1] Show all contacts"
puts  "[1.1] Search by first name"
puts "[2] Create a contact"
puts "[3] Show a contact"
puts "[4] Update a contact"
puts "[5] Destroy a contact"
puts
puts "[signup] Signup (create a user)"
puts "[login] Login (create a JSON web token)"
puts "[logout] Logout (erase the JSON web token)"
puts
puts "[q] Quit"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/contacts")
  contacts = response.body
  pp contacts
elsif input_option == "1.1"
  print "Enter search terms: "
  search_terms = gets.chomp
  puts "Here are the matching first names: "
  response = Unirest.get("http://localhost:3000/contacts?search=#{search_terms}")
  recipes = response.body
  pp recipe
elsif input_option == "2"
  params = {}
  print "New contact first name: "
  params[:first_name] = gets.chomp
  print "New contact middle name: "
  params[:middle_name] = gets.chomp
  print "New contact last name: "
  params[:last_name] = gets.chomp
  print "New contact full name: "
  params[:full_name] = gets.chomp
  print "what is your bio? "
  params[:bio] = gets.chomp
  print "New contact email: "
  params[:email] = gets.chomp
  print "New contact phone number: "
  params[:phone_number] = gets.chomp
  response = Unirest.post("http://localhost:3000/contacts", parameters: params)
  contact = response.body
  pp contact
elsif input_option == "3"
  print "Enter a contact id: "
  contact_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{contact_id}")
  contact = response.body
  pp contact
elsif input_option == "4"
  print "Enter a contact id: "
  contact_id = gets.chomp
  response = Unirest.get("http://localhost:3000/contacts/#{contact_id}")
  contact = response.body
  params = {}
  print "Updated first name (#{contact["first_name"]}): "
  params[:first_name] = gets.chomp
  print "Updated last name (#{contact["last_name"]}): "
  params[:last_name] = gets.chomp
  print "Updated email (#{contact["email"]}): "
  params[:email] = gets.chomp
  print "Updated phone number (#{contact["phone_number"]}): "
  params[:phone_number] = gets.chomp
  params.delete_if { |_key, value| value.empty? }
  response = Unirest.patch("http://localhost:3000/contacts/#{contact_id}", parameters: params)
  contact = response.body
  pp contact
elsif input_option == "5"
  print "Enter a contact id: "
  contact_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/contacts/#{contact_id}")
  pp response.body
  elsif input_option == "signup"
    params = {}
    print "Name: "
    params[:name] = gets.chomp
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    print "Password confirmation: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/users", parameters: params)
    pp response.body
  elsif input_option == "login"
    puts "Login to the app"
    params = {}
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    response = Unirest.post(
      "http://localhost:3000/user_token",
      parameters: {auth: {email: params[:email], password: params[:password]}}
    )
    pp response.body
    # Save the JSON web token from the response
    jwt = response.body["jwt"]
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")
  elsif input_option == "logout"
    jwt = ""
    Unirest.clear_default_headers()
  elsif input_option == "q"
    puts "Goodbye!"
    break
end
  puts 
  puts "Press enter to continue"
  gets.chomp
end