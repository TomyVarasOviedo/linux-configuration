# Organizador de descargas
> Es un script que permite organizar los archivos que se descargan segun su extension para tener una mayor organizacion de los mismo
> A continuacion se explicara como automatizar el script en windows 10 para que se ejecute de manera automatica 
## Configuraciones
Primero antes de utilizarlo tienen que decir en que carpeta de su sistema lo van a utilizar. Para esto primero deben crear un archivo `.config.json` para configurar todas las clasificaciones especificas que necesiten
~~~JSON
{
  "ruta_raiz":"ruta de la carpeta ha organizar",
  "clasificacion":{
      "nombre de la carpeta":["Palabras claves para clasificar entre archivos"]
  }
}
~~~
Dentro de la clasificacion se pueden tener todas las carpetas que se necesiten, los archivos van a caer dentro de la carpeta si su nombre coincide en algun punto con las palabras claves que se anotaron dentro de la lista
