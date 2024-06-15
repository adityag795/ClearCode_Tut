extends CanvasLayer

func change_scene(target: String) -> void:
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
#	TransitionLayer.change_scene(tartget)	
#	$AnimationPlayer.play("reveal")
#	The fade to black animation can be played in reverse as well as shown below:
	$AnimationPlayer.play_backwards("fade_to_black")
