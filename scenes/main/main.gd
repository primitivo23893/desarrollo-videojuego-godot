extends Node

@export var mob_scene: PackedScene
@export var power_up: PackedScene
var score
const VIDAS = 3
func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$PowerUpTimer.stop()
	$DeathSound.play()
	


func new_game():
	var tree = get_tree()
	tree.call_group(&"mobs", &"queue_free")
	tree.call_group(&"powerups", &"queue_free")
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Listo?...")
	$Music.play()
	
	$HUD.update_health(VIDAS)
	$Player.vidas = VIDAS



func _on_MobTimer_timeout():
	var mob = mob_scene.instantiate()

	var mob_spawn_location = get_node(^"MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	mob.position = mob_spawn_location.position

	var direction = mob_spawn_location.rotation + PI / 2

	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	add_child(mob)

func _on_power_up_timer_timeout() -> void:

	$PowerUpTimer.wait_time = randf_range(15.0, 30.0)

	$PowerUpTimer.start()
	
	var powerUp = power_up.instantiate()
	
	var minPos = $MarkerArribaIz.position
	var maxPos = $MarkerArribaDe.position
	
	var xRandom = randf_range(minPos.x, maxPos.x)
	var yRandom = randf_range(minPos.y, maxPos.y)
	
	powerUp.position = Vector2(xRandom, yRandom)
	
	add_child(powerUp)


func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	$PowerUpTimer.start()
