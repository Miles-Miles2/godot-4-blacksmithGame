extends CharacterBody2D

@export var SPEED := 300
@export var workStations: Node2D
@export var INTERACT_DISTANCE: float = 250.0

@export var selectedObject: Node2D = null
@export var heldObject: Node2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

'''
func getNearestStation():
	var closestDist = workStations.get_children()[0].position.distance_to(position)
	var closestStation = workStations.get_children()[0]
	for node in workStations.get_children():
		var dist = node.position.distance_to(position)
		if dist < closestDist:
			closestStation = node
	return closestStation
		
'''
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var inputDirection = Input.get_vector("left", "right", "up", "down")
	velocity = inputDirection * SPEED
	
	
	if $interactDetector.has_overlapping_areas() == true:
		var distToClosest = 999999.0
		var closestObject
		for node in $interactDetector.get_overlapping_areas():
			if node.owner.is_in_group("selectable") && node.owner != heldObject:
				var dist = position.distance_to(node.owner.position)
				if dist < distToClosest:
					distToClosest = dist
					closestObject = node.owner
		selectedObject = closestObject
		#print(selectedObject)
	else:
		selectedObject = null
	
	
	
	if Input.is_action_just_pressed("interact"):
		if selectedObject != null:
			print(selectedObject.name)
			if selectedObject.is_in_group("holdable"):
				print("is holdable")
				heldObject = selectedObject
			elif selectedObject.is_in_group("interactable"):
				print("interacting with " + selectedObject.name)
				selectedObject.get_node("furnace_view").show()
		elif heldObject:
			heldObject = null
			
			
	if heldObject:
		heldObject.position = heldObject.position.lerp(position, 0.2)
	
	move_and_slide()



func _on_interact_detector_body_exited(body):
	if body.owner == selectedObject:
		selectedObject = null
