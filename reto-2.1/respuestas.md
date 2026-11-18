# Respuestas del reto 2.1

## 1. Mantén D dos segundos y suéltala: ¿qué contador subió más y por qué?

Subió más el contador de cuadros con la acción pulsada. Esto ocurre porque mientras mantengo D, el juego comprueba la acción en muchos cuadros. El contador de eventos aumenta al recibir la pulsación de D, no en todos los cuadros.

## 2. Mantén A: ¿qué valor muestran get_axis y get_action_strength("move_right"), y por qué difieren?

`get_axis` muestra **-1.00** porque A corresponde a la dirección izquierda. `get_action_strength("move_right")` muestra **0.00** porque D no está presionada. Difieren porque `get_axis` calcula la dirección entre izquierda y derecha, mientras que `get_action_strength` consulta solamente la intensidad de la acción move_right.

## 3. Gira la rueda del ratón: ¿qué clase de evento aparece y por qué su rama va antes que la del clic?

Aparece `InputEventMouseButton`, identificado en el HUD como rueda arriba o rueda abajo. La comprobación de la rueda va antes que la del clic porque la rueda y los botones del ratón utilizan la misma clase de evento; primero se revisa el índice del botón para distinguirlos.
