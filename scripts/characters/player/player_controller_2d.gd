extends CharacterBody2D
class_name PlayerController2D

@export_range(0.0, 600.0, 1.0) var move_speed: float = 160.0
@export var body_sprite_path: NodePath = ^"BodySprite"
@export var move_left_action: StringName = &"ui_left"
@export var move_right_action: StringName = &"ui_right"
@export var move_up_action: StringName = &"ui_up"
@export var move_down_action: StringName = &"ui_down"

@onready var body_sprite: Sprite2D = get_node_or_null(body_sprite_path) as Sprite2D

func _physics_process(_delta: float) -> void:
	var input_vector := Input.get_vector(
		move_left_action,
		move_right_action,
		move_up_action,
		move_down_action
	)

	velocity = input_vector * move_speed
	move_and_slide()

	if body_sprite != null and not is_zero_approx(input_vector.x):
		body_sprite.flip_h = input_vector.x < 0.0
