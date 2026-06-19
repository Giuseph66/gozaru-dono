@tool
extends Node2D
class_name IndustrialFloor2D

@export_range(3, 61, 2) var columns: int = 41
@export_range(3, 41, 2) var rows: int = 25
@export_range(16.0, 128.0, 1.0) var tile_size: float = 32.0
@export var floor_texture_a: Texture2D
@export var floor_texture_b: Texture2D
@export var floor_texture_c: Texture2D
@export var floor_texture_d: Texture2D

const GENERATED_ROOT_NAME: StringName = &"_GeneratedTiles"

func _ready() -> void:
	rebuild()

func rebuild() -> void:
	_clear_generated()

	var textures: Array[Texture2D] = [
		floor_texture_a,
		floor_texture_b,
		floor_texture_c,
		floor_texture_d,
	]

	if floor_texture_a == null:
		return

	var root: Node2D = Node2D.new()
	root.name = GENERATED_ROOT_NAME
	add_child(root)

	var start_x: float = -float(columns - 1) * tile_size * 0.5
	var start_y: float = -float(rows - 1) * tile_size * 0.5

	for row in range(rows):
		for column in range(columns):
			var texture_index: int = (column * 3 + row * 5) % textures.size()
			var texture: Texture2D = textures[texture_index]
			if texture == null:
				texture = floor_texture_a

			var position: Vector2 = Vector2(start_x + column * tile_size, start_y + row * tile_size)
			_add_tile(root, "Metal_%d_%d" % [column, row], texture, position)

func _add_tile(parent: Node, tile_name: String, texture: Texture2D, tile_position: Vector2) -> void:
	var sprite: Sprite2D = Sprite2D.new()
	sprite.name = tile_name
	sprite.position = tile_position
	sprite.texture = texture
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	parent.add_child(sprite)

func _clear_generated() -> void:
	for child in get_children():
		if child.name == GENERATED_ROOT_NAME:
			remove_child(child)
			child.free()
