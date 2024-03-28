'''
Class that extends the base actor class with specific 
functionality to update it's turn queue randomly
extends class:`Actor`
'''
class_name EnemyActor
extends Actor

func _change_moves() -> void:
	'''
	Update's the actor's turn cycle by randomly 
	shuffling it
	'''
	print("changing... ")
	emit_signal('start_change_turn')
	turn_cycle.shuffle()
	# sim animation time
	await get_tree().create_timer(1).timeout
	emit_signal('finish_change_turn')

func _ready() -> void:
	'''
	Sets up the actor's initial turn cycle
	'''
	inventory.shuffle()
	turn_cycle = inventory.slice(0, 3) as Array[Skill]
