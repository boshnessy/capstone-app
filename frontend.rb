require 'unirest'

# LOG IN
# p "Enter email"
# input_email = gets.chomp
# p "Enter password"
# input_password = gets.chomp

# response = Unirest.post("localhost:3000/user_token",
#   parameters: {
#     auth: {
#       email: input_email,
#       password: input_password
#     }
#   }
# )

# p response.body

# jwt = response.body["jwt"]
# Unirest.default_header("Authorization", "Bearer #{jwt}")

# p jwt

# SHOW ACTION
# p "Enter search term"
# search = gets.chomp

# response = Unirest.get("localhost:3000/events?search=#{search}")

# p response.body

# CREATE ACTION
response = Unirest.post("localhost:3000/events", 
  parameters: {
    date: "Apr 8, 2018",
    artist: "me",
    venue: "condo",
    city: "Chicago"
  }
)

p response.body