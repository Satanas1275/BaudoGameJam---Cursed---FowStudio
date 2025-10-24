extends CharacterBody3D

const SPEED = 5.0
var camera_distance = 5.0  # distance caméra-joueur

@onready var camera = $Camera3D
@onready var animated_sprite = $AnimatedSprite3D  # Référence à l'AnimatedSprite3D

func _ready():
	add_to_group("player")
	
func _process(delta):
	# Si on appuie sur "ui_down" => caméra devant (le joueur recule)
	if Input.is_action_pressed("ui_down"):
		update_camera_position(false)
	else:
		# Quand on relâche "ui_down" => caméra revient derrière
		update_camera_position(true)

	# Gérer les animations en fonction du mouvement
	handle_animations()

func update_camera_position(behind: bool):
	var offset = Vector3(0, 2, camera_distance if behind else -camera_distance)
	camera.global_position = global_position + offset
	camera.look_at(global_position, Vector3.UP)

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

# Gère l'animation en fonction du mouvement du personnage
func handle_animations():
	# Si le personnage est immobile
	if velocity.length() == 0:
		# Animation immobile
		if animated_sprite.animation != "immobile":
			animated_sprite.play("immobile")
		return

	# Si le personnage se déplace
	if velocity.x != 0:
		# Inverser l'orientation du sprite si on va à gauche
		animated_sprite.flip_h = velocity.x < 0  # Si la vitesse X est négative, on inverse l'orientation (à gauche)
		
		# Animation de course de profil
		if animated_sprite.animation != "course_profil":
			animated_sprite.play("course_profil")
	elif velocity.z != 0:
		# Animation de marche (avant ou arrière)
		if animated_sprite.animation != "marche":
			animated_sprite.play("marche")
