extends Sprite2D
var pos:Vector2 = Vector2.ZERO
const speed:int = 100
var test_scale:int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pos = Vector2(300,200)
	position = pos
	
	var test_rotation = 45
	rotation_degrees = test_rotation

	scale = Vector2(test_scale, test_scale)
	print($"..".test_array)
	$"..".test_function()
	$"../Player".test_value = 9
	$"../Player".test_function()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pos.x += speed * delta
	position = pos
#	scale += Vector2(0.02, 0.02)
#	if position.x > 1000:
#		position.x = 0
