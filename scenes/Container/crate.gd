extends ItemContainer

func hit():
	if not opened:
	#	print("crate " + str(current_direction))
		$LidSprite.hide()
		$AudioStreamPlayer2D.play()
	#	To make sure that items are generated from multiple positions when crate is shot
		for i in range(5):
			#	Choosing random spawn positions
			var pos = $SpawnPosition.get_child(randi()%$SpawnPosition.get_child_count()).global_position
			open.emit(pos, current_direction)
	#	Setting opened to true
		opened = true
