extends Node2D #PowerUp
@export var Curva: Curve

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("powerups")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var offset = $Timer.time_left / $Timer.wait_time

	var velocidad = Curva.sample(offset)

	
	$powerUp.speed_scale = velocidad
	$AnimationPlayer.speed_scale = velocidad


func _playerDetected(player: Area2D) -> void: #
	
	$Trail.emitting = true
	$flash.visible = false
	$powerUp.visible = false
	$Area2D/CollisionShape2D.call_deferred("set_disabled", true)
	$AudioStreamPlayer.play()
	
	player.get_parent().power_up()
	
	$"../Carga/AnimationPlayer".play(&"carga")
	


func _on_trail_finished() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
	pass
