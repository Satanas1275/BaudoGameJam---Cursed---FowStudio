extends Control

func _on_Button_Jouer_pressed():
	# Charge ta scène de jeu
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func _on_Button_Options_pressed():
	# Exemple : afficher une popup ou une autre scène d’options
	print("Ouvrir le menu des options")

func _on_Button_Quitter_pressed():
	# Ferme le jeu
	get_tree().quit()

#test2
