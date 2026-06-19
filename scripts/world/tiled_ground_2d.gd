@tool
extends Node2D
class_name TiledGround2D

@export_range(3, 61, 2) var columns: int = 41
@export_range(3, 41, 2) var rows: int = 25
@export_range(16.0, 128.0, 1.0) var tile_size: float = 32.0
@export var grass_texture: Texture2D
@export var dirt_texture: Texture2D
@export var edge_top_texture: Texture2D
@export var edge_bottom_texture: Texture2D
@export var edge_left_texture: Texture2D
@export var edge_right_texture: Texture2D
@export var corner_top_left_texture: Texture2D
@export var corner_top_right_texture: Texture2D
@export var corner_bottom_left_texture: Texture2D
@export var corner_bottom_right_texture: Texture2D

const GENERATED_ROOT_NAME: StringName = &"_GeneratedTiles"

func _ready() -> void:
	rebuild()

func rebuild() -> void:
	_clear_generated()

	if grass_texture == null or dirt_texture == null:
		return

	var root: Node2D = Node2D.new()
	root.name = GENERATED_ROOT_NAME
	add_child(root)

	var center_column: int = floori(float(columns) * 0.5)
	var center_row: int = floori(float(rows) * 0.5)
	var start_x: float = -float(columns - 1) * tile_size * 0.5
	var start_y: float = -float(rows - 1) * tile_size * 0.5

	for row in range(rows):
		for column in range(columns):
			var position: Vector2 = Vector2(start_x + column * tile_size, start_y + row * tile_size)
			_add_tile(root, "Grass_%d_%d" % [column, row], grass_texture, position, -3)

			if _is_path_cell(column, row, center_column, center_row):
				_add_tile(root, "Dirt_%d_%d" % [column, row], dirt_texture, position, -2)

	for row in range(rows):
		for column in range(columns):
			if _is_path_cell(column, row, center_column, center_row):
				continue

			var position: Vector2 = Vector2(start_x + column * tile_size, start_y + row * tile_size)
			var has_path_above: bool = row > 0 and _is_path_cell(column, row - 1, center_column, center_row)
			var has_path_below: bool = row < rows - 1 and _is_path_cell(column, row + 1, center_column, center_row)
			var has_path_left: bool = column > 0 and _is_path_cell(column - 1, row, center_column, center_row)
			var has_path_right: bool = column < columns - 1 and _is_path_cell(column + 1, row, center_column, center_row)

			if has_path_below and has_path_right:
				_add_tile(root, "CornerTopLeft_%d_%d" % [column, row], corner_top_left_texture, position, -1)
			elif has_path_below and has_path_left:
				_add_tile(root, "CornerTopRight_%d_%d" % [column, row], corner_top_right_texture, position, -1)
			elif has_path_above and has_path_right:
				_add_tile(root, "CornerBottomLeft_%d_%d" % [column, row], corner_bottom_left_texture, position, -1)
			elif has_path_above and has_path_left:
				_add_tile(root, "CornerBottomRight_%d_%d" % [column, row], corner_bottom_right_texture, position, -1)
			elif has_path_below:
				_add_tile(root, "EdgeTop_%d_%d" % [column, row], edge_top_texture, position, -1)
			elif has_path_above:
				_add_tile(root, "EdgeBottom_%d_%d" % [column, row], edge_bottom_texture, position, -1)
			elif has_path_right:
				_add_tile(root, "EdgeLeft_%d_%d" % [column, row], edge_left_texture, position, -1)
			elif has_path_left:
				_add_tile(root, "EdgeRight_%d_%d" % [column, row], edge_right_texture, position, -1)

func _is_path_cell(column: int, row: int, center_column: int, center_row: int) -> bool:
	return column == center_column or row == center_row

func _add_tile(parent: Node, tile_name: String, texture: Texture2D, tile_position: Vector2, tile_z_index: int) -> void:
	if texture == null:
		return

	var sprite: Sprite2D = Sprite2D.new()
	sprite.name = tile_name
	sprite.position = tile_position
	sprite.texture = texture
	sprite.z_index = tile_z_index
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	parent.add_child(sprite)

func _clear_generated() -> void:
	for child in get_children():
		if child.name == GENERATED_ROOT_NAME:
			remove_child(child)
			child.free()
