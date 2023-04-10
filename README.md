# **SoundGen**

Primer proyecto para la asignatura Creación multimedia.

## **Integrantes.**

* David Pérez Zapata.
* Luis Antonio Suárez Bula.

---

## **Idea.**

https://user-images.githubusercontent.com/83037028/230801716-35a464c1-8617-4666-bfe8-97b6d40dccfc.mp4

### **1. Looping songs.**

A David desde hace algunos años le ha gustado una forma de hacer música conocida como *"looping songs"*, que consiste en grabar cierto tiempo de un ritmo, para luego ponerlo a reproducir de fondo mientras se graba otro, luego repetir este proceso hasta tener una base con varios ritmos para tocar la melodía principal sobre esta.

Un ejemplo (el favorito de David) de looping song es [Viva la vida - David Garrett](https://www.youtube.com/watch?v=bZ_BoOlAXyk).

### **2. Visualizador.**

Luego de tener la idea para generar el audio, se pensó en que una forma interesante de representar cambios visuales causados por el audio era con un *audio visualizer*, es decir, que los cambios ocurran por las propiedades y características de los sonidos, en este caso, de los ritmos.

---

## **Inspiraciones.**

Teniendo en cuenta el concepto de *looping songs*, se usaron dos canciones para el desarrollo de este proyecto:

* [Sex on fire - Kings of Leon (loop cover by Chebotaev)](https://www.youtube.com/watch?v=VMo0QfviPKs).
* [Torment - Evan Call](https://www.youtube.com/watch?v=LwVdKlPW_Vg).

Luego, por el lado del visualizador, a Luis siempre le ha gustado la estética del juego de VR Beat Saber ([aquí un ejemplo](https://www.youtube.com/watch?v=b2lowBKApC0)), así que cuando estaba buscando formas de representar visualmente los cambios de sonidos, encontró [este video](https://www.youtube.com/watch?v=gHpxRv4MBBA), el cual tiene un estilo somilar al juego, por lo que se decidió por esta forma de visualización.

---

## **Funcionamiento.**

En el video mencionado anteriormente entregan un código de Processing ya hecho, y claramente la idea del proyecto no es solo copiarlo y pegarlo y listo, por lo que se realizó un acercamiento propio a dicha solución propuesta. Allí, utilizan la librería minim, la cual hace casi todo el trabajo de convertir el audio en información útil para la generación de las imágenes por medio de métodos y atributos que pueden extraerse de pistas de audio. Para esta solución no se incluyó el uso de dicha librería, además de usar el sonido extraído en tiempo real del programa PureData.

El acercamiento realizado consiste en tomar el valor numérico de las notas que componen cada cancion en PureData y enviarlas a procesing cada vez que alguna varíe, así en processing se tendrá información numérica muy básica sobre el sonido que se está reproduciendo actualmente. Partiendo de esa información, se aplican multiples transformaciones a través de funciones que nos permiten convertirla en información más compleja y suficiente para poder presentar un efecto visual llamativo en el visualizador de audio. 

La explicación detallada sobre como se realiza el proceso mencionado anteriormente puede verse de mejor manera en el codigo y los comentarios del archivo "Visualizer.pd". A continuación se explicara brevemente los aspectos más importantes sobre la manipulación de las notas recibidas de PureData. 

* Se obtienen en un arreglo los valores numéricos de las notas reproducidas. Si una nota está apagada o no está sonando se le asigna 0.
* Separamos las notas en distintos tipos: bajos, medios y altos.
* Se calcula un puntaje (variables "score") para cada tipo de sonido en base a las notas clasificadas en los respectivos tipos.
* Se calcula un puntaje global en base a los otros tres puntajes.
* Los puntajes anteriores pueden ser considerados como el "corazón" del visualizador, ya que se utilizan como parámetros para variar los colores, la trasparencia, rotación, grosor, velocidad, y forma en los diferentes elementos presentes (lineas, cubos y aristas).
* Debido a que las notas solo se envian por un breve periodo de tiempo el efecto visual creado demoraria unos pocos milisegundos, por lo que se utiliza una variable para controlar el tiempo y la intensidad del efecto y buscar asi simular el comportamiento de una nota musical real.

Vale la pena mencionar que el resultado obtenido no simula completamente el comportamiento visto en el video de inspiracion, ya que hace falta casi la totalidad de la información de las frecuencias y amplitudes de onda del archivo de sonido, información que se obtendría haciendo uso de la libreria minim. 




