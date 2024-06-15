extends Node

signal stat_change

var player_hit_sound: AudioStreamPlayer2D

var laser_amount = 20:
	set(value):
		laser_amount = value
		stat_change.emit()
		
var grenade_amount = 5:
	set(value):
		grenade_amount = value
		stat_change.emit()
	
var player_vulnerable: bool = true

var health = 60: 
	set(value):
		if value > health:
			health = min(value, 100) # min will choose the min of value and 100, limiting the health to 100
		else:
			if player_vulnerable:
				health = value
				# To stop player getting hurt a lot in just one frame only
				player_vulnerable = false
				# Function to start a countdown of time till the player is invulnerable
				player_invulnerable_timer()
				player_hit_sound.play()
		stat_change.emit()

func player_invulnerable_timer():
	# Creating a custom timer purely in script
	await get_tree().create_timer(0.5).timeout
	player_vulnerable = true

var player_pos: Vector2

func _ready():
	# This 👇 will create a whole new node
	player_hit_sound = AudioStreamPlayer2D.new()
	# Then we specify what kind of sound we want to play 👇
	player_hit_sound.stream = load("res://audio/solid_impact.ogg")
	# Add this node to the child 👇
	add_child(player_hit_sound)
	# After this, you have to play this player hit sound when the player is hit
