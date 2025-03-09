@tool
class_name OIPCommsTagGroup
extends Control

signal tag_group_delete(t: OIPCommsTagGroup)
signal tag_group_save(t: OIPCommsTagGroup)

var save_data := {}

@onready var _name: LineEdit = $Panel/Name
@onready var polling_rate: SpinBox = $Panel/PollingRate
@onready var protocol: OptionButton = $Panel/Protocol
@onready var gateway: LineEdit = $Panel/Gateway
@onready var path: LineEdit = $Panel/Path
@onready var cpu: OptionButton = $Panel/CPU

var loading_complete := false

func _ready() -> void:
	_load()

func save() -> void:
	save_data["name"] = _name.text
	save_data["polling_rate"] = str(int(polling_rate.value))
	save_data["protocol"] = protocol.text
	save_data["gateway"] = gateway.text
	save_data["path"] = path.text
	save_data["cpu"] = cpu.text

func _load() -> void:
	print(save_data)
	if "name" in save_data:
		_name.text = save_data["name"]
		polling_rate.value = int(save_data["polling_rate"])
		protocol.text = save_data["protocol"]
		gateway.text = save_data["gateway"]
		path.text = save_data["path"]
		cpu.text = save_data["cpu"]
		loading_complete = true

func _on_Delete_pressed() -> void:
	tag_group_delete.emit(self)

func _on_text_changed(_new_text: String) -> void:
	if loading_complete:
		save()
		tag_group_save.emit(self)

func _on_item_selected(_index: int) -> void:
	if loading_complete:
		save()
		tag_group_save.emit(self)

func _on_value_changed(_value: float) -> void:
	if loading_complete:
		save()
		tag_group_save.emit(self)
