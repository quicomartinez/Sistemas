contadorGrupos=0
contadorUsuarios=0
mayorNumeroUsuarios=0

read -p "Introduce el fichero a tratar: " nombreFichero

while [ ! -f $nombreFichero ];do
    read -p "Fichero incorrecto. Introduce otro nombre: " nombreFichero
done

for i in $(cat $nombreFichero); do
    if [[ $i == *: ]]; then
	if [ $contadorGrupos -gt 0 ]; then
	    echo $nombreGrupo $contadorUsuarios >> temp.txt	
	fi
	contadorUsuarios=0
	contadorGrupos=`expr $contadorGrupos + 1`
	nombreGrupo=$i
    else
	contadorUsuarios=`expr $contadorUsuarios + 1`
    fi

done
echo $nombreGrupo $contadorUsuarios >> temp.txt

echo "En el fichero proporcionado tenemos $contadorGrupos grupos:"

while read -r line; do
    echo $line
    valor=`echo $line | awk '{print $2}'`
    if [ $valor -gt $mayorNumeroUsuarios ]; then
	mayorNumeroUsuarios=$valor
	grupoMayor=`echo $line | awk '{print $1}'`
	grupoMayor=`echo "${grupoMayor::-1}"`
    else if [ $valor -eq $mayorNumeroUsuarios ]; then
	nuevoGrupo=`echo $line | awk '{print $1}'`
	nuevoGrupo=`echo "${nuevoGrupo::-1}"`
	grupoMayor="${grupoMayor} $nuevoGrupo"
    fi
    fi
    done < temp.txt

echo "El/los grupo/s que tiene/n más usuarios es/son $grupoMayor"
rm temp.txt
