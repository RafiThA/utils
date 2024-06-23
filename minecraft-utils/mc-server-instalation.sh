#!/bin/bash

debug_path=false
path="$(pwd)"

# Handle Errors Function
    handle_error() {
        clear
        cd $path
        FECHA_HORA=$(date '+%Y-%m-%d %H:%M:%S')
        echo -e "<${FECHA_HORA}> Problem:$1 | Info: $2" >> debug-file.txt
        echo -e "[PROGRAM FAILED]\nCheck debug-file.txt to see what happened current error\nError: $1"
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
# VANILLA
    vanilla() {

        # REINSTALL DIRECTORY
        if ! cd vanilla-server; then

            if ! mkdir vanilla-server; then
                handle_error "[ERROR CREATING VANILLA SERVER DIRECTORY]" "No data"
            fi

            if ! cd vanilla-server; then
                handle_error "[ERROR ACCESSING DIRECTORY]" "No data"
            fi
        fi

        # DELETE
        if ! sudo rm -rf *; then
            handle_error "[ERROR ON DELETE]" "All info of the vanilla server cannot be rebooted"
        fi

        clear

        # Debug Path
            if [ ${debug_path} == "true" ]; then
                echo -e "\n[DEBUG-PATH]: Current path: $(pwd)"
                echo "Press [ENTER] to continue..."
                read continue
            fi
        #

        echo -e "[YOU SELECTED VANILLA]\n\n"

        echo -e "[+] Dowloading server files...\n"

        if ! wget https://piston-data.mojang.com/v1/objects/450698d1863ab5180c25d7c804ef0fe6369dd1ba/server.jar; then
            handle_error "[DOWLOAD ERROR]" "Minecraft Server dowload failed"
        fi

        clear

        echo "Especify amount of RAM (GB) the server will use: (only number ej:  1   => 1GB of RAM)"
        read ram_amount

        if ! java -Xmx"$ram_amount"G -Xms"$ram_amount"G -jar server.jar nogui; then
            handle_error "[SERVER CREATION ERROR]" "Server cannot be created"
        fi

        echo "[IMPORTANT]: Goto server directory and accept the EULA.txt (use nano editor)"
    }

# PAPER

    paper() {

        clear

        echo -e "[YOU SELECTED PAPER]\n"


    }

# FORGE

    forge() {

        # REINSTALL DIRECTORY
        if ! cd forge-server; then

            if ! mkdir forge-server; then
                handle_error "[ERROR CREATING FORGE SERVER DIRECTORY]" "No data"
            fi

            if ! cd forge-server; then
                handle_error "[ERROR ACCESSING DIRECTORY]" "No data"
            fi
        fi

        # DELETE
        if ! sudo rm -rf *; then
            handle_error "[ERROR ON DELETE]" "All info of the forge server cannot be rebooted"
        fi

        clear

        # Debug Path
            if [ ${debug_path} == "true" ]; then
                echo -e "\n[DEBUG-PATH]: Current path: $(pwd)"
                echo "Press [ENTER] to continue..."
                read continue
            fi
        #

        clear

        echo -e "[YOU SELECTED FORGE]\n"

        echo -e "\n\n[WARNING]: Servers will be created in $(pwd) directory & current FORGE version if 1.19.4"
        echo "This program cannot install another version of forge, if you want to change this goto script code and edit in FORGE the variable \"URL-FORGE\" to change version"
        echo  "> type: (n) to exit or any key to continue."
        read option

        if [ "$option" == "n" ]; then
            echo "THE SERVER WAS NO INSTALED (exit 0)"
            exit 0
        fi

        echo -e "[+] Dowloading server files...\n"
        echo -e

        FORGE="https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.4-45.3.0/forge-1.19.4-45.3.0-installer.jar"

        if ! wget $FORGE; then
            handle_error "[DOWLOAD FORGE ERROR]" "Minecraft Server dowload failed"
        fi

        clear

        echo "Especify amount of RAM (GB) the server will use: (only number ej:  1   => 1GB of RAM)"
        echo "[RECOMENDATION]: If you are using a mod pack use +4GB of RAM"
        read ram_amount

        if ! java -Xmx"$ram_amount"G -Xms"$ram_amount"G -jar forge-1.19.4-45.3.0-installer.jar nogui; then
            handle_error "[SERVER CREATION ERROR]" "Server cannot be created"
        fi

        echo "[IMPORTANT]: Goto server directory and accept the EULA.txt (use nano editor)"

    }
#


# Show banner
    clear

    # Debug Paths

        if [ "$1" == "-dp" ]; then
            echo "[DEBUG PATH ENABLED]"
            echo "Absolute: $path"
            debug_path=true
        fi
    #


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
This script only works on Ubuntu based distributions (contains .deb files & apt)

Do you want to proceed? (y/n)

EOF

# Ask to run & make server directory
    read option

    clear

    if [ "$option" != "y" ]; then
        clear
        echo "EXITED SUCCESSFULY!"
        exit 0
    fi

    echo "[+] CREATING SERVER DIRECTORY..."

    # Goto server directory
    if ! cd ../; then
        handle_error "[ERROR ACCESSING SERVER DIRECTORY]" "No data"
    fi

    # Goto server directory 2
    if ! cd minecraft-servers; then
        
        if ! mkdir minecraft-servers; then
            handle_error "[ERROR CREATING DIRECTORY]" "Error creating minecraft-servers direcotory"
        fi

        # Enlable permision
        if ! sudo chmod 733 minecraft-servers/; then
            handle_error "[PERMISIONS ERROR]" "733 chmod cannot be stabliched on /minecraft-servers directory"
        fi

        if ! cd minecraft-servers; then
            handle_error "[ERROR ACCESING DIRECTORY]" "No data"
        fi
    fi

    # Debug Path
        if [ ${debug_path} == "true" ]; then
            echo -e "\n[DEBUG-PATH]: Current path: $(pwd)"
            echo "Press [ENTER] to continue..."
            read continue
        fi
    #

    echo "[INFO]: Servers will be created in $(pwd) directory"
    echo  "> type: (n) to exit or any key to continue."
    read option

    if [ "$option" == "n" ]; then
        echo "TO BE EDITED exit 0"
        exit 0
    fi

    clear
#

# 0. UPDATE PACKAGES
    echo "[+] Updating packages..."
    if ! sudo apt update && apt updgrade; then
        handle_error "[UPDATE PACKAGES ERROR]" "Please check your connection and try again"
    fi
    clear

    echo "[+] Installing Google Drive for backups Conection..."
    if ! sudo apt install rclone; then
        handle_error "[GOOGLE DRIVE CONNECTION DOWLOAD FAILED]" "Please check your connection and try again"
    fi

    echo "[+] Installing Screen for console..."
    if ! sudo apt install screen; then
        handle_error "[SCREEN DOWLOAD FAILED]" "Please check your connection and try again"
    fi
#

# If user dont have java -> install
# else -> continue
    if ! java --version; then
        # 1. INSTALLING JAVA

            echo "[+] Installing Java ..."

            # Crear directorio temporal
            if ! mkdir tmp; then
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
            if ! rm -rf tmp; then
                handle_error "[ERROR ON DELETING DIRECTORY]" "No data"
            fi

            clear

            # If java --version dont exist throw error
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
                    echo "  - No server was installed"
                    echo "ENDED OK"
                    exit 0
                    ;;
                *)
                    clear
                    echo -e "   INVALID OPTION\n > Please choose one of the above or exit (q) <"
                    sleep 3
                    ;;
            esac
        done
    #
#

# Mostrar mensaje de finalización
echo "ENDED OK"
exit 0
