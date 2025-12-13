# Variables
GPG_KEY="Exemple_09F77EA205E69CE8"
SOURCE_DIR="/home/mo"
DESTINATION="s3://Exemple_linuxsessionsave/test/"

# Exécuter la sauvegarde avec Duplicity
duplicity backup --encrypt-key $GPG_KEY $SOURCE_DIR $DESTINATION

# Vérifier si la commande a réussi
if [ $? -eq 0 ]; then
    echo "La sauvegarde a été effectuée avec succès."
else
    echo "Erreur lors de la sauvegarde."
fi
