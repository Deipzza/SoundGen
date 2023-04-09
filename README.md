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

El acercamiento realizado consiste en **---> AQUÍ <---**
