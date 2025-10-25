extends Area3D

@export var page_index: int = 7  # Numéro de la page (0 à 8)
@onready var audio_player: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if not body.is_in_group("player"):
		return

	if page_index in Global.pages_trouvees:
		return

	Global.pages_trouvees.append(page_index)
	print("📘 Page trouvée :", page_index, "| Total :", Global.pages_trouvees.size(), "/ 9")

	play_random_sound()

	if Global.pages_trouvees.size() >= 9:
		# Délai pour laisser le son se lancer
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://UI/cinematique2.tscn")
	else:
		# Supprime la page après 1 seconde si ce n'est pas la dernière
		await get_tree().create_timer(1.0).timeout
		queue_free()

func play_random_sound():
	var random_id = randi_range(1, 4)
	var sound_path = "res://assets/audio/doublage/Trouvé!" + ("" if random_id == 1 else str(random_id)) + ".wav"

	var sound = load(sound_path)
	if sound:
		audio_player.stream = sound
		audio_player.play()
	else:
		print("⚠️ Fichier introuvable :", sound_path)
