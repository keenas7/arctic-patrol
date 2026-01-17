extends CharacterBody2D
class_name Ship

@export var nav_point_debug : Node2D
var speed : float = 500
var navigator : NavigationAgent2D

func _ready() -> void:
	navigator = get_node("NavigationAgent2D")
	navigator.navigation_finished.connect(onNavComplete)
	if nav_point_debug:
		navigator.target_position = nav_point_debug.global_position

func _process(_delta: float) -> void:
	var pos : Vector2 = navigator.get_next_path_position()
	rotate(get_angle_to(pos))
	
	if !navigator.is_target_reached():
		velocity = transform.x*speed
	else:
		velocity = Vector2.ZERO
	
	move_and_slide()

func onNavComplete():
	print("done")
	queue_free()
