class_name Planet extends MeshInstance3D

@export var planet_body: OrbitalBody
var kepler_solver: KeplerSolver = KeplerSolver.new()

func _ready() -> void:
	if mesh == null:
		mesh = SphereMesh.new()
	var mult: float = 1.0
	if planet_body.body_name in "earth, venus, mercury, mars":
		mult = 4.0
	mesh.radius = planet_body.radius / GameManager.AU_TO_KM * 800 * GameManager.CONVERSION_FACTOR * mult
	mesh.height = planet_body.radius / GameManager.AU_TO_KM * 2 * 800 * GameManager.CONVERSION_FACTOR * mult
	TimeManager.time_updated.connect(_on_time_updated)
	
func _on_time_updated(jd: float):
	global_position = kepler_solver.get_planet_position(planet_body, jd)
