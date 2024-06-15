extends CharacterBody2D

#var test_value:int = 1
#func test_function():
#	print("This is a test function inside player " + str(test_value))

var can_laser: bool = true
var can_grenade: bool = true

signal laser(pos, direction)
signal grenade(pos, direction)


@export var max_speed: int = 500
var speed: int = max_speed

func hit():
	Globals.health -= 10

func _process(_delta):
	# get_vector is a method to get the distance covered in all 4 directions in below syntax
	var direction = Input.get_vector("left", "right", "up", "down")
#	print(direction)
#   Now, position = position + (direction x 500) x delta_time
#	position += direction * 500 * delta
#	The above statement won't work with CharacterBody2D node
#	To use CharacterBody2D, you have to use the method moveAndSlide
	
#	Need to update velocity, which is property of CharacterBody2D
	velocity = direction * speed
#   This method is used to get collision working in CharacterBody2D
#	move_and_slide automatically includes delta so no need of multiplying it anywhere
	move_and_slide()

	Globals.player_pos = global_position

#	Creating direction in which grenade is fired which is same as player direction
#   To calculate it, we substract mouse position from player position as done below
	var player_direction = (get_global_mouse_position() - position).normalized()

	# laser shooting input
	if Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount > 0:
	#	Updating global variables
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
	#	print("Shoot Laser")
	# 	Randomly choose a marker 2D for the laser start.
		can_laser = false
		$Laser_Timer.start()
	#	To emit the position we selected, we first gather the positions in one variable
		var laser_markers = $LaserStartPosition.get_children()
	#	Now, to select a position at random, use randi() % <highest number of randomness>
		var selected_laser = laser_markers[randi() % laser_markers.size()]
	
	#   Now, we emit the position that is selected above but in a position that is global and not relative to player
		laser.emit(selected_laser.global_position, player_direction)
		
	# Secondary action
	if Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount > 0:
		Globals.grenade_amount -= 1
#		print("shoot grenade")
		can_grenade = false
		$Grenade_Timer.start()
	#	In this case, we pick a position from the array
		var pos = $LaserStartPosition.get_children()[0].global_position
	
	#	Sending/ emiting the position
		grenade.emit(pos, player_direction)
		
	# Rotate player and make it look towards the cursor
	look_at(get_global_mouse_position())

func _on_timer_timeout():
	can_laser = true

func _on_grenade_timer_timeout():
	can_grenade = true

#func add_item(type:String) -> void:
#
#	Hence we create a signal to update the UI whcih we access through level as UI scene resides in it
#	update_stats.emit()
