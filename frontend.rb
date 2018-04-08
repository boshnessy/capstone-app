require 'unirest'

p "Enter email"
input_email = gets.chomp
p "Enter password"
input_password = gets.chomp

response = Unirest.post("localhost:3000/user_token",
  parameters: {
    auth: {
      email: input_email,
      password: input_password
    }
  }
)

p response.body

jwt = response.body["jwt"]
Unirest.default_header("Authorization", "Bearer #{jwt}")

p jwt