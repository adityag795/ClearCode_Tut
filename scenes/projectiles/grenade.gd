extends RigidBody2D

const speed = 750

var explosion_active: bool = false

var explosion_radius: int = 400

func explode():
	$AnimationPlayer.play("Explosion")
	explosion_active = true
	
func _process(_delta):
	if explosion_active:
		# To fetch a list of elements/nodes that can be targetted/interacted by grenade
		var targets = get_tree().get_nodes_in_group("Container") + get_tree().get_nodes_in_group("Moving_Entity")
		
		for target in targets:
			# Checking the target's global position and if its ditance to the grenade < explosion radius
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			# If the body in explosion range has "hit" function in the script attached with it
			if "hit" in target and in_range:
				target.hit()
