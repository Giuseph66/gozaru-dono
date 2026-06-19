extends StaticBody2D
class_name ValdomiroActor2D

@export_enum("Pobre", "Rico", "Obcecado") var visual_phase: String = "Pobre"
@export_range(1, 7, 1) var first_story_journey: int = 1
@export var story_role: String = "Antigo dono / antagonista"
@export var blocks_player: bool = true

func _ready() -> void:
	if not blocks_player:
		collision_layer = 0
		collision_mask = 0
