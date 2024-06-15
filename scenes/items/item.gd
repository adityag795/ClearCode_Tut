extends Area2D

var rotation_speed: int = 4
# We increase the number of item to increase its probability to be picked up.
var available_options = ['laser', 'laser', 'laser', 'laser','grenade', 'health']
var type = available_options[randi()%len(available_options)]

# To generate sprite at a distance and direction from crate
var direction: Vector2
var distance: int = randi_range(150,250)

func _ready():
	if type == 'laser':
		$Sprite2D.modulate = Color(0.1, 0.2, 0.8)
	if type == 'grenade':
		$Sprite2D.modulate = Color(0.8, 0.2, 0.1)
	if type == 'health':
		$Sprite2D.modulate = Color(0.1, 0.8, 0.1)
	
#	To animate item generation using tweens
	var target_pos = position + direction * distance
	var tween = create_tween()
	tween.set_parallel(true)
# To target the object itself, use "node"
	tween.tween_property(self, "position", target_pos, 0.5)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).from(Vector2(0,0))

func _process(delta):
	rotation += rotation_speed * delta


func _on_body_entered(_body):
	if _body.name == "Player":
	#	body.add_item(type)
		if type == 'health':
			Globals.health += 10 # This updated value is sent to "value" in the setter function
		if type == 'laser':
	#	This only updates the amount but not the UI
			Globals.laser_amount += 5
		if type == 'grenade':
	#	This only updates the amount but not the UI
			Globals.grenade_amount += 2
		# So, just the below code 👇 doesn't work because as soon as the player touches the item,
		# the "item.scene" gets destroyed and the AudioStreamPlayer is destroyed with it, so you
		# won't hear the audio anymore.
		$AudioStreamPlayer2D.play()
		# Which means we want to wait "queue_free()" to wait until the sound is finished 👇.
		$Sprite2D.hide()
		await $AudioStreamPlayer2D.finished
		queue_free()
