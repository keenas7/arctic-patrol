extends CameraComponetClass
class_name ZoomCameraComponent

#made by a "cool" individual

@export var ZoomOnMouse : bool = true
@export var OutZoomInputMapName : String = "zoom out"
@export var InZoomInputMapName : String = "zoom in"
@export var ResetZoomInputMapName : String = "zoom reset"
@export var ZoomMin : float = .1
@export var ZoomMax : float = 2.5
@export var ZoomStep : float = .3
var OutZoomExists : bool
var InZoomExists : bool
var ResetZoomExists : bool

func _ready() -> void:
	CameraComponentSetup()
	OutZoomExists = InputMap.has_action(OutZoomInputMapName)
	InZoomExists = InputMap.has_action(InZoomInputMapName)
	ResetZoomExists = InputMap.has_action(ResetZoomInputMapName)

func _process(_delta: float) -> void:
	if OutZoomExists and Input.is_action_just_released(OutZoomInputMapName) and Camera.zoom > Vector2(1,1)*ZoomMin:
		var prev : Vector2 = Camera.get_local_mouse_position()
		Camera.zoom -= Vector2(1,1)*ZoomStep
		if ZoomOnMouse:
			Camera.global_position += prev - Camera.get_local_mouse_position()
	
	if InZoomExists and Input.is_action_just_released(InZoomInputMapName) and Camera.zoom < Vector2(1,1)*ZoomMax:
		var prev : Vector2 = Camera.get_local_mouse_position()
		Camera.zoom += Vector2(1,1)*ZoomStep
		if ZoomOnMouse:
			Camera.global_position += prev - Camera.get_local_mouse_position()
	
	if ResetZoomExists and Input.is_action_just_released(ResetZoomInputMapName):
		Camera.zoom = Vector2(1,1)
