extends CameraComponetClass
class_name DraggableCameraCompnent

#made by a "cool" individual

@export var InputMapName : String = "camera drag"
@export var DoVelocity : bool = false
@export var Decay : float = 10

var Velocity : Vector2 = Vector2.ZERO
var MouseStart : Vector2 = Vector2.ZERO
var GlobalPosStart : Vector2 = Vector2.ZERO
var PrevMousePos : Vector2 = Vector2.ZERO
var FlyTime : float = 0.0
var InputHold : bool = false

func _process(delta: float) -> void:
	if InputHold:
		Camera.global_position = GlobalPosStart + MouseStart - Camera.get_local_mouse_position()
	
	if DoVelocity and Velocity.length() > 10:
		Camera.global_position -= Velocity*delta
		Velocity *= pow(Decay, FlyTime)
		FlyTime += delta
	else:
		Velocity = Vector2.ZERO
	
	PrevMousePos = get_viewport().get_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(InputMapName):
		Velocity = Vector2.ZERO
		FlyTime = 0
		MouseStart = Camera.get_local_mouse_position()
		GlobalPosStart = Camera.global_position
		InputHold = true
	elif event.is_action_released(InputMapName):
		var delta = get_process_delta_time()
		Velocity = ((get_viewport().get_mouse_position() - PrevMousePos)/delta)*(Vector2(1,1)/Camera.zoom)
		InputHold = false
