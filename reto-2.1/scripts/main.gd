extends Node2D

var cuadros_move_right: int = 0
var eventos_move_right: int = 0

var ultima_clase: String = "Ninguno"
var ultimo_dispositivo: String = "Ninguno"
var ultimo_tipo: String = "Ninguno"

@onready var hud: Label = $Hud

func _ready() -> void:
	configurar_input_map()
	actualizar_hud()

func configurar_input_map() -> void:
	# Crea las acciones solicitadas si todavía no existen.
	crear_accion_teclado("jump", KEY_SPACE)
	crear_accion_teclado("move_left", KEY_A)
	crear_accion_teclado("move_right", KEY_D)

func crear_accion_teclado(nombre: String, tecla: Key) -> void:
	if not InputMap.has_action(nombre):
		InputMap.add_action(nombre)
	var evento := InputEventKey.new()
	evento.physical_keycode = tecla
	if not InputMap.action_has_event(nombre, evento):
		InputMap.action_add_event(nombre, evento)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		cuadros_move_right += 1
	actualizar_hud()

func _input(event: InputEvent) -> void:
	# Ignorar la repetición automática (eco) del teclado.
	if event is InputEventKey and event.echo:
		return

	# Contar cada evento de pulsación real de D, no los cuadros mantenidos.
	if event is InputEventKey and event.pressed and event.is_action_pressed("move_right"):
		eventos_move_right += 1

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			ultima_clase = "InputEventMouseButton (Rueda arriba)"
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			ultima_clase = "InputEventMouseButton (Rueda abajo)"
		else:
			ultima_clase = "InputEventMouseButton (Clic)"
		ultimo_dispositivo = "Ratón"
		ultimo_tipo = "Digital"

	elif event is InputEventMouseMotion:
		ultima_clase = "InputEventMouseMotion"
		ultimo_dispositivo = "Ratón"
		ultimo_tipo = "Posición"

	elif event is InputEventKey:
		ultima_clase = "InputEventKey"
		ultimo_dispositivo = "Teclado"
		ultimo_tipo = "Digital"

	elif event is InputEventJoypadMotion:
		ultima_clase = "InputEventJoypadMotion"
		ultimo_dispositivo = "Mando"
		ultimo_tipo = "Analógica"

	elif event is InputEventJoypadButton:
		ultima_clase = "InputEventJoypadButton"
		ultimo_dispositivo = "Mando"
		ultimo_tipo = "Digital"

	else:
		ultima_clase = event.get_class()
		ultimo_dispositivo = "Otro"
		ultimo_tipo = "No identificado"

	actualizar_hud()

func actualizar_hud() -> void:
	var jump: bool = Input.is_action_pressed("jump")
	var eje: float = Input.get_axis("move_left", "move_right")
	var fuerza: float = Input.get_action_strength("move_right")

	hud.text = "CENTRO DE CONTROL DE ENTRADAS\n"
	hud.text += "Dispositivo principal: TECLADO (señal DIGITAL)\n\n"
	hud.text += "ACCIONES EN TIEMPO REAL\n"
	hud.text += "jump: " + str(jump) + "\n"
	hud.text += "get_axis: " + ("%.2f" % eje) + "\n"
	hud.text += "get_action_strength(move_right): " + ("%.2f" % fuerza) + "\n\n"
	hud.text += "ÚLTIMO EVENTO\n"
	hud.text += "Clase: " + ultima_clase + "\n"
	hud.text += "Dispositivo: " + ultimo_dispositivo + "\n"
	hud.text += "Tipo de señal: " + ultimo_tipo + "\n\n"
	hud.text += "CONTADORES DE move_right\n"
	hud.text += "Cuadros con acción pulsada: " + str(cuadros_move_right) + "\n"
	hud.text += "Eventos recibidos: " + str(eventos_move_right)
