extends Control

# Configuration
@export var fade_time: float = 0.8       # Durée du fade in/out
@export var display_time: float = 2.0    # Temps pendant lequel chaque image reste visible
@export var total_images: int = 7        # Nombre total d'images de crédits
@export var next_scene: String = "res://UI/main_menu.tscn"  # Scène à ouvrir à la fin

var current_index := 1
var tween: Tween

func _ready():
	# Masquer toutes les images au début
	for i in range(1, total_images + 1):
		var node_name = "credit_%d" % i
		if has_node(node_name):
			var img = get_node(node_name)
			img.modulate.a = 0.0
			img.visible = false

	# Démarrer la séquence
	show_next_credit()


func show_next_credit():
	if current_index > total_images:
		# Quand tout est fini → Charger la scène du menu
		print("Crédits terminés, ouverture du menu...")
		get_tree().change_scene_to_file(next_scene)
		return

	var node_name = "credit_%d" % current_index
	if not has_node(node_name):
		current_index += 1
		show_next_credit()
		return

	var img = get_node(node_name)
	img.visible = true

	# Crée un tween pour le fade in/out
	tween = create_tween()

	# Fade in
	tween.tween_property(img, "modulate:a", 1.0, fade_time)

	# Affichage pendant un certain temps
	tween.tween_interval(display_time)

	# Fade out
	tween.tween_property(img, "modulate:a", 0.0, fade_time)

	# Quand le fade est fini, on passe à l’image suivante
	tween.finished.connect(func():
		img.visible = false
		current_index += 1
		show_next_credit()
	)
