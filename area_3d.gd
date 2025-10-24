extends Area3D

@export var target_portal : Node3D  # Référence au portail de destination
@onready var player = $CharacterBody3D # Référence au joueur

# Quand le joueur entre dans la zone de collision
func _on_portal_body_entered(body: Node) -> void:
	if body.is_in_group("player"):  # Vérifie si c'est le joueur
		teleport_player(body)

# Fonction de téléportation du joueur
func teleport_player(player: Node) -> void:
	# Positionne le joueur à la position du portail cible
	player.global_position = $"../../Node3D".global_position
