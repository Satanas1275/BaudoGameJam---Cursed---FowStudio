extends Area3D

@export var target_portal : Node3D
var can_teleport = true

func _on_area_3d_body_entered(body):
	print("Body entered:", body.name)
	if can_teleport and body.is_in_group("player"):
		print("C’est bien le joueur, on le téléporte")
		can_teleport = false
		teleport_player(body)
		await get_tree().create_timer(0.5).timeout
		can_teleport = true

func teleport_player(player: Node) -> void:
	if target_portal:
		print("Téléportation vers :", target_portal.name)
		player.global_transform.origin = target_portal.global_transform.origin
		player.velocity = Vector3.ZERO
	else:
		print("Erreur : target_portal n’est pas assigné !")
