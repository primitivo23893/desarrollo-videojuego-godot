extends RigidBody2D
var type 

@export var colores: PackedColorArray 


func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	type = randi_range(0, mob_types.size()-1)
	
	$Death.modulate = colores[type]
	
	$AnimatedSprite2D.animation = mob_types[type]
	$AnimatedSprite2D.play()


func _destroy() -> void: 
	# Finish de Signal Particulas Death y VisibleOnScrenNotifier llaman la funcion
	queue_free()


func death():
	$Pop.play()
	$AnimatedSprite2D.visible = false
	$CollisionShape2D.set_deferred(&"disabled", true)
	$Death.emitting = true
	$"../HUD".update_score_kill(true)
