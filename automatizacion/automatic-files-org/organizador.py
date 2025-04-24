import os
import json
import re
# Configurar la ruta de la carpeta a organizar
configFile = open(".config.json")
config=json.load(configFile)

ruta=config["ruta_raiz"]
# Organizacion segmentada por el usuario
user_dirs=config["clasificacion"]

carpetas=["PDFs", "Instaladores", "Imagenes","Comprimidos", "Otros"]
def mover_archivo(archivo:str, carpeta:str):
    """
    @param archivo: Nombre del archivo ha mover
    @param carpeta: Nombre de la carpeta donde quedara
    """
    src_path = os.path.join(ruta, archivo)
    destino_path = os.path.join(ruta+f"/{carpeta}", archivo)
    os.rename(src_path, destino_path)

def clasificar_archivos(archivo:str):
    """
    @param archivo: Nombre del archivo a clasificar
    """
    extension = os.path.splitext(archivo)[1]
    match extension:
        case ".pdf":
            if not(os.path.isdir(f"{ruta}/PDFs")):
                # Si no existe direcctorio PDFs
                os.mkdir(f"{ruta}/PDFs")
            mover_archivo(archivo,"PDFs")
        case ".exe":
            if not(os.path.isdir(f"{ruta}/Instaladores")):
                # Si no existe direcctorio PDFs
                os.mkdir(f"{ruta}/Instaladores")
            mover_archivo(archivo, "Instaladores")
        case ".jpg"| ".jpeg" | ".png" | ".web" :
            if not(os.path.isdir(f"{ruta}/Imagenes")):
                # Si no existe direcctorio PDFs
                os.mkdir(f"{ruta}/Imagenes")
            mover_archivo(archivo, "Imagenes")
        case ".zip" | ".tar" | ".deb" | ".rar":
            if not(os.path.isdir(f"{ruta}/Comprimidos")):
                # Si no existe direcctorio PDFs
                os.mkdir(f"{ruta}/Comprimidos")
            mover_archivo(archivo, "Comprimidos")
        case _:
            if not(os.path.isdir(f"{ruta}/Otros")):
                # Si no existe direcctorio PDFs
                os.mkdir(f"{ruta}/Otros")
            mover_archivo(archivo,"Otros")

def clasificar_usuario(archivo:str)->bool:
    archivoNombre=os.path.splitext(archivo)[0]
    for carpeta in dict.keys(user_dirs):
        if os.path.isdir(ruta+f"/{carpeta}"):
            # Si la carpeta existe dentro del directorio
            if detectarNombreArchivo(archivoNombre, carpeta):
                #Si coincide unas de las palabras claves con el nombre del archivo
                mover_archivo(archivo, carpeta)
                return True
        else:
            os.mkdir(ruta+f"/{carpeta}")
            if detectarNombreArchivo(archivoNombre, carpeta):
                #Si coincide unas de las palabras claves con el nombre del archivo
                mover_archivo(archivo, carpeta)
                return True
    #Si no pertenece a ninguna carpeta del usuario pasa a la clasificacion normal
    return False

def detectarNombreArchivo(archivoNombre:str, carpeta:str)->bool:
    # Utiliza expresiones regulares para detectar la coincidencia de palabras en un archivo
    patron = r'\b(?:' + '|'.join(r''.join(f'{re.escape(char)}\\s*' for char in palabra) for palabra in user_dirs[carpeta]) + r')\b'
    coincidencias = re.findall(patron, archivoNombre, re.IGNORECASE)
    coincidencias = list(set(coincidencias))
    if len(coincidencias) != 0:
        return True
    else:
        return False

def main():
    archivos=os.listdir(ruta)
    print("Organizando archivos...")
    for archivo in archivos:
        if os.path.isfile(f"{ruta}/{archivo}"):
            # Si no corresponde a una carpeta -> clasifica el archivo
            if clasificar_usuario(archivo):
                #Si el archivo se encuentra en la clasificacion del usuario, no es necesario seguir clasificacandolo
                continue

            clasificar_archivos(archivo)

if __name__ == "__main__":
    main()