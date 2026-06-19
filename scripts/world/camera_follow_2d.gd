extends Camera2D
class_name CameraFollow2D

@export var target_path: NodePath = ^"../DepthLayer/Player"
@export_range(0.0, 30.0, 0.1) var follow_speed: float = 8.0
@export var snap_on_ready: bool = true

@onready var target: Node2D = get_node_or_null(target_path) as Node2D

func _ready() -> void:
	enabled = true
	if snap_on_ready and target != null:
		global_position = target.global_position

func _process(delta: float) -> void:
	if target == null:
		return

	var weight: float = clampf(follow_speed * delta, 0.0, 1.0)
	global_position = global_position.lerp(target.global_position, weight)
