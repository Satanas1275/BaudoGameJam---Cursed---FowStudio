extends Button

@export var on_icon: Texture2D
@export var off_icon: Texture2D

var is_muted := false

func _ready():
	update_icon()

func _pressed():
	is_muted = !is_muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), is_muted)
	update_icon()

func update_icon():
	if is_muted:
		icon = off_icon
	else:
		icon = on_icon
