class_name TurnQueue
extends Node

@onready var heros: Node = $Heros
@onready var enemies: Node = $Enemies

var round_count: int = 0
var turn_count: int = 0

func init() -> void:
	# TODO: initialize actors
	# TODO: connect actor signals to each other
	while true:
		play_round()

func play_round() -> void:
	round_count += 1
	print('Round '+str(round_count)+':')
	print('=======')
	for actor in (heros.get_children() as Array[PlayerActor]):
		turn_count += 1
		print('Turn '+str(turn_count)+':')
		print('current actor: '+actor.name)
		await actor.play_turn()
	for actor in (enemies.get_children() as Array[EnemyActor]):
		turn_count += 1
		print('Turn '+str(turn_count)+':')
		print('current actor: '+actor.name)
		await actor.play_turn()
