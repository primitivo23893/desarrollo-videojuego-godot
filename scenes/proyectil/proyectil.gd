extends RigidBody2D

func _ready() -> void:
	rotation = $"../Player".rotation
	linear_velocity = Vector2(0.0, -600.0).rotated($"../Player".rotation)
	add_to_group("proyectiles")

func ya_salio() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	body.death()
