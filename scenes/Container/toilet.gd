extends ItemContainer

func hit():
#	print("toilet" + str(current_direction))
	if not opened:
	#	print("crate " + str(current_direction))
		$LidSprite.hide()
		$AudioStreamPlayer2D.play()
		var pos = $SpawnPosition/Marker2D.global_position
	#	To make sure that items are generated when crate is shot
		open.emit(pos, current_direction)
	#	Setting opened to true
		opened = true
