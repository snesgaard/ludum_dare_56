extends RigidBody3D

@export var light_change: int = 1

func initialize(spawn_position: Vector3):
	self.position = spawn_position

func _body_entered(other: Node) -> void:
	var is_bad_guy = other.is_in_group("badguy")
	var is_creature = other.is_in_group("creature")
	if is_bad_guy:
		Powerup.change_light.emit(light_change)
	
	if is_creature:
		Powerup.change_light.emit(-light_change)
	
	if is_bad_guy or is_creature:
		self.queue_free()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.contact_monitor = true
	self.max_contacts_reported = 1000
	body_entered.connect(_body_entered, 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
