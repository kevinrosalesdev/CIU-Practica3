# Práctica 3 - Sistema Planetario

![version](https://img.shields.io/badge/version-1.0-green)

## Memoria

### Autor

Kevin David Rosales Santana - <kevin.rosales101@alu.ulpgc.es>

### Índice

1. [Introducción](#1-introducción)
2. [Muestra del resultado](#2-muestra-del-resultado)
3. [Descripción del trabajo realizado](#3-descripción-del-trabajo-realizado)

   3.1 [Estructura de ficheros](#31-estructura-de-ficheros)
   
   3.2 [Decisiones en el desarrollo](#32-decisiones-en-el-desarrollo)
   
      - 3.2.1 [Generación del sistema planetario](#321-generación-del-sistema-planetario)
      - 3.2.2 [Rotación de la estrella y los planetas](#322-rotación-de-la-estrella-y-los-planetas)
      - 3.2.3 [Rotación de las lunas](#323-rotación-de-las-lunas)
      - 3.2.4 [Movimiento con el ratón](#324-movimiento-con-el-ratón)
      - 3.2.5 [Nave](#325-nave)
      - 3.2.6 [Generación de nombres](#326-generación-de-nombres)
   
4. [Conclusión](#4-conclusión)
5. [Ejecución del Proyecto](#5-ejecución-del-proyecto)
6. [Referencias y herramientas utilizadas](#6-referencias-y-herramientas-utilizadas)

### 1. Introducción

En la presente práctica se pedía implementar un modelo de un **sistema planetario** en movimiento, sirviendo para el aprendizaje de *Processing*, el cual tiene como objetivo facilitar los desarrollos con fines creativos en entornos digitales. 

Dicho **sistema planetario** debía incluir una estrella, (al menos) cinco planetas y alguna luna, integrando primitivas 3D, texto e imágenes (como por ejemplo, una imagen de fondo).

Por tanto, en este repositorio se tiene una implementación que incluye:

- **Generación del sistema planetario** pedido. Tiene un total de:
  - 1 estrella.
  
  - 8 planetas (como el sistema solar).
  
  - 4 lunas.
  - Uno de los planetas contiene dos de ellas.
- **Rotaciones lógicas** para los elementos del sistema planetario.
- [APORTACIÓN PROPIA] **Texturas.**
  - Además, se incluye una imagen de fondo.
- [APORTACIÓN PROPIA] **Título e información de control** usando efecto de parpadeo.
- [APORTACIÓN PROPIA] Nombre de sistema planetario, de estrella y de los planetas **aleatorio**.
- [APORTACIÓN PROPIA] Carga de un modelo de **cohete espacial** apuntando a la estrella.
- [APORTACIÓN PROPIA] **Movimiento** del sistema planetario **con el ratón**.

### 2. Muestra del resultado

<div align="center">
   <img src="Practica3/media/animation.gif" alt="animation"></img>
   <p>Figura 1: Muestra del resultado</p>
</div>

**Nota importante:** los elementos que pertenecen al sistema planetario no realizan rotaciones tan rápidas como las que se pueden observar en la *Figura 1*. Esto se debe a la representación que proporciona el *.gif*.

### 3. Descripción del trabajo realizado

#### 3.1 Estructura de ficheros

Para realizar este trabajo, se han creado estos cuatro ficheros (presentes en la carpeta [Practica3](Practica3/)):

| Fichero          | Descripción                                                  |
| :--------------- | :----------------------------------------------------------- |
| *Practica3.pde*  | Fichero encargado de la **interfaz gráfica** del sistema planetario. Además, al ser el fichero principal, gestiona el `setup()` y el `draw()` del proyecto haciendo uso del resto de ficheros del este. |
| *Controller.pde* | Clase **controlador**. Se encarga de crear la estrella, los planetas, las lunas, la nave y de dibujar dichos elementos. También administra la lógica de rotaciones del sistema. |
| *MySphere.pde*   | Clase **modelo** que representa a un objeto *Esfera*. Dicho objeto contiene principalmente el *PShape* de la esfera (independientemente de ser la estrella, los planetas o la luna), entre otros. También contiene la lógica de generación de nombres aleatorios. |
| *MyShip.pde*     | Clase **modelo** que representa a un objeto *Nave Espacial*. Dicho objeto contiene el *PShape* utilizado para representar la nave espacial, entre otros. |

<div align="center">
   <p>Tabla 1: Estructura de ficheros</p>
</div>

#### 3.2 Decisiones en el desarrollo

A la hora de realizar el **sistema planetario** se ha tenido que tomar una serie de decisiones respecto al desarrollo del proyecto. A continuación, se listarán dichas decisiones:

##### 3.2.1 Generación del sistema planetario

Para la generación del sistema planetario, se crea en el `setup()` **la nave**, **la estrella** y una serie de **planetas** y **lunas**. Excepto la nave, el resto de elementos son modelados por la clase `MySphere`. Dicha clase requiere de un radio `radius` de la esfera, de [una imagen para la textura `texture `(ver referencias 6, 7 y 8)](#6-referencias-y-herramientas-utilizadas) (se ha utilizado un compresor de imágenes para mejorar el rendimiento), de un desplazamiento en X `translateX` y en Y `translateY` (respecto al centro) y de un incremental de rotación en Y `drotationY` (que definirá la velocidad con la que gira la esfera respecto a la estrella) y de rotación en Y respecto a su propio eje `drotation`.

Para aportar originalidad al proyecto, se ha propuesto un sistema planetario en el que **no todos los planetas siguen el mismo sentido en su trayectoria**, por lo que algunos de ellos van en el sentido contrario.

Respecto a las **lunas**, se han propuesto un total de cuatro (como se dijo previamente, dos de ellas pertenecen a un mismo planeta). Dichas lunas **rotan más rápido** que sus propios planetas y **siempre muestran la misma cara hacia estos**.

Además, mediante el método `setBackground()` de la clase *Controller*, se dibuja dentro del `draw()` **el fondo espacial** que se puede visualizar en la *Figura 1*. También se realiza un `translate` para situar el centro del modelo en el centro de la ventana. Por último, se comienzan a dibujar todos los elementos ya creados teniendo en cuenta el movimiento que deben recrear.

En las siguientes dos secciones se explicará qué rotaciones realiza cada elemento del sistema planetario.

##### 3.2.2 Rotación de la estrella y los planetas

La **estrella** (esfera situada en el centro) no tiene rotación alrededor del propio centro (`drotationY = 0`), pero sí tiene una rotación lenta sobre su propio eje (`drotation=0.1`).

**Los planetas sí tienen una rotación alrededor del centro del sistema planetario y una rotación sobre su propio eje.** Cada vez que se ejecuta el `draw()`, se actualiza la rotación de las esferas (método `updateSphereRotation(MySphere)` y además se dibujan (método `drawSphere(MySphere)`).

Para recrear dicho movimiento, se hace uso del siguiente código:

```java
  void drawSphere(MySphere sphere){
    pushMatrix();
    rotateY(radians(sphere.rotationY));
    translate(sphere.translateX, sphere.translateY, 0);

    rotateY(radians(sphere.rotation));
    shape(sphere.sphereShape);
    
    [...]
    
    popMatrix();
  }
```

<div align="center">
    <p> Fragmento de Código 1: Representación de las esferas en el modelo</p>
</div>

El funcionamiento de la representación de las esferas se basa en el uso de `pushMatrix()` y `popMatrix()` para controlar **los distintos niveles de rotaciones** que existen.

Así pues, el **algoritmo** sería el siguiente:

- Se realiza una **rotación respecto a la estrella central** dependiendo de `rotationY`,  que se incrementa mediante `drotationY`.
- Se realiza un **desplazamiento hacia la ubicación de la esfera** respecto a la estrella central.
- Se realiza una **rotación respecto a su propio eje**.
- Se **representa la esfera**.

Se debe destacar que la estrella central (como se mencionó antes) funciona como una esfera más sin desplazamiento ni rotación respecto al centro de la ventana (tan solo respecto a su propio eje):

```java
this.sun = new MySphere(75.0, loadImage("sun/2k_sun-compressor.jpg"), 0, 0, 0, 0.1);
```

<div align="center">
    <p> Fragmento de Código 2: Generación de la estrella central</p>
</div>

##### 3.2.3 Rotación de las lunas

**La rotación en las lunas** funciona de una manera similar a la del resto de esferas, con la excepción de que no poseen rotación sobre su propio eje, con lo que **siempre muestran la misma cara a su planeta** (como la luna terrestre).

La circunstancia que se debe destacar es que **para rotar la luna alrededor de un planeta**, se debe realizar antes un `rotateY` y un `translate` a las características de este. A continuación, se podrá dibujar la luna con las propiedades que se desee:

```java
  void drawMoon(MySphere planet, MySphere moon){
    pushMatrix();
    rotateY(radians(planet.rotationY));
    translate(planet.translateX, planet.translateY, 0);
    
    pushMatrix();
    rotateY(radians(moon.rotationY));
    translate(moon.translateX, moon.translateY, 0);
    shape(moon.sphereShape);
    popMatrix();
    
    popMatrix();
  }
```

<div align="center">
    <p> Fragmento de Código 3: Representación de las lunas en el modelo</p>
</div>

##### 3.2.4 Movimiento con el ratón

Para aprovechar la generación de un modelo tridimensional de un sistema planetario, se le ha otorgado al usuario la posibilidad de **visualizar dicho sistema moviendo el ratón**. Para ello, tras hacer el primer `translate` hacia el centro de la ventana en los `draw()`, se ejecuta el siguiente código:

```java
rotateX(radians((-mouseY*90/height)+45));
rotateY(radians((mouseX*90/width)-45));
```

<div align="center">
    <p> Fragmento de Código 4: Manejo del movimiento del ratón</p>
</div>

Con esto se logra (limitado a [-45º,45º] en ambos ejes) que **el usuario pueda ir cambiando la visión del espacio**. Como se verá más adelante, los nombres de los planetas deberán tener en cuenta la posición del ratón para que se puedan mostrar siempre al usuario.

##### 3.2.5 Nave

Para implementar una carga de un modelo ya realizado, se ha optado por realizar la clase *MyShip*. Dicha clase contiene un [modelo de un cohete espacial (ver referencia 5)](#6-referencias-y-herramientas-utilizadas) usando `loadShape(filename)`, una textura usando `loadImage(filename)` y un incremento de rotación en Z (`drotationZ`).

Para dibujar la nave (tras actualizar la rotación en Z con `updateShipRotation(MyShip)`, el cual le permite **dar vueltas sobre sí mismo en Z** como se puede observar en la *Figura 1*), se ejecuta el siguiente código:

```java
pushMatrix();
translate(-100,-250,300);
rotateX(radians(200));
rotateY(radians(30));
rotateZ(radians(ship.rotationZ));
scale(0.1);
shape(ship.model);
popMatrix();
```

<div align="center">
    <p> Fragmento de Código 5: Representación de la nave en el modelo</p>
</div>

Con el que se sitúa al cohete, se le otorga una rotación en los distintos ejes (en este caso, para que se encuentre dirigido hacia la estrella central), se escala y se genera.

##### 3.2.6 Generación de nombres

Para aportar aleatoriedad a la creación de sistemas planetarios, se ha realizado un **sistema generador de nombres aleatorios** para los planetas. Dicho sistema es reutilizado para dar nombre al sistema planetario también:

|                      Ejecución A                      |                      Ejecución B                      |
| :---------------------------------------------------: | :---------------------------------------------------: |
| ![model-execution-1](Practica3/media/animation-2.gif) | ![model-execution-2](Practica3/media/animation-3.gif) |

<div align="center">
   <p>Tabla 2: Ejemplos de nombres aleatorios</p>
</div>

Los nombres de los planetas son representados por pantalla (situado debajo de cada planeta) en el método `drawSphere(MySphere)`:

```java
pushMatrix();
rotateY(radians((-sphere.rotationY-sphere.rotation)-((mouseX*90/width)-45)));
textFont(font, sphere.sphereShape.getHeight()/2);
text(sphere.name, 0, 0.75*sphere.sphereShape.getHeight(), 25);
popMatrix();
```

<div align="center">
    <p> Fragmento de Código 6: Representación de los nombres de los planetas en el modelo</p>
</div>

Como se puede observar, a la hora de representar los nombres se tiene en cuenta la posición actual del ratón y la rotación del planeta sobre la estrella y sobre su propio eje. Con este sistema se logra **que el nombre del planeta siempre se muestre al usuario**, independientemente de las rotaciones generadas por el usuario o por los propios cuerpos del modelo.

Además, se tiene en cuenta **para el tamaño y la posición del texto las propiedades del planeta**.

Respecto al **nombre del sistema planetario**, se representa con **un efecto de parpadeo** en la parte superior de la ventana junto a **información del control para la visualización del sistema planetario** (sin dicho efecto).

### 4. Conclusión

Esta práctica ha vuelto a servir como aprendizaje para *Processing* y, además, se ha tratado de una práctica muy entretenida donde se ha tenido contacto con una herramienta que permite facilitar el tipo de desarrollos visuales similares al visto en este proyecto.

Además, realizar este tipo de trabajos da una idea lo importante que resulta entender el sistema de rotaciones, desplazamientos y escalado que se originan de este tipo de técnicas para desarrollar **modelos 3D**, como el sistema planetario.

Por último, se debe recalcar que gracias a esta tercera práctica de *Creando Interfaces de Usuario*, se ha podido continuar **estudiando el manejo del *PShape***, incluyendo su generación, desplazamiento, rotación y, en este caso, inserción de texturas o **la carga de objetos mediante archivos *obj.***

### 5. Ejecución del proyecto

Para ejecutar este proyecto, es necesario:

- Tener instalado [Processing (Referencia 3)](#6-referencias-y-herramientas-utilizadas)

Para ejecutar el proyecto, tan solo se debe abrir el fichero [Practica3.pde](Practica3/Practica3.pde) y darle al botón de ejecutar.

**Nota importante:** es posible que debido a la cantidad de texturas y rotaciones en un espacio tridimensional la carga inicial sea algo elevada (en torno a los 10 segundos en mi caso).

### 6. Referencias y herramientas utilizadas

- [1] Modesto Fernando Castrillón Santana, José Daniel Hernández Sosa. [Creando Interfaces de Usuario. Guion de Prácticas](https://cv-aep.ulpgc.es/cv/ulpgctp20/pluginfile.php/126724/mod_resource/content/25/CIU_Pr_cticas.pdf)
- [2] Processing Foundation. [Processing Reference.](https://processing.org/reference/)
- [3] Processing Foundation. [Processing Download.](https://processing.org/download/)
- [4] Extrapixel. [GifAnimation Processing Library.](https://github.com/extrapixel/gif-animation)
- [5] TurboSquid, Inc. [Free3D](https://free3d.com/)
- [6] Textures for Planets. [Textures for Planets](http://www.texturesforplanets.com/)
- [7] INOVE. [Solar System Scope](https://www.solarsystemscope.com/)
- [8] Stéphane Lyver. [Compressor](https://compressor.io/)
