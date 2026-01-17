extends Node2D

signal Left_Click
signal Right_Click
signal Middle_Click
signal Ctrl_Click
signal Left_Clicked_on
signal Right_Clicked_on
signal Middle_Clicked_on
signal Ctrl_Clicked_on

func _ready() -> void:
	var clicker : CollisionObject2D = get_parent()
	clicker.input_pickable = true
	clicker.input_event.connect(_on_input_event)

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	#have to put button combo above individual button press!
	if event.is_action_pressed("ctrl-click"):
		Ctrl_Clicked_on.emit()
	elif event.is_action_pressed("right-click"):
		Right_Clicked_on.emit()
	elif event.is_action_pressed("middle-click"):
		Middle_Clicked_on.emit()
	elif event.is_action_pressed("left-click"):
		Left_Clicked_on.emit()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEvent:
		if event.is_action_pressed("ctrl-click"):
			Ctrl_Click.emit()
		elif event.is_action_pressed("right-click"):
			Right_Click.emit()
		elif event.is_action_pressed("middle-click"):
			Middle_Click.emit()
		elif event.is_action_pressed("left-click"):
			Left_Click.emit()
