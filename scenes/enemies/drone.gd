extends CharacterBody2D

var active: bool = false
var max_speed: int = 400
var speed: int = 0
var speed_multiplier: int = 1

var vulnerable: bool = true
var health: int = 50

var explosion_active: bool = false

func _ready():
	$Explosion.hide()
	$Sprite2D.show()

func _process(delta):
	# 1. Need direction
	# var direction = Vector2(1,0) # Alternative Vector2.RIGHT
	# 2. Assign velocity
	# velocity = direction * 100
	# 3. Call the function move_and_slide()
	# move_and_slide()
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_multiplier
		# We need a function to make drone explode when it collides with anything. So, for that, we use:
		var collision = move_and_collide(velocity * delta)
		print(collision)
		# Unline, move_and_slide, the above function doesn't automatically multiply velocity with delta time
		# Move_and_collide() also return a value(null if empty, NOT BOOL) if the object has collided or not.
		if collision:
			$AnimationPlayer.play("Explosion")
			explosion_active = true
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Moving_Entity")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < 400
			if in_range and "hit" in target:
				target.hit()
			
func hit():
	if vulnerable:
		health -= 10
		vulnerable = false
		$HitTimer.start()
		$Sprite2D.material.set_shader_parameter("progress", 0.9)
		$Sounds/HitSound.play()
	if health <= 0:
		# queue_free()
		$AnimationPlayer.play("Explosion")
		explosion_active = true

func stop_movement():
	speed_multiplier = 0

func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	# tween_property(body to animate, property name, new value, duration)
	tween.tween_property(self, "speed", max_speed, 6)


func _on_notice_area_body_exited(_body):
	pass # Replace with function body.


func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
