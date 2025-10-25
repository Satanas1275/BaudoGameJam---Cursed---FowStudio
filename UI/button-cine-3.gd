extends Button

@onready var parent_control = get_parent()               
@onready var player = parent_control.get_node("AudioStreamPlayer")
@onready var label = parent_control.get_node("Label")
@onready var button2 = parent_control.get_node("Button2")
@onready var button3 = parent_control.get_node("Button3")
@onready var texture = parent_control.get_node("TextureRect")  # image finale

# Liste des sons spécifiques à ce bouton
var sounds = [
	preload("res://assets/audio/doublage/Qu'est-ce que….wav"),
	preload("res://assets/audio/doublage/Pas mal du tout.mp3"),
	preload("res://assets/audio/doublage/Bien joué ! Tu passe à la suite.mp3")
]

var current_index = 0
var running = false  # indique si la séquence est en cours

func _ready():
	self.pressed.connect(on_button_pressed)
	texture.visible = false  # image cachée au départ

func on_button_pressed():
	# Cache tous les boutons
	visible = false
	button2.visible = false
	button3.visible = false
	
	current_index = 0
	running = true
	play_next_sound()

func _process(delta):
	if running:
		# Vérifie si on doit passer au son suivant
		if not player.playing and current_index < sounds.size():
			play_next_sound()
		elif not player.playing and current_index >= sounds.size() and not texture.visible:
			show_image_then_change_scene()
			running = false

func play_next_sound():
	if current_index < sounds.size():
		player.stream = sounds[current_index]
		player.play()
		if label:
			label.text = "Lecture : son%d" % (current_index + 1)
		
		# Si c'est le 2ème son, on limite à 2 secondes
		if current_index == 1:
			var t = Timer.new()
			t.wait_time = 2
			t.one_shot = true
			t.autostart = true
			add_child(t)
			t.timeout.connect(_on_limited_sound_timeout)
		
		current_index += 1

func _on_limited_sound_timeout():
	player.stop()  # arrête le son après 2 secondes

func show_image_then_change_scene():
	texture.visible = false
	var t = Timer.new()
	t.wait_time = 0  # affichage 5 secondes
	t.one_shot = true
	t.autostart = true
	add_child(t)
	t.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://UI/credit.tscn")
