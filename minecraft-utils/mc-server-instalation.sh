#!/bin/bash

# Handle Errors Function
    handle_error() {
        clear
        echo -e "$1\n$2\n" >> debug-file.txt
        exit 1
    }
#

# Show Menu
    show_menu() {
        clear

        echo -e "\n   - CHOOSE SERVER TYPE -      \n"
        echo -e " 1. Vanilla\n 2. Paper (Plugins)\n 3. Forge (Mods)\n"
        echo "Select one of the above or quit typing (q)"
    }
#

# Installation functions
    vanilla() {

        clear

        echo -e "[YOU SELECTED VANILLA]\n\n"

        echo -e "[+] Dowloading server files...\n"

        if ! sudo wget https://piston-data.mojang.com/v1/objects/145ff0858209bcfc164859ba735d4199aafa1eea/server.jar; then
            handle_error "[DOWLOAD ERROR]" "Minecraft Server dowload failed"
        fi



        clear
        echo "Especify amount of RAM (GB) the server will use: (only number ej: 1 = 1GB of RAM)"
        read ram_amount

        if ! java -Xmx"$ram_amount"G -Xms"$ram_amount"G -jar server.jar nogui; then
            handle_error "[SERVER ERROR]" "Server cannot start"
        fi

        clear
        echo -e "   - IMPORTANT-    \n\nOpen eula.txt and accept it\n"
        echo -e "\n Use command:    sudo nano eula.txt\n(If you dont have nano, install one editor)\n"
    }

    paper() {

        clear

        echo -e "[YOU SELECTED PAPER]\n"


    }

    forge() {

        clear

        echo -e "[YOU SELECTED FORGE]\n"


    }
#


# Show banner
cat << "EOF"

███╗   ███╗ ██████╗    ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗     ██████╗ ███╗   ███╗     ██╗
████╗ ████║██╔════╝    ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗    ██╔══██╗████╗ ████║     ██║
██╔████╔██║██║         ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝    ██████╔╝██╔████╔██║     ██║
██║╚██╔╝██║██║         ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗    ██╔══██╗██║╚██╔╝██║██   ██║
██║ ╚═╝ ██║╚██████╗    ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║    ██║  ██║██║ ╚═╝ ██║╚█████╔╝
╚═╝     ╚═╝ ╚═════╝    ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝     ╚═╝ ╚════╝ 
[Minecraft Server Installing Script] | (Made by: RafiThA RMJ)

EOF

cat << "EOF"
This Script only works on Ubuntu based distributions (contains .deb files & apt)

Do you want to proceed? (y/n)

EOF

# Ask to run & make server directory
    read option

    if [ "$option" != "y" ]; then
        echo "EXITING SCRIPT..."
        clear
        exit 0
    fi

    # CREATE DEBUG FILE

    echo "[+] CREATING SERVER DIRECTORY..."

    # Crear directorio del servidor
    if ! sudo mkdir /home/minecraft-server; then
        handle_error "[ERROR ON CREATING SERVER DIRECTORY]" "No data"
    fi

    # Viaja hasta el directorio del srevidor
    if ! cd /home/minecraft-server; then
        handle_error "[ERROR ACCESSING SERVER DIRECOTORY]" "No data"
    fi

    clear
#

# 0. UPDATE PACKAGES
    echo "[+] Updating packages..."
    if ! sudo apt update && sudo apt updgrade; then
        handle_error "[UPDATE PACKAGES ERROR]" "Please check your connection and try again"
    fi
    clear

    echo "[+] Installing Google Drive for backups Conection..."
    if ! sudo apt install rclone; then
        handle_error "[GOOGLE DRIVE CONNECTION DOWLOAD FAILED]" "Please check your connection and try again"
    fi
#

# If user dont have java -> install
# else -> continue
    if ! java --version; then
        # 1. INSTALLING JAVA

            echo "[+] Installing Java ..."

            # Crear directorio temporal
            if ! sudo mkdir tmp; then
                handle_error "[ERROR ON CREATING TMP DIRECTORY]" "No data"
            fi

            # Cambiar al directorio temporal
            if ! cd tmp; then
                handle_error "[ERROR ACCESSING TMP DIRECTORY]" "No data"
            fi

            # Descargar el archivo usando wget y redirigir la salida y errores a la terminal
            URL="https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.deb"

            if ! sudo wget -q $URL; then
                handle_error "[DOWLOAD ERROR]" "Please check your connection and try again"
            fi

            # Instalar el paquete descargado
            if ! sudo dpkg -i jdk-22_linux-x64_bin.deb; then
                handle_error "[COMPRESSION ERROR]" "No data"
            fi

            # Volver al directorio anterior
            if ! cd ..; then
                handle_error "[ERROR ON RETURNING TO PREVIOUS DIRECTORY]" "No data"
            fi

            # Eliminar el directorio temporal
            if ! sudo rm -rf tmp; then
                handle_error "[ERROR ON DELETING DIRECTORY]" "No data"
            fi

            clear

            if ! java --version; then
                handle_error "[ERROR CHECKING JAVA VERSION]" "Please check all the dependencies needed"
            fi

            echo -e "\nCheck that the Java Version is the latest one\n\nPlease type (y) to proceed\n\n(Note: to run the latest version of minecraft at least you will need Java 21)"

            read continue

            if [ "$continue" != "y" ]; then
                echo "EXITING SCRIPT..."
                clear
                exit 0
            fi
        #
    fi
# end

# 2. INSTALLING MINECRAFT SERVER

    # Show menu & install user choice
        while true; do
            show_menu
            read choice
            case $choice in
                1)
                    vanilla
                    exit 0
                    ;;
                2)
                    paper
                    exit 0
                    ;;
                3)
                    forge
                    exit 0
                    ;;
                q)
                    clear
                    echo "[FINISING...]"
                    exit 0
                    ;;
                *)
                    clear
                    echo -e "Invalid option\nPlease choose one of the above or exit (q)"
                    sleep 3
                    ;;
            esac
        done
    #
#

# Mostrar mensaje de finalización
echo "FINISHED"
exit 0
