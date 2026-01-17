extends Ship

var begin_new_nav : bool = false


func clickedOn():
	begin_new_nav = true

func onClick():
	if begin_new_nav:
		navigator.target_position = get_global_mouse_position()
		begin_new_nav = false
