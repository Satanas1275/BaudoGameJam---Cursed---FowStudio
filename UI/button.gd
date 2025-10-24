extends Button

func _pressed():
	# Charge ta scène de jeu
	get_tree().change_scene_to_file("res://UI/credit.tscn")
