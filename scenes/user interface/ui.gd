extends CanvasLayer

# colors
var green: Color = Color("6bbfa3") # This uses Hexadecimal
var red:Color = Color(0.9, 0, 0,1)     # This uses RGB-A

@onready var laser_label:Label = $LaserCounter/VBoxContainer/Label
@onready var grenade_label:Label = $GrenadeCounter/VBoxContainer/Label
@onready var laser_icon:TextureRect = $LaserCounter/VBoxContainer/TextureRect
@onready var grenade_icon:TextureRect = $GrenadeCounter/VBoxContainer/TextureRect
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

# To display the numbers from global.gd everytime the scene is loaded
func  _ready():
	update_laser_text()
	update_grenade_text()
	Globals.connect("stat_change", update_stat_text)
	update_health_text()

func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)

func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)
	
func update_health_text():
#	Get the health bar through signal in _ready function from ui.gd and then update the value.
	health_bar.value = Globals.health
	
func update_stat_text():
	update_laser_text()
	update_grenade_text()
	update_health_text()

# Defining a function with parameters and stating that it returns void
func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	if amount <= 0:
		label.modulate = red
		icon.modulate = red
	else:
		label.modulate = green
		icon.modulate = green
