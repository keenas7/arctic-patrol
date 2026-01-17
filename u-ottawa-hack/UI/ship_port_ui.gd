extends Control

var port_label : Label
var vertical_container = VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	port_label = get_node("Label")
	vertical_container = get_node("ScrollContainer/VBoxContainer")
