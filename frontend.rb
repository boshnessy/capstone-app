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

# EVENT INDEX ACTION
# response = Unirest.get("localhost:3000/events?search=")

# EVENT SHOW ACTION
# p "Enter search term"
# search = gets.chomp

# response = Unirest.get("localhost:3000/events?search=#{search}")

# p response.body

# EVENT CREATE ACTION
# response = Unirest.post("localhost:3000/events", 
#   parameters: {
#     date: "Apr 8, 2018",
#     artist: "me",
#     venue: "condo",
#     city: "Chicago"
#   }
# )

# p response.body

# # FORUM CREATE ACTION
# response = Unirest.post("localhost:3000/forums", 
#   parameters: {
#     comment: "sweet",
#     event_id: 2
#   }
# )
# p response.body

# EVENT UPDATE ACTION
# p "Enter id of event you wish to update"
# id = gets.chomp
# p "Enter date"
# date = gets.chomp
# p "Enter artist"
# artist = gets.chomp
# p "Enter venue"
# venue = gets.chomp
# p "Enter city"
# city = gets.chomp

# response = Unirest.patch("localhost:3000/events/#{id}",
#   parameters: {
#     date: date,
#     artist: artist,
#     venue: venue,
#     city: city
#   }
# )

# p response.body

# EVENT DESTROY ACTION
# p "Enter the id of the event you wish to delete"
# id = gets.chomp

# response = Unirest.delete("localhost:3000/events/#{id}")
# p response.body

while true
  p "What do you want to do?"
  p "[1] Log in"
  p "[2] View events"
  p "[3] Create event"
  p "[4] Update an event"
  p "[5] Delete an event"
  p "[6] View forum"
  p "[7] Comment on an event"
  user_input = gets.chomp

    # LOGIN
  if user_input == "1"
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
  elsif user_input == "2"
    # EVENT INDEX ACTION
    response = Unirest.get("localhost:3000/events")
    p response.body
  elsif user_input == "3"
    # EVENT CREATE ACTION
    response = Unirest.post("localhost:3000/events", 
      parameters: {
        date: "Apr 8, 2018",
        artist: "me",
        venue: "condo",
        city: "Chicago"
      }
    )

    p response.body
  elsif user_input == "4"
    # EVENT UPDATE ACTION
    p "Enter id of event you wish to update"
    id = gets.chomp
    p "Enter date"
    date = gets.chomp
    p "Enter artist"
    artist = gets.chomp
    p "Enter venue"
    venue = gets.chomp
    p "Enter city"
    city = gets.chomp

    response = Unirest.patch("localhost:3000/events/#{id}",
      parameters: {
        date: date,
        artist: artist,
        venue: venue,
        city: city
      }
    )

    p response.body
  elsif user_input == "5"
    # EVENT DESTROY ACTION
    p "Enter the id of the event you wish to delete"
    id = gets.chomp

    response = Unirest.delete("localhost:3000/events/#{id}")
    p response.body
  elsif user_input == "6"
    response = Unirest.get("localhost:3000/forums")
    p response.body
  elsif user_input == "7"
    # FORUM CREATE ACTION
    response = Unirest.post("localhost:3000/forums", 
      parameters: {
        comment: "sweet",
        event_id: 2
      }
    )
    p response.body
end