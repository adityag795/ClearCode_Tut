extends LevelParent

func _on_gate_player_entered_gate(_body):
#	You can also create tween as shown below and Godot will figure out the rest
	var tween = create_tween()
	tween.tween_property($Player, "speed", 0, .5)
#	get_tree().change_scene_to_file("res://scenes/levels/inside.tscn")
	TransitionLayer.change_scene("res://scenes/levels/inside.tscn")

func _on_house_player_entered():
	#	print("Player has entered house in level")
	var tween = get_tree().create_tween()

#	Generally, another tween will start after the completion of first tween.
#	In case, if you want to run all the tween animations in parallel then set this property before:
#	tween.set_parallel(true)

#	Another example:
#	tween.tween_property($Player, "modulate:a", 0, 2).from(0.5)

	tween.tween_property($Player/Camera2D, "zoom", Vector2(1,1), 1).set_trans(Tween.TRANS_QUAD)
# 	Inside the above tween methods,the parameters are in the following order:
#  	(Target Node_path, property_in_string, Change_to_value, time in seconds)




func _on_house_player_exited():
	var tween = get_tree().create_tween()
	tween.tween_property($Player/Camera2D, "zoom", Vector2(0.6,0.6), 2)
