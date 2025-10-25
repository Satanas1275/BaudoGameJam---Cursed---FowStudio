extends Control

var sounds = [
	preload("res://assets/audio/doublage/Salutgamin.mp3"),
	preload("res://assets/audio/doublage/Sursaut_pp.wav"),
	preload("res://assets/audio/doublage/ta pas arreter de mentir (1).mp3"),
	preload("res://assets/audio/doublage/Pourquoi_.wav"),
	preload("res://assets/audio/doublage/He me coupe pas gamin.mp3"),
	preload("res://assets/audio/doublage/t'as 8 page et la couverture d'un livre a trouver.mp3")
]

var current_index = 0
@onready var player = get_node("AudioStreamPlayer")
@onready var label = get_node("Label")

func _ready():
	update_label()
	play_next_sound()

func _process(delta):
	if not player.playing and current_index < sounds.size():
		play_next_sound()
	elif not player.playing and current_index >= sounds.size():
		# Tous les sons ont été joués → change de scène
		get_tree().change_scene_to_file("res://salle_1.tscn")

func play_next_sound():
	if current_index < sounds.size():
		player.stream = sounds[current_index]
		player.play()
		update_label()
		current_index += 1

func update_label():
	if label:
		label.text = "Lecture : son%d" % (current_index + 1)
