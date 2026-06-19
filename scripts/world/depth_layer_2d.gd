extends Node2D
class_name DepthLayer2D

@export var use_y_sort: bool = true
@export_range(-4096, 4096, 1) var base_z_index: int = 0

func _ready() -> void:
	y_sort_enabled = use_y_sort
	z_index = base_z_index
