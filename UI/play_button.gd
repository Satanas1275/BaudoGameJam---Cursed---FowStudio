extends Button

func _pressed():
	# Charge directement la scène 3D
	get_tree().change_scene_to_file("res://salle_1.tscn")
