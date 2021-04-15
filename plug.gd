extends Button

var icon_on = preload("res://plug_on.svg")
var icon_off = preload("res://plug_off.svg")

var pos = null

var on = false
var selected = false
var button_area = Rect2(self.rect_position, self.rect_size)
var lead = null

# gleda ce je button pressed
var p = false

func _process(delta):
	
	#verafaying synchronazation with a link node and correcting it
	if lead != null:
		if on != lead.on:
			on = lead.on
			if on:
				icon = icon_on
			else:
				icon = icon_off

func _input(event):
	#poveze se z gumbom s katerim ga povezes
	if event is InputEventMouseButton:
		if button_area.has_point(self.get_local_mouse_position()) and p:
			var board = self.get_parent()
			var c = true
			
			for i in board.get_child(0).get_children():
				for ii in i.get_children():
					if "plug" in ii.get_name():
						if ii.selected:
							print(ii.on)
							lead = ii
							c = false
			if c:
				for i in board.get_children():
					if "plug" in i.get_name():
						print("i m", self.get_name())
						print(i.get_name())
		
		if p:
			p = false
		else:
			p = true

func _on_plug_button_down():
	pos = get_viewport().get_mouse_position()
	selected = true


func link(name):
	print(name.on)
	lead = name


func _on_plug_button_up():
	if pos == get_viewport().get_mouse_position():
		on = false
		icon = icon_off
		lead = null

	selected = false

