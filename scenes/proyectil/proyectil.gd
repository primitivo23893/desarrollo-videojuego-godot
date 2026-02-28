extends RigidBody2D

func _ready() -> void:
	rotation = $"../Player".rotation
	linear_velocity = Vector2(0.0, -600.0).rotated($"../Player".rotation)
	


func _process(delta: float) -> void:
	
	pass

func ya_salio() -> void:
	queue_free()


func _on_body_entered(body: Node) -> void:
	body.queue_free()
