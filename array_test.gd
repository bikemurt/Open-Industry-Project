@tool
extends Node3D

@export var enable_comms := true
@export var tag_group_name := "TagGroup0"
@export var tag_name := ""
@export var elem_count := 0
@export var data: Array[int] = []

var register_tag_ok := false

func _enter_tree() -> void:
	SimulationEvents.simulation_started.connect(_on_simulation_started)
	OIPComms.tag_group_polled.connect(_tag_group_polled)

func _exit_tree() -> void:
	SimulationEvents.simulation_started.disconnect(_on_simulation_started)
	OIPComms.tag_group_polled.disconnect(_tag_group_polled)

func _on_simulation_started() -> void:
	if enable_comms:
		register_tag_ok = OIPComms.register_tag(tag_group_name, tag_name, elem_count)
		
func _tag_group_polled(_tag_group_name: String) -> void:
	if not enable_comms: return
	if _tag_group_name == tag_group_name:
		data = OIPComms.read_int32_array(tag_group_name, tag_name)
