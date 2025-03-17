@tool
extends Node3D

@export var run_test := false:
	set(value):
		_run_test()

func _run_test() -> void:
	# removed from OIPComms extension
	#OIPComms.opc_ua_test()
	pass
