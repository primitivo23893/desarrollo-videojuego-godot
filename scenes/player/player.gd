extends Area2D
@export var proyectil: PackedScene
signal hit
signal healthHUD (vidas: int)
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

var vidas = 3

func _ready():
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var input_vector = Input.get_vector(&"move_left", &"move_right", &"move_up", &"move_down")
	
	var velocity = input_vector * speed
	
	if Input.is_action_just_pressed(&"shoot") and not $ShootTimer.is_stopped():
		var Proyectil = proyectil.instantiate()
		Proyectil.position = position + Vector2(0.0, -90.0).rotated(rotation) 
		add_sibling(Proyectil)
		
	if input_vector.length() > 0:
		$AnimationPlayer.play("bouncy")
		
		var move_angle = input_vector.angle()
		var offset = PI / 2
		rotation = move_angle + offset
		
	else:
		$AnimationPlayer.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func start(pos):
	position = pos
	rotation = 0
	show()
	$CollisionShape2D.set_deferred(&"disabled", false)
	$Cell.modulate.a = 1
	$TelegramMini.visible = false


func _on_body_entered(_body):
	if $Enfriamienro.is_stopped():
		
		$Enfriamienro.start()
		
		$CollisionShape2D.set_deferred(&"disabled", true)
		$Cell.modulate.a = 0.4
		$AudioStreamPlayer.play()
		damage()
	
	
	

func damage():
	vidas -= 1
	healthHUD.emit(vidas)
	print(vidas)
	if vidas <= 0 or vidas > 3:
		
		hide()
		hit.emit()

func _on_enfriamienro_timeout() -> void:
	if vidas > 0: 
		$CollisionShape2D.set_deferred(&"disabled", false)
		$Cell.modulate.a = 1
		
func power_up():
	$ShootTimer.start()
	$TelegramMini.visible = true
	pass
	
func _on_shoot_timer_timeout() -> void:
	$TelegramMini.visible = false
