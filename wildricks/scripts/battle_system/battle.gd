class_name Battle
extends Node

@onready var turn_queue: TurnQueue = $'Turn Queue' as TurnQueue
@onready var hud: BattleHUD = $HUD as BattleHUD

var overworld: GameManager

func _ready() -> void:
	var heros: Array[PlayerActor] = []
	heros.assign(turn_queue.heros.get_children())
	var enemies: Array[EnemyActor] = []
	enemies.assign(turn_queue.enemies.get_children())
	# its kinda weird how heros+enemies as Array[Actor] is
	# considered type-safe, might have to check with a debugger
	# if time allots
	for actor in (heros+enemies as Array[Actor]):
		actor.connect('death', _finish)
	hud.init(heros, enemies)
	turn_queue.init()

func _finish() -> void:
	get_tree().root.add_child(overworld)
	queue_free()
