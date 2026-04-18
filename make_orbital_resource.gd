@tool
extends EditorScript

const SAVE_DIR: String = "res://Data/OrbitalBodies/"

const PLANET_ELEMENTS: Dictionary[String, Dictionary] = {
	"mercury": {"a": 0.38709927, "e": 0.20563593, "I": 7.00497902,
				"L": 252.25032350, "long_peri": 77.45779628, "long_node": 48.33076593},
	"venus": {"a": 0.72333566, "e": 0.00677672, "I": 3.39467605, 
				"L":181.97909950, "long_peri": 131.60246718, "long_node": 76.67984255},
	"earth": {"a": 1.00000261, "e": 0.01671123, "I": -0.00001531,
				"L": 100.46457166, "long_peri": 102.93768193, "long_node": 0.0},
	"mars": {"a": 1.52371034, "e": 0.09339410, "I": 1.84969142, 
				"L": 4.55343205, "long_peri": -23.94362959, "long_node": 49.55953891},
	"jupiter": {"a": 5.20288700, "e": 0.04838624, "I": 1.30439695, 
				"L": 34.39644051, "long_peri": 14.72847983, "long_node": 100.47390909},
	"saturn": {"a": 9.53667594, "e": 0.05386179, "I": 2.48599187, 
				"L": 49.95424423, "long_peri": 92.59887831, "long_node": 113.66242448},
	"uranus": {"a": 19.18916464, "e": 0.04725744, "I": 0.77263783, 
				"L": 313.23810451, "long_peri": 170.95427630, "long_node": 74.01692503},
	"neptune": {"a": 30.06992276, "e": 0.00859048, "I": 1.77004347,
				 "L":-55.12002969, "long_peri": 44.96476227, "long_node": 131.78422574}
}
const PLANET_RATES: Dictionary[String, Dictionary] = {
	"mercury": {"a": 0.00000037, "e": 0.00001906, "I": -0.00594749,
				"L": 149472.67411175, "long_peri": 0.16047689, "long_node": -0.12534081},
	"venus": {"a": 0.00000390, "e": -0.00004107, "I": -0.00078890, 
				"L": 58517.81538729, "long_peri": 0.00268329, "long_node": -0.27769418},
	"earth": {"a": 0.00000562, "e": -0.00004392, "I": -0.01294668,
				"L": 35999.37244981, "long_peri": 0.32327364, "long_node": 0.0},
	"mars": {"a": 0.00001847, "e": 0.00007882, "I": -0.00813131, 
				"L": 19140.30268499, "long_peri": 0.44441088, "long_node": -0.29257343},
	"jupiter": {"a": -0.00011607, "e": -0.00013253, "I": -0.00183714, 
				"L": 3034.74612775, "long_peri": 0.21252668, "long_node": 0.20469106},
	"saturn": {"a": -0.00125060, "e": -0.00050991, "I": 0.00193609, 
				"L": 1222.49362201, "long_peri": -0.41897216, "long_node": -0.28867794},
	"uranus": {"a": -0.00196176, "e": -0.00004397, "I": -0.00242939, 
				"L": 428.48202785, "long_peri": 0.40805281, "long_node": 0.04240589},
	"neptune": {"a": 0.00026291, "e": 0.00005105, "I": 0.00035372,
				"L": 218.45945325, "long_peri": -0.32241464, "long_node": -0.00508664}
}

func _run() -> void:
	for body in PLANET_ELEMENTS.keys():
		var data = PLANET_ELEMENTS[body]
		var rate_data = PLANET_RATES[body]
		
		var body_resource: OrbitalBody = OrbitalBody.new()
		
		body_resource.a = data["a"]
		body_resource.e = data["e"]
		body_resource.I = data["I"]
		body_resource.L = data["L"]
		body_resource.long_peri = data["long_peri"]
		body_resource.long_node = data["long_node"]
		body_resource.rate_a = rate_data["a"]
		body_resource.rate_e = rate_data["e"]
		body_resource.rate_I = rate_data["I"]
		body_resource.rate_L = rate_data["L"]
		body_resource.rate_long_peri = rate_data["long_peri"]
		body_resource.rate_long_node = rate_data["long_node"]
		
		var path: String = SAVE_DIR + body + ".tres"
		var err: Error = ResourceSaver.save(body_resource, path)
		
		if err == OK:
			print("Saved: ", path)
		else:
			push_error("failed to save: ", path, " error: ", err)
