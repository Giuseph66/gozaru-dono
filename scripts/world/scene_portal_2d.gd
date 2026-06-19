extends Area2D
class_name ScenePortal2D

@export_file("*.tscn") var target_scene_path: String = ""
@export var trigger_group: StringName = &"player"
@export var enabled: bool = true

var _is_changing_scene: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if not enabled or _is_changing_scene:
		return
	if target_scene_path.is_empty():
		return
	if not body.is_in_group(trigger_group):
		return

	_is_changing_scene = true
	get_tree().change_scene_to_file(target_scene_path)
