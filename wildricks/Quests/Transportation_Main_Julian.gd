extends Area2D

var player_entered: bool = false
@onready var gameState = $"/root/GameState"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player_entered == true:
		if Input.is_action_just_pressed("transport"):
			if gameState.julian_quest_start == true:
				get_tree().change_scene_to_file("res://Quests/julian_room_1.tscn")
				gameState.julian_quest_room = 1
				gameState.in_main = false



func _on_body_entered(body):
	if body is CharacterBody2D:
		player_entered = true

func _on_body_exited(body):
	player_entered = false
