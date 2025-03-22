extends Node
func _process(_delta):
	DiscordRPC.run_callbacks()
	
func _ready():
	DiscordRPC.app_id = 1324976669248716800 # Application ID
	DiscordRPC.details = "Website In Godot Practice"
	DiscordRPC.state = "test"
#DiscordRPC.large_image = "example_game" # Image key from "Art Assets"
#DiscordRPC.large_image_text = "Try it now!"
#DiscordRPC.small_image = "boss" # Image key from "Art Assets"
#DiscordRPC.small_image_text = "Fighting the end boss! D:"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
# DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"

	DiscordRPC.refresh() # Always refresh after changing the values!DiscordRPC.app_id = #<your Application ID>
