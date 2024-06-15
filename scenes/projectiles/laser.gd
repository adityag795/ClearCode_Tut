extends Area2D

@export var speed: int = 1000
var direction: Vector2 = Vector2.UP

func _ready():
	$SelfDestructTimer.start()
#	$AudioStreamPlayer2D.play()   OR select "Autoplay" in the insoector
func _process(delta):
		position += direction * speed * delta

#	This function will capture the body_id it hits
func _on_body_entered(body):
#	To check if a property/method is inside a node
#	if body.has_method("hit"):
# 			OR
	if "hit" in body:
		body.hit()
	queue_free()

func _on_self_destruct_timer_timeout():
	queue_free()
