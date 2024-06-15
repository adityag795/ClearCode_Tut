extends Node2D

class_name LevelParent
# var test_array: Array[String] = ["Test", "Hello", "Stuff"]

#func _ready():
#	get_node("Logo").rotation_degrees = 90
#	$Logo.rotation_degrees = 90
	
	# i represents the content in the array & not any number/index
#	for i in test_array:
#		print(i)
#
#	print(test_array[0])
	
#func _process(delta):
#	$Logo.rotation_degrees += 10 * delta
	
	# flow -> if rotation > 180, then change back to 0
	
#	if $Logo.position.x > 1000:
#		$Logo.pos.x = 0
	
#	print(Input.is_action_pressed("left"))
# ************************************************ #

# To instantiate "laser" scene, we need to do 2 steps:
# Step 1: Preload the scene that we have just created
# You can force a certain data type as well as shown below
var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")

var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

func _ready():
	for container in get_tree().get_nodes_in_group('Container'):
# if "open" signal is received, we will run the function after ","
		container.connect("open", _on_container_opened)
# Looking for scouts in group
	for scout in get_tree().get_nodes_in_group("Scouts"):
		scout.connect('laser', _on_scout_laser)

func _on_container_opened(pos, direction):
	var item = item_scene.instantiate()
# updating position below as default position will be (0, 0)
	item.position = pos
	item.direction = direction

# using call deffered to avoid physics error with staticbody nodes
	$Items.call_deferred('add_child', item)

func create_laser(pos, direction):
	#	print("laser from level")
# 	Step 2: Instantiate the scene
	var laser = laser_scene.instantiate() as Area2D
#	1. Update the laser position
	laser.position = pos
#	2. We have to move the laser
#	Laser has been given a velocity and direction in the laser script
#	But to send the laser in player direction, 
#	we raotate laser to an angle as shown below
#	and to rotate the laser in the direction of default direction vector, we add 90 degrees which could have been down in the scene as well as to player
	laser.rotation_degrees = rad_to_deg(direction.angle()) + 90
#	OR laser.rotation = direction.angle()
#	And now we give direction to the laser
	laser.direction = direction
#	3. I want to add the laser instance to a Node2D called projectiles
	$Projectiles.add_child(laser)
	

func _on_player_laser(pos, direction):
	create_laser(pos, direction)
#	Updating the UI
#	$UI.update_laser_text()  Commented out because this is being done in global script


func _on_player_grenade(pos, direction):
#	print("grenade from level")
#	Step2: Instantiating the grenade as a Rigidbody2D
	var grenade = grenade_scene.instantiate() as RigidBody2D
	# 1. Update the grenade position
	grenade.position = pos
	grenade.linear_velocity = direction * grenade.speed 
	$Projectiles.add_child(grenade)
#	Updating the UI
#	$UI.update_grenade_text()   Commented out because this is being done in global script

func _on_scout_laser(pos, direction):
	create_laser(pos, direction)


#  Commented out because this is being done in global script
#func _on_player_update_stats():
#	$UI.update_laser_text()
#	$UI.update_grenade_text()
