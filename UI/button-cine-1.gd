extends Button

@onready var parent_control = get_parent()               
@onready var player = parent_control.get_node("AudioStreamPlayer")
@onready var label = parent_control.get_node("Label")
@onready var button2 = parent_control.get_node("Button2")
@onready var button3 = parent_control.get_node("Button3")
@onready var texture = parent_control.get_node("TextureRect")  

# Liste des sons spécifiques à ce bouton
var sounds = [
	preload("res://assets/audio/doublage/Y'a pas de deuxième…V2.wav"),
	preload("res://assets/audio/doublage/Roooohlareponsechianteamourir.mp3"),
]

var current_index = 0
var running = false  # indique si la séquence est en cours

func _ready():
	self.pressed.connect(on_button_pressed)
	texture.visible = false  

func on_button_pressed():
	# Cache tous les boutons
	visible = false
	button2.visible = false
	button3.visible = false
	
	current_index = 0
	running = true  # active la séquence
	play_next_sound()

func _process(delta):
	if running:
		if not player.playing and current_index < sounds.size():
			play_next_sound()
		elif not player.playing and current_index >= sounds.size() and not texture.visible:
			show_image_then_change_scene()
			running = false  # désactive la séquence

func play_next_sound():
	if current_index < sounds.size():
		player.stream = sounds[current_index]
		player.play()
		if label:
			label.text = "Lecture : son%d" % (current_index + 1)
		current_index += 1

func show_image_then_change_scene():
	texture.visible = true
	var t = Timer.new()
	t.wait_time = 5
	t.one_shot = true
	t.autostart = true
	add_child(t)
	t.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://UI/main_menu.tscn")
