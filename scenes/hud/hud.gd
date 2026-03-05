extends CanvasLayer

signal start_game

var kills = 0

func _ready() -> void:
	$Fade.show()
	$Mobile.hide()
	# Easter egg
	$ScoreKillLabel.hide()
	$Eliminados.hide()

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if not $Mobile.visible:
			$Mobile.show()
	elif event is InputEventKey or event is InputEventJoypadButton:
		if $Mobile.visible:
			$Mobile.hide()


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Ahora Meta tiene todos tus datos!")
	await $MessageTimer.timeout
	$MessageLabel.text = "¡Proteje tu libertad!"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
	
func update_score_kill(reset= null): 
	if reset:
		kills+=1
	else:
		kills = 0

	$ScoreKillLabel.text = str(kills)
	
func show_easter_egg(status):
	 # Recibe de SIGNAL de Player
	$EasterEggParticle.emitting = true
	if status:
		$ScoreKillLabel.show()
		$Eliminados.show()
	else:
		$ScoreKillLabel.hide()
		$Eliminados.hide()
	
func update_health(vidas): 
	# Reibe una señal de player al colicionar

	if vidas < 3 and vidas != 0:
		$DamageIndicator/AnimationPlayer.play("damage")
		
	for corazon in $Control.get_children():
		if vidas > 0:
			corazon.visible = true
			vidas -= 1
		else: 
			corazon.visible = false
	
	

func _on_start_touch_pressed() -> void:
	$StartButton.hide()
	$StartTouch.hide()
	start_game.emit()
	
func show_pause():
	$MenuPausa.visible = not $MenuPausa.visible
	
	if $MenuPausa.visible:
		# Pone el foco en el boton de contiar
		$MenuPausa/Continuar.grab_focus()
		var volumenMaster = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(&"Master")) * 100
		var volumenMusic = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(&"Music")) * 100
		var volumenEfects = AudioServer.get_bus_volume_linear(AudioServer.get_bus_index(&"Efects")) *100
		
		$MenuPausa/PorcentajeMaster.text = "General: " + str(int(volumenMaster)) + "%"
		$MenuPausa/SlideMaster.value = volumenMaster
		
		$MenuPausa/PorcentajeMusic.text = "Música: " + str(int(volumenMusic)) + "%"
		$MenuPausa/SlideMusic.value = volumenMusic

		$MenuPausa/PorcentajeEfects.text = "Efectos: " + str(int(volumenEfects)) + "%"
		$MenuPausa/SlideMusicEfects.value = volumenEfects

func _on_MessageTimer_timeout():
	$MessageLabel.hide()


func _on_continuar_touch_pressed() -> void:

	get_tree().paused = not get_tree().paused
	show_pause()
	

func _VolumenMaster(value: float) -> void:
	$MenuPausa/PorcentajeMaster.text = "General: " + str(int(value)) + "%"
	value /= 100
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(&"Master"), 20 * log(value)/log(10))

func _VolumenMusica(value: float) -> void:

	$MenuPausa/PorcentajeMusic.text = "Música: " + str(int(value)) + "%"
	value /= 100
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(&"Music"), 20 * log(value)/log(10))

func _VolumenEfectos(value: float) -> void:
	$MenuPausa/PorcentajeEfects.text = "Efectos: " + str(int(value)) + "%"
	value /= 100
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(&"Efects"), 20 * log(value)/log(10))
