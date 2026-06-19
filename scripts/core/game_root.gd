extends Node
class_name GameRoot

@export var world_path: NodePath = ^"World2_5D"
@export var hud_path: NodePath = ^"HUD"

@onready var world: Node = get_node_or_null(world_path)
@onready var hud: CanvasLayer = get_node_or_null(hud_path) as CanvasLayer
