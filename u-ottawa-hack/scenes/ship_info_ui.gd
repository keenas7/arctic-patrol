extends ColorRect
class_name UiInfoShip

var info_text : Label

func _ready() -> void:
	info_text = get_node("Label")

func showInfo(ship: Ship):
	info_text.text = "Ship Info:	"+ship.ship_display_name+" "+ship.ship_type+" \nvelocity: "+str(ship.velocity)+", fuel: "+str(ship.current_fuel)+", max fuel: "+str(ship.fuel_capacity)+", consumption rate: "+str(ship.fuel_consumption_rate)
	visible = true
