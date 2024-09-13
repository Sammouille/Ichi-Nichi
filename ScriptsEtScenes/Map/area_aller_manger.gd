extends Area3D

var heure_manger = false


func _on_body_entered(body: Node3D) -> void:
	if heure_manger:
		body.peut_manger = true
