extends Control

var sounds = [
	preload("res://assets/audio/doublage/Salutgamin.mp3")
]

var current_index = 0

@onready var player = get_node("AudioStreamPlayer")
@onready var label = get_node("Label")
@onready var button1 = get_node("Button")
@onready var button2 = get_node("Button2")
@onready var button3 = get_node("Button3")

func _ready():
	# Au début, on cache les boutons
	button1.visible = false
	button2.visible = false
	button3.visible = false
	
	update_label()
	play_next_sound()

func _process(delta):
	if not player.playing and current_index < sounds.size():
		play_next_sound()
	elif not player.playing and current_index >= sounds.size():
		# Tous les sons ont été joués → afficher les boutons
		show_buttons()

func play_next_sound():
	if current_index < sounds.size():
		player.stream = sounds[current_index]
		player.play()
		update_label()
		current_index += 1

func update_label():
	if label:
		label.text = "Lecture : son%d" % (current_index + 1)

func show_buttons():
	button1.visible = true
	button2.visible = true
	button3.visible = true
