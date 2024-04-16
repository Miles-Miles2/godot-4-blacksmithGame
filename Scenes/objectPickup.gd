extends RigidBody2D

@export var springForce: float

var mouseOffset: Vector2
var held: bool
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#input_event.connect(processInput)

func _process(delta: float) -> void:
	if (Input.is_action_just_released("click")):
		held = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if held == true:
		var mousePos = get_global_mouse_position()
		var dir = mousePos - (global_position + mouseOffset)
		print(dir)
		apply_central_impulse((springForce * dir * delta))



func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	if (event is InputEventMouseButton):
		if (event.is_pressed() == true && event.button_index == MOUSE_BUTTON_LEFT):
			#print("clicked " + str(name))
			mouseOffset = get_local_mouse_position()
			held = true
