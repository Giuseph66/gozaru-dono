extends Node
class_name StoryState

const JOURNEY_NASCIMENTO: int = 1
const JOURNEY_BOA_VIDA: int = 2
const JOURNEY_CACADA: int = 3
const JOURNEY_ALIANCA: int = 4
const JOURNEY_CONFRONTO: int = 5
const JOURNEY_TREINAMENTO: int = 6
const JOURNEY_FINAL: int = 7

@export_group("Historia")
@export_range(1, 7, 1) var current_journey: int = JOURNEY_NASCIMENTO
@export var apply_defaults_on_ready: bool = true

@export_group("Poderes")
@export var has_gozada: bool = true
@export var has_cabecada: bool = true
@export var has_bagos: bool = true
@export var has_mijo: bool = false
@export var has_bunda_lendaria: bool = false
@export var has_combo_final: bool = false

func _ready() -> void:
	if apply_defaults_on_ready:
		apply_journey_defaults()

func apply_journey_defaults() -> void:
	has_gozada = current_journey >= JOURNEY_NASCIMENTO
	has_cabecada = current_journey >= JOURNEY_NASCIMENTO
	has_bagos = current_journey >= JOURNEY_NASCIMENTO
	has_mijo = current_journey >= JOURNEY_BOA_VIDA
	has_bunda_lendaria = current_journey >= JOURNEY_CACADA
	has_combo_final = current_journey >= JOURNEY_ALIANCA

func get_journey_name() -> String:
	match current_journey:
		JOURNEY_NASCIMENTO:
			return "Jornada 1 - O Nascimento da Liberdade"
		JOURNEY_BOA_VIDA:
			return "Jornada 2 - Vivendo a Boa Vida"
		JOURNEY_CACADA:
			return "Jornada 3 - A Cacada Comeca"
		JOURNEY_ALIANCA:
			return "Jornada 4 - Alianca e Fortalecimento"
		JOURNEY_CONFRONTO:
			return "Jornada 5 - Confronto Direto"
		JOURNEY_TREINAMENTO:
			return "Jornada 6 - Treinamento e Vinganca"
		JOURNEY_FINAL:
			return "Jornada 7 - A Luta Final"
		_:
			return "Jornada indefinida"

func get_unlocked_powers() -> PackedStringArray:
	var powers := PackedStringArray()
	if has_gozada:
		powers.append("gozada")
	if has_cabecada:
		powers.append("cabecada")
	if has_bagos:
		powers.append("bagos")
	if has_mijo:
		powers.append("mijo")
	if has_bunda_lendaria:
		powers.append("bunda_lendaria")
	if has_combo_final:
		powers.append("combo_final")
	return powers
