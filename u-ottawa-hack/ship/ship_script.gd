extends CharacterBody2D
class_name Ship

@export var nav_point_debug : Node2D

var navigator : NavigationAgent2D
var begin_new_nav : bool = false
var speed : float = 500

func _ready() -> void:
	navigator = get_node("NavigationAgent2D")
	print(navigator)
	navigator.navigation_finished.connect(onNavComplete)
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
	#on a layover, call make ship on port where we stop then free yourself
	#queue_free()

func ClickedOn():
	begin_new_nav = true

func OnClick():
	if begin_new_nav:
		navigator.target_position = get_global_mouse_position()
		begin_new_nav = false
