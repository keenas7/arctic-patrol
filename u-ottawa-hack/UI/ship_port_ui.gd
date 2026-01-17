extends ColorRect
class_name UiPort

var port_label : Label
var vertical_container : VBoxContainer
var current_active_port : Port
var adding_to_route : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	port_label = get_node("Label")
	vertical_container = get_node("ScrollContainer/VBoxContainer")

func openShipMenu(current_active_port_ : Port, docked_ships : Array[Ship]) -> void:
	current_active_port = current_active_port_
	for i in vertical_container.get_children():
		i.free()
	
	for i in range(0,len(docked_ships)):
		var button : Button = Button.new()
		button.text = str(i+1) + ": "+docked_ships[i].name
	
	visible = true

func closeMenu() -> void:
	visible = false
	adding_to_route = false
