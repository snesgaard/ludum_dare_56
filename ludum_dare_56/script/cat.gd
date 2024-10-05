extends RigidBody3D

@onready var move_timer = $Timer

var force = 500

var rng = RandomNumberGenerator.new()

func _find_nearest_creature() -> Node:
	var creatures = get_tree().get_nodes_in_group("creature")
	var closest = null
	var dist = INF
	for c in creatures:
		var d = self.position.distance_squared_to(c.position)
		if d < dist:
			dist = d
			closest = c
	
	return closest 

func _move_forward() -> void:
	var target = _find_nearest_creature()
	if target == null:
		return

	var n = (target.position - self.position).normalized()
	apply_central_force(n * force)
	force += 100.0
	apply_torque_impulse(n * force / 10)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	move_timer.timeout.connect(_move_forward)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
