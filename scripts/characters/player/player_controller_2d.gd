extends CharacterBody2D
class_name PlayerController2D

## Emitido sempre que a vida muda. A HealthBar do HUD escuta isto.
signal health_changed(current: float, maximum: float)
## Emitido quando a vida chega a zero.
signal died

@export_range(0.0, 600.0, 1.0) var move_speed: float = 160.0
@export var body_sprite_path: NodePath = ^"BodySprite"
@export var idle_animation: StringName = &"idle"
@export var walk_animation: StringName = &"walk"
@export var move_left_action: StringName = &"move_left"
@export var move_right_action: StringName = &"move_right"
@export var move_up_action: StringName = &"move_up"
@export var move_down_action: StringName = &"move_down"

@export_group("Vida")
@export_range(1.0, 1000.0, 1.0) var max_health: float = 100.0
@export_range(0.0, 1000.0, 1.0) var current_health: float = 100.0
@export var invulnerable: bool = false
## Teclas de teste enquanto joga: "-" tira vida, "=" cura. So pra ver a barra.
@export var debug_test_keys: bool = true

@onready var body_sprite: AnimatedSprite2D = get_node_or_null(body_sprite_path) as AnimatedSprite2D

func _ready() -> void:
	add_to_group(&"player")
	current_health = clampf(current_health, 0.0, max_health)
	health_changed.emit(current_health, max_health)

	if body_sprite != null:
		body_sprite.play(idle_animation)

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector(
		move_left_action,
		move_right_action,
		move_up_action,
		move_down_action
	)

	velocity = input_vector * move_speed
	move_and_slide()

	if body_sprite == null:
		return

	var is_moving: bool = input_vector.length_squared() > 0.0
	if is_moving:
		if not is_zero_approx(input_vector.x):
			body_sprite.flip_h = input_vector.x < 0.0
		if body_sprite.animation != walk_animation:
			body_sprite.play(walk_animation)
	elif body_sprite.animation != idle_animation:
		body_sprite.play(idle_animation)

## Tira vida. Ignora se invulneravel ou ja morto.
func take_damage(amount: float) -> void:
	if invulnerable or amount <= 0.0 or current_health <= 0.0:
		return
	current_health = clampf(current_health - amount, 0.0, max_health)
	health_changed.emit(current_health, max_health)
	if current_health <= 0.0:
		died.emit()

## Cura vida ate o maximo.
func heal(amount: float) -> void:
	if amount <= 0.0:
		return
	current_health = clampf(current_health + amount, 0.0, max_health)
	health_changed.emit(current_health, max_health)

func _unhandled_key_input(event: InputEvent) -> void:
	if not debug_test_keys:
		return
	var key := event as InputEventKey
	if key == null or not key.pressed or key.echo:
		return
	if key.keycode == KEY_MINUS:
		take_damage(10.0)
	elif key.keycode == KEY_EQUAL:
		heal(10.0)
