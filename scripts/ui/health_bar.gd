extends Control
class_name HealthBar

## Barra de vida do HUD. Acha o jogador, escuta health_changed e atualiza a barra.
## Tambem troca a foto de perfil do Gozaru-dono conforme a vida.
## Por padrao busca o jogador pelo grupo "player"; opcionalmente use player_path.

@export var player_group: StringName = &"player"
@export var player_path: NodePath
@export var bar_path: NodePath = ^"Bar"
@export var label_path: NodePath = ^"Bar/Label"
@export var avatar_path: NodePath = ^"AvatarFrame/Avatar"
## Mostra "atual / maximo" em cima da barra.
@export var show_numbers: bool = true

@export_group("Faces por vida")
## Vida cheia / alta: cara padrao.
@export var face_normal: Texture2D
## Vida media: cara debochada ("nem ai").
@export var face_smug: Texture2D
## Vida baixa: cara seria (perigo).
@export var face_low: Texture2D
@export_range(0.0, 1.0, 0.01) var smug_below: float = 0.6
@export_range(0.0, 1.0, 0.01) var low_below: float = 0.3

@onready var bar: ProgressBar = get_node_or_null(bar_path) as ProgressBar
@onready var label: Label = get_node_or_null(label_path) as Label
@onready var avatar: TextureRect = get_node_or_null(avatar_path) as TextureRect

func _ready() -> void:
	var player := _resolve_player()
	if player == null:
		push_warning("HealthBar: jogador nao encontrado.")
		return
	if player.has_signal(&"health_changed"):
		player.health_changed.connect(_on_health_changed)
	# Sincroniza valor inicial (o jogador ja emitiu antes da gente conectar).
	if &"current_health" in player and &"max_health" in player:
		_on_health_changed(player.current_health, player.max_health)

func _resolve_player() -> Node:
	if not player_path.is_empty():
		var by_path := get_node_or_null(player_path)
		if by_path != null:
			return by_path
	return get_tree().get_first_node_in_group(player_group)

func _on_health_changed(current: float, maximum: float) -> void:
	if bar != null:
		bar.max_value = maximum
		bar.value = current
	if label != null:
		label.visible = show_numbers
		label.text = "%d / %d" % [roundi(current), roundi(maximum)]
	_update_face(current / maxf(maximum, 1.0))

func _update_face(ratio: float) -> void:
	if avatar == null:
		return
	var face: Texture2D = face_normal
	if ratio < low_below:
		face = face_low
	elif ratio < smug_below:
		face = face_smug
	if face != null:
		avatar.texture = face
