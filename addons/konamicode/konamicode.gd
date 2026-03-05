extends Node
signal success

enum TimeLimitResetMode { NO_REFRESH, REFRESH_ON_SUCCESS }

const KONAMI_CODE: Array[StringName] = [
	&"move_up", &"move_up", &"move_down", &"move_down",
	&"move_left", &"move_right", &"move_left", &"move_right"
]

@export var active: bool = true
@export var fire_only_once: bool = false
@export var time_limit_mode: bool = false
@export var timer: Timer
@export var reset_mode: TimeLimitResetMode = TimeLimitResetMode.NO_REFRESH
@export var custom_code: Array[StringName]

var _relevant_code: Array[StringName]
var _successful_presses: int = 0
var _last_axis_direction: Vector2 = Vector2.ZERO
var _ignore_until: int = 0
const AXIS_THRESHOLD: float = 0.5
const INPUT_DELAY_MS: int = 120

func _ready() -> void:
	if Engine.is_editor_hint(): return
	_relevant_code = custom_code if !custom_code.is_empty() else KONAMI_CODE
	
	if time_limit_mode and timer:
		timer.autostart = false
		timer.one_shot = true
		if not timer.timeout.is_connected(_on_timelimit_timeout):
			timer.timeout.connect(_on_timelimit_timeout)

func _input(event: InputEvent) -> void:
	if !active or Time.get_ticks_msec() < _ignore_until: return

	if event.is_pressed() and not event.is_echo():
		if event is InputEventKey or event is InputEventJoypadButton:
			for action in _relevant_code:
				if event.is_action_pressed(action):
					_process_valid_input(action)
					return

func _process(_delta: float) -> void:
	if !active or Time.get_ticks_msec() < _ignore_until: return
	
	var x = Input.get_action_strength(&"move_right") - Input.get_action_strength(&"move_left")
	var y = Input.get_action_strength(&"move_down") - Input.get_action_strength(&"move_up")
	var current_vec = Vector2(x, y)

	if current_vec.length() > AXIS_THRESHOLD:
		var discrete_dir = Vector2.ZERO
		if abs(current_vec.x) > abs(current_vec.y):
			discrete_dir.x = sign(current_vec.x)
		else:
			discrete_dir.y = sign(current_vec.y)
		
		if discrete_dir != _last_axis_direction:
			_last_axis_direction = discrete_dir
			_process_axis(discrete_dir)
	else:
		_last_axis_direction = Vector2.ZERO

func _process_axis(dir: Vector2) -> void:
	var action_map = {
		Vector2.UP: &"move_up", 
		Vector2.DOWN: &"move_down", 
		Vector2.LEFT: &"move_left", 
		Vector2.RIGHT: &"move_right"
	}
	if action_map.has(dir):
		_process_valid_input(action_map[dir])

func _process_valid_input(action_name: StringName) -> void:
	_ignore_until = Time.get_ticks_msec() + INPUT_DELAY_MS
	_check_step(action_name)

func _check_step(action_pressed: StringName) -> void:
	if _relevant_code[_successful_presses] == action_pressed:
		_successful_presses += 1
		_handle_timelimit()
	else:
		if time_limit_mode and timer: timer.stop()
		_successful_presses = 1 if _relevant_code[0] == action_pressed else 0
		if _successful_presses == 1: _handle_timelimit()
	
	if _successful_presses == _relevant_code.size():
		_complete_sequence()

func _complete_sequence() -> void:
	success.emit()
	_successful_presses = 0
	if time_limit_mode and timer: timer.stop()
	if fire_only_once: active = false

func _handle_timelimit() -> void:
	if !time_limit_mode or !timer: return
	if reset_mode == TimeLimitResetMode.NO_REFRESH and _successful_presses > 1: return
	timer.start()

func _on_timelimit_timeout() -> void:
	_successful_presses = 0
