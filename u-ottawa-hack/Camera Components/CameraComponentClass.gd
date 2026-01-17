extends Node
class_name CameraComponetClass

#made by a "cool" individual

@export var Camera : Camera2D = null

func _ready() -> void:
	CameraComponentSetup()

func CameraComponentSetup():
	if Camera == null:
		Camera = get_parent()
