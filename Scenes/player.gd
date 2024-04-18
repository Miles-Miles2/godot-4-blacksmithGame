extends CharacterBody2D

@export var SPEED := 300
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
	if (not is_instance_valid(heldObject)):
		heldObject = null
	
	
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
			#print(selectedObject.name)
			if selectedObject.is_in_group("holdable"):
				#print("is holdable")
				heldObject = selectedObject
			elif selectedObject.is_in_group("interactable"):
				print("interacting with " + selectedObject.name + " while holding " + str(heldObject))
				selectedObject.interact(heldObject)
				
				#print(str(selectedObject.position) + " | " + str(selectedObject.get_node("workstation_view").position))
				
				selectedObject.get_node("workstation_view").position = Vector2(0,0)
		elif heldObject:
			heldObject = null
			
			
	if heldObject:
		heldObject.position = heldObject.position.lerp(position, 0.2)
	var inputDirection = Input.get_vector("left", "right", "up", "down")
	velocity = inputDirection * SPEED
	move_and_slide()



func _on_interact_detector_body_exited(body):
	if body.owner == selectedObject:
		selectedObject = null
