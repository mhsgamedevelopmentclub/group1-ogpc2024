class_name BattleHUD
extends CanvasLayer

@onready var inventory: Inventory = (
	$'HBoxContainer/VBoxContainer/Inventory' as Inventory)
@onready var turn_wheel: TurnWheel = (
	$'HBoxContainer/VBoxContainer/Turn Wheel' as TurnWheel)
@onready var atb_container: ATBContainer = (
	$'HBoxContainer/VBoxContainer2/ATB Container' as ATBContainer)
@onready var battle_background: BattleBackground = (
	$'HBoxContainer/VBoxContainer2/Battle Background' as BattleBackground)

func init(heros: Array[PlayerActor], enemies: Array[EnemyActor]) -> void:
	battle_background.init(heros, enemies)
	atb_container.init(heros, enemies)
	# TODO: Have Inventory UI support multiple actors
	# This can be done by combining these two into one scene
	# and having it pop up and hide dynamically inside battle
	inventory.init(heros[0])
	turn_wheel.init(heros[0])
