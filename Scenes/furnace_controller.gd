extends Node2D

# Called when the node enters the scene tree for the first time.

var coal = preload("res://Scenes/coal.tscn")

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	for i in range(10):
		var clone = coal.instantiate()

		clone.position = Vector2(rng.randf_range(320, 960), 360)

		add_child(clone)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

