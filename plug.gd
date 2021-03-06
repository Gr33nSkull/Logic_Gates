extends Button

var icon_on = preload("res://plug_on.svg")
var icon_off = preload("res://plug_off.svg")

var pos = null

var on = false
var selected = false
var button_area = Rect2(self.rect_position, self.rect_size)
var lead = null

#if its input or output node
var out = true

# stores if mouse button is pressed or not
var p = false

func _ready():
	if "out" in self.get_name():
		out = true
		print("ive got out in my name")
	else:
		out = false

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
	#links itself with a plug
	if event is InputEventMouseButton:
		if button_area.has_point(self.get_local_mouse_position()) and p:
			var board = self.get_parent().get_parent()
			var c = true
			for i in board.get_child(0).get_children():
				print(i)
				for ii in i.get_children():
					print("name je ", ii.get_name())
					if "plug" in ii.get_name():
						if ii.selected:
							print(ii.on)
							lead = ii
							c = false
			if c:
				for i in board.get_child(1).get_children():
					if i.selected == true:
						i.lead = self
					
			if c:
				for i in board.get_children():
					var nm = i.get_name()
					if not "input_board" in nm and not "output_board" in nm and not "remove_out" in nm and not "add_output" in nm and not "open_popup" in nm and not "remove_gate" in nm and not "gate_popup" in nm and not "Save" in nm:
						for ii in i.get_children():
							if "Label" in ii.get_name():
								continue
							print("out ", ii.get_name())
							if out != ii.out and ii.selected:
								if out:
									ii.lead = self
								else:
									lead = ii
							
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

