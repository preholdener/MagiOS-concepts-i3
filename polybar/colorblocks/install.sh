#!/bin/bash

# Verificar si el script se ejecuta como root
if [ "$EUID" -ne 0 ]; then
    echo "Por favor, ejecuta este script con permisos de administrador (root)."
    exit 1
fi


polybar_config_dir="$HOME/.config/polybar"

# Crear la carpeta (si no existe)
mkdir -p "$polybar_config_dir"

# Clonar el repositorio de GitHub
git clone https://github.com/elisaac/colorblocks

# Mover la carpeta al directorio recién creado
if mv -u ./colorblocks "$polybar_config_dir"; then
    echo "Carpeta movida correctamente a $polybar_config_dir"
else
    echo "Error al mover la carpeta a $polybar_config_dir"
    exit 1
fi

# Agregar línea al archivo de configuración de i3
echo "exec_always --no-startup-id $polybar_config_dir/launch.sh" >> "$HOME/.config/i3/config"

# Dar permisos adecuados
chmod -R ugo+rwX "$polybar_config_dir"

# Reiniciar i3
sleep 3
i3-msg restart
