extends StaticBody2D

signal player_entered_gate(body)

func _on_area_2d_body_entered(body):
#	print("Body has entered")
	player_entered_gate.emit(body)
