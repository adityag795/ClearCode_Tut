extends StaticBody2D
class_name ItemContainer

# All these variables that are being initialised before the ready function
# don't contain the actual values as shown in the inspector.
# To solve this issue, we use "@onready" so that the nodes
# get initialized after completion of "_ready()" function


# In the below declaration, "rotation" is the current rotation of the object
@onready var current_direction:Vector2 = Vector2.DOWN.rotated(rotation)

# Ready_function
# Apply rotation and other properties as entered in inspector
# Creating the node

var opened : bool = false

signal open(pos, direction)
