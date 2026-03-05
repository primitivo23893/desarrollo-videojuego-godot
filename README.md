# Privacy Defender: El Escape de Meta



## Sinopsis
En un mundo digital donde tu información personal es el producto más valioso, tu **privacidad está bajo un ataque constante**. Eres un teléfono y tu misión es ¡mantener tus datos a salvo del gigante tecnológico **Meta**! Esquiva las incesantes oleadas de Facebook, WhatsApp, Instagram y Messenger que intentan atraparte para robar tu información. 

## Mecánicas de Juego
* **Supervivencia Continua:** Controla a tu celular y muévete hábilmente para esquivar las aplicaciones. El objetivo principal es durar la mayor cantidad de tiempo posible en pantalla sin morir.
* **Pelea por tu Privacidad:** En el mapa aparecerá un *power-up* con el logo de **Telegram**. Al recogerlo, tu celular se armará para la resistencia, permitiéndote disparar botes de basura a las aplicaciones de Meta para "desinstalarlas" y abrirte paso hacia una aplicación más segura, privada y con más funciones.

![Imagen de la frase](resistancedog.png)
> *"Aquellos que renunciarían a la libertad esencial para comprar un poco de seguridad temporal, no merecen ni la libertad ni la seguridad."*
> **— Benjamín Franklin**

## Características del Proyecto
* **Motor Gráfico:** Desarrollado en [Godot Engine](https://godotengine.org/).
* **Estado:** Prototipo jugable.
* **Contexto Académico:** Este juego fue diseñado y programado como parte de una tarea oficial para la clase de **Programación de Gráficos 3D**.

## Implementaciones Adicionales

* **Soporte multiplataforma y de controles:** Se puede jugar en **TODOS** los dispositivos. Cuenta con soporte para teclado, mandos y controles táctiles para dispositivos móviles (el sistema detecta el tipo de dispositivo de entrada y decide automáticamente si mostrar los botones táctiles o no).
* **Sistema de vidas:** El jugador (celular) cuenta con **3 vidas** visibles en la parte superior izquierda de la pantalla, las cuales se van restando al colisionar con las aplicaciones.
* **Feedback de daño e invulnerabilidad:** Al recibir daño, el jugador emite partículas y su *sprite* se vuelve ligeramente transparente. Además, para mejorar el *feedback* visual, se activa un efecto hecho con *Shaders* en los bordes de la pantalla, mostrando un difuminado radial de color rojo que dura exactamente el mismo tiempo que el estado de invulnerabilidad.
* **Power-ups temporales:** El jugador puede obtener *power-ups* con el logotipo de **Telegram** que aparecen en el mapa de forma aleatoria cada 15 a 30 segundos, los cuales desaparecen a los 10 segundos si no son recogidos (mostrando un incremento en la velocidad de su animación para avisar que se esfumarán). Recogerlos te otorga la habilidad de disparar botes de basura durante **4 segundos**. Durante este estado, aparece un reloj (temporizador) del tamaño de la pantalla para visualizar el tiempo restante, y simultáneamente, el *sprite* del teléfono y los efectos de sonido cambian.
* **Generación de enemigos (Mobs):** Las aplicaciones enemigas aparecen de forma aleatoria desde los bordes de la pantalla. Su aparición es controlada por un *timer* que, al instanciarlas, también determina el tipo de aplicación y el color correspondiente de su partícula.
* **Eliminación y modulación de audio:** Al recibir un proyectil, las aplicaciones desaparecen de inmediato emitiendo partículas y un efecto de sonido. Este sonido está modulado por código para generar pequeñas variaciones aleatorias en el *pitch* (tono) cada vez que se reproduce, evitando así que el juego suene monótono. *(Nota: En el modo de juego secreto, cada eliminación también incrementa un contador).*
* **Menú de pausa avanzado:** Incluye controles de audio divididos en General, Música y Efectos, otorgando al usuario el control total de los niveles de volumen. Esta interfaz es totalmente compatible con mandos. De igual manera, al pausar el juego se activa un *shader* que difumina el fondo para poder visualizar mucho mejor el menú.
* **Easter Egg:** Al ejecutar el clásico **Código Konami** (↑ ↑ ↓ ↓ ← → ← →​) en la pantalla de inicio, se habilitará un modo de juego secreto :3.

## Controles

### Teclado y Ratón
* **Movimiento:** Teclas `W` `A` `S` `D` / Flechas direccionales
* **Disparar:** `Clic Izquierdo` / `Espacio`
* **Iniciar Juego:** `Enter` / `Espacio`
* **Pausa:** `ESC`

### Mando (Gamepad)
* **Movimiento:** Joystick Izquierdo / D-pad
* **Disparar:** * *Xbox:* `RT` / `LT` / `RB` / `LB` / `A` / `B`
  * *PlayStation:* `R2` / `L2` / `R1` / `L1` / `X` / `O`
  * *Nintendo:* `ZR` / `ZL` / `R` / `L` / `B` / `A`
* **Iniciar Juego:**
  * *Xbox:* `A` / `B`
  * *PlayStation:* `X` / `O`
  * *Nintendo:* `B` / `A`
* **Pausa:**
  * *Xbox:* `Menú` (Start)
  * *PlayStation:* `Start`
  * *Nintendo:* `+`

### Pantalla Táctil (Móviles)
* **Movimiento:** Joystick Virtual Izquierdo
* **Disparar:** Botón Virtual Derecho
* **Pausa:** Botón Virtual (Arriba al centro)

---
**Código fuente:** [Repositorio en GitHub](https://github.com/primitivo23893/desarrollo-videojuego-godot)
