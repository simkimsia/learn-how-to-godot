extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var open_btn = $PanelContainer/VBoxContainer/Toolbar/Button
onready var file_dialog = $FileDialog
onready var text_editor = $PanelContainer/VBoxContainer/Content/Body/TextEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	open_btn.connect("pressed", self, "_on_open_btn_pressed")
	file_dialog.connect("file_selected", self, "_on_file_selected")

func _on_open_btn_pressed():
	file_dialog.popup_centered_ratio(0.5)
	
func _on_file_selected(p_path: String):
	var f = File.new()
	var exists = f.file_exists(p_path)
	if not exists:
		push_error("No such file under %s" % p_path)
	var error = f.open(p_path, File.READ_WRITE)
	if error != OK:
		push_error("Could not open file. Error code: %d" % error)
	var text = f.get_as_text()
	text_editor.text = text

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
