extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Fin del Juego")
	await $MessageTimer.timeout
	$MessageLabel.text = "Dodge the\n Creeps!"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)

func update_health(vidas):
	for corazon in $Control.get_children():
		if vidas > 0:
			corazon.visible = true
			vidas -= 1
		else: 
			corazon.visible = false
	

func _on_StartButton_pressed():
	$StartButton.hide()
	start_game.emit()
	
func show_pause():
	$MenuPausa.visible = not $MenuPausa.visible

func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_continuar_pressed() -> void:
	get_tree().paused = not get_tree().paused
	show_pause()
