extends Node2D

@export var ships : Array[Ship]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in ships:
		i.navigator.target_position = global_position

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		var new_ship : Ship = preload("res://scenes/main_entities/ship/patroller/patroller.tscn").instantiate() #load a ship scene from file them make an intance that is unique and modifiable
		add_child(new_ship)
		#set some default values
		new_ship.position = Vector2(-1000,-1000)
		new_ship.navigator.target_position = global_position
		
