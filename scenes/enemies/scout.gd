extends CharacterBody2D

var player_nearby: bool = false
var can_laser: bool = true
var right_gun_use: bool = true
var health: int = 30
var vulnerable:bool = true

signal laser(pos, direction)

func _process(_delta):
	if player_nearby:
		look_at(Globals.player_pos)
		if can_laser:
#			var pos: Vector2 = $LaserSpawnPositions/Marker2D.global_position
#			laser.emit(pos, direction)
#	To get only one of the children nodes, we use "get_child(<index>)"
			var marker_node = $LaserSpawnPositions.get_child(right_gun_use)
#	This makes sure that firing happens from both guns alternatively
			right_gun_use = not right_gun_use
#	Now, to select a position at random, use randi() % <highest number of randomness>
			var pos: Vector2 = marker_node.global_position
#	Target pos - current pos and then normalize everything
			var direction: Vector2 = (Globals.player_pos - position).normalized()
#   Now, we emit the position that is selected above but in a position that is global and not relative to player
			laser.emit(pos, direction)
			can_laser = false
			$Timers/LaserCoolDown.start()
			
func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$Timers/HitTimer.start()
		$Sprite2D.material.set_shader_parameter("progress", 1)
		$HitSound.play()
	if health <= 0:
		queue_free()

func _on_area_2d_body_entered(_body):
	player_nearby = true


func _on_area_2d_body_exited(_body):
	player_nearby = false

func _on_laser_cool_down_timeout():
	can_laser = true

func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
