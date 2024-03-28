'''
Class that extends the base actor class with specific 
functionality to handle turn queue updates from the 
inventory UI
extends class:`Actor`
'''
class_name PlayerActor
extends Actor

var turn_ord_updater: Signal

func _change_moves() -> void:
	'''
	Send's signal to turn queue to update the actor's
	turn cycle
	'''
	emit_signal('start_change_turn')
	await turn_ord_updater
	emit_signal('finish_change_turn')

func sync_queue(turn_queue: TurnWheel) -> void:
	'''
	Connects signals between the actor and the provided
	turn queue without having to store an explicit reference
	to it for later
	
	:param turn_queue: The turn queue UI to connect to
	:type turn_queue: class:`TurnWheel`
	'''
	connect('start_change_turn', turn_queue.on_open_change_turn)
	turn_queue.connect('update_turn_ord', reorder_turn)
	# store reference of turn queue's signal for change_moves()
	turn_ord_updater = turn_queue.update_turn_ord

func reorder_turn(turn_list: Array[Skill]) -> void:
	'''
	Updates the actor's turn cycle to the list of
	skills recieved
	'''
	turn_cycle = turn_list

