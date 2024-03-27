class_name Battle
extends Node

@onready var turn_queue: TurnQueue = $TurnQueue as TurnQueue
@onready var hud: BattleHUD = $HUD as BattleHUD

var overworld: GameManager

func _ready() -> void:
	var heros: Array[PlayerActor] = (
		turn_queue.heros.get_children() as Array[PlayerActor])
	var enemies: Array[EnemyActor] = (
		turn_queue.enemies.get_children() as Array[EnemyActor])
	for actor in (heros+enemies as Array[Actor]):
		actor.connect('death', _finish)
	hud.init(heros, enemies)
	turn_queue.init()

func _finish() -> void:
	get_tree().root.add_child(overworld)
	queue_free()
