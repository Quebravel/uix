#!/bin/bash

# Removendo copias de configurações
if ! rm -rf ~/mylinux-conf
    then
        echo 'ERRO pasta mylinux-conf não removida'
fi

if ! rm -rf ~/oh-my-fish
    then
        echo 'ERRO pasta oh-my-fish não removida'
fi

if ! rm -rf ~/dotfiles-tilingwm
    then
        echo "Sem pastas de configurações. OK!"
fi

if ! rm -rf ~/fonts
    then
        echo "Sem pastas de configurações. OK!"
fi

if ! rm -rf ~/tecladoVideoConfig
    then
        echo 'Não tem a pasta tecladoVideoConfig, tudo bem'
fi


Menu(){
clear
echo '	               -/oyddmdhs+:. '
echo '	           -odNMMMMMMMMNNmhy+-` '
echo '	         -yNMMMMMMMMMMMNNNmmdhy+- '
echo '	       `omMMMMMMMMMMMMNmdmmmmddhhy/`   '
echo '	       omMMMMMMMMMMMNhhyyyohmdddhhhdo`  '
echo '	      .ydMMMMMMMMMMdhs++so/smdddhhhhdm+`  '
echo '	       oyhdmNMMMMMMMNdyooydmddddhhhhyhNd. '
echo '	        :oyhhdNNMMMMMMMNNNmmdddhhhhhyymMh  '
echo '	          .:+sydNMMMMMNNNmmmdddhhhhhhmMmy  '
echo '	             /mMMMMMMNNNmmmdddhhhhhmMNhs:  '
echo '	          `oNMMMMMMMNNNmmmddddhhdmMNhs+`  '
echo '	        `sNMMMMMMMMNNNmmmdddddmNMmhs/.  '
echo '	       /NMMMMMMMMNNNNmmmdddmNMNdso:`  '
echo '	      +MMMMMMMNNNNNmmmmdmNMNdso/-  '
echo '	      MNNNNNNNmmmmmNNMmhs+/-` '
echo '	      /hMMNNNNNNNNMNdhs++/-` '
echo '	      `/ohdmmddhys+++/:.` '
echo '	        `-//////:--. '
   echo

	echo -e "\033[1;34m |||||              Pós instalação basica                ||||| \033[0m"
	echo
	echo -e "\033[1;31;40m[ 1 ]\033[0m Instalar X/Xmonad/Awesome"
	echo -e "\033[1;35;40m[ 2 ]\033[0m Instalar Programas Basicos (Executar com o X iniciado)"
	echo -e "\033[1;33;40m[ 3 ]\033[0m Personalizar Vim/Terminal"
	echo -e "\033[1;32;40m[ 4 ]\033[0m Configurar Teclado/Touchpad"
	echo -e "\033[1;34;40m[ 5 ]\033[0m Configurar Drive Video/Áudio"
	echo -e "\033[1;36;40m[ x ]\033[0m Sair"
	echo
	echo -n "Qual a opção desejada? "
	read opcao
	case $opcao in
		1) MenuX ;;
		2) Programas ;;
		3) Vim ;;
		4) Teclado ;;
		5) Video ;;
		x) exit ;;
		*) "Opção desconhecida." ; echo ; Menu ;;
	esac

}

MenuX(){

	echo ""
	echo -e "\033[1;34m |||||         Instalação da interface gráfica          ||||| \033[0m"
	echo
	echo -e "\033[1;31;40m[ 1 ]\033[0m X (Add a flag da sua GPU USE=vesa/intel+/radeon/nvidia)"
	echo -e "\033[1;31;40m[ 2 ]\033[0m Xmonad WM"
	echo -e "\033[1;31;40m[ 3 ]\033[0m Awesome WM"
	echo -e "\033[1;31;40m[ b ]\033[0m Voltar"
	echo
	echo -n "Qual a opção desejada? "
	read opcao
	case $opcao in
		1) X ;;
		2) Xmonad ;;
		3) Awesome ;;
		b) Menu ;;
		x) exit ;;
		*) "Opção desconhecida." ; echo ; MenuX ;;
	esac

}

X(){

echo 'Instalando X'
if ! sudo emerge -qn x11-base/{xorg-server,xorg-drivers}
    then
        echo 'ERRO'
        exit 1
fi
echo "X instalado!"
MenuX
}

Xmonad(){
echo ""
echo '                         \\\      / / '
echo '                          \\\    / / '
echo '                           \\\  / / '
echo '                            \\\/ / '
echo '                             \\\/ '
echo '                             //\\ '
echo '                            ///\\\ '
echo '                           ///  \\\ '
echo '                          ///    \\\ '
echo '                         ///      \\\ '
echo '                        \\\ \\\  ______'
echo '                         \\\ \\\|______|'
echo '                         /// ///|______|'
echo '                        /// ///'

echo ""
echo "     _|      _|  _|      _|                                      _|"
echo "       _|  _|    _|_|  _|_|    _|_|    _|_|_|      _|_|_|    _|_|_|"
echo "         _|      _|  _|  _|  _|    _|  _|    _|  _|    _|  _|    _|"
echo "       _|  _|    _|      _|  _|    _|  _|    _|  _|    _|  _|    _|"
echo "     _|      _|  _|      _|    _|_|    _|    _|    _|_|_|    _|_|_|"
echo ""

# GENTOOLKIT
if ! sudo emerge -qn app-portage/gentoolkit
    then
        echo 'ERRO não foi possível instalar gentoolkit'
        exit 1
fi
echo "Gentoolkit instalado!"

# ------------------ Flags para Xmonad -------------------------

# ABILITANDO FLAGS XMONAD
    if ! sudo euse -E alsa dbus wifi xft timezone gles haskell ncurses bzip2
        then
            echo 'ERRO não foi possível configurar as flags ou já configuradas'
    fi
echo "FLAGS PARA XMONAD CONFIGURADAS!"

# sincronizando gentoo
if ! sudo emerge --sync
    then
        echo 'ERRO não consegui sincronizar'
        exit 1
fi
echo "Repositório gentoo sincronizado!"

# atualizando gentoo
if ! sudo emerge --update --deep --with-bdeps=y --newuse --quiet @world
    then
        echo 'ERRO não consegui atualizar'
        exit 1
fi
echo "Repositório gentoo atualizado!"
sleep 2
# Se existir a pasta myXmonad-config
if ! rm -rf ~/dotfiles-tilingwm
    then
        echo "Sem pastas de configurações. OK!"
    else
        echo "Pasta antiga myXmonad-config removida! OK!"
fi

# 1
echo 'Git Clone do Xmonad'
if ! git clone https://github.com/Quebravel/dotfiles-tilingwm.git ~/dotfiles-tilingwm
    then
        echo 'Não Clonou'
        exit 1
fi
echo "Arquivos de configuração de Xmonad clonados!"

# 2
echo 'Copiando os arquivos'
if ! cp -rf ~/dotfiles-tilingwm/.xmonad ~/
    then
        echo 'Arquivos não movidos'
        exit 1
fi
echo 'Arquivos movidos com sucesso!'

# 2.1
echo 'Copiando os arquivos'
if ! cp -rf ~/dotfiles-tilingwm/.xmonad ~/
    then
        echo 'Arquivos não movidos'
        exit 1
fi
echo 'Arquivos movidos com sucesso!'


# 2.1.1
echo 'Copiando os arquivos'
if ! cp -rf ~/dotfiles-tilingwm/.stalonetrayrc ~/
    then
        echo 'Arquivos não movidos'
        exit 1
fi
echo 'Arquivos movidos com sucesso!'
# 2.2
echo 'Copiando os arquivos'
if ! cp -rf ~/dotfiles-tilingwm/.xinitrc ~/
    then
        echo 'Arquivos não movidos'
        exit 1
fi
echo 'Arquivos movidos com sucesso!'

# 3
if ! cd ..
    then
        echo 'Não foi possível voltar'
        exit 1
fi
echo 'ok'
sleep 2

# CONFIGURANDO O WIFI NO ARQUIVO XMOBAR.HS
dev="$(ls /sys/class/net)"
echo "$dev" > ~/net
tex="$(grep -i -w -o 'wl[a-zA-Z0-9_ ]*' ~/net)"

if ! sed -i "s/DEVICE/$tex/g" ~/.xmonad/xmobar.hs
then
    echo "Wifi no xmobar não configurado"
fi
rm ~/net
sleep 1

if ! sed -i "s/%wi% //g" ~/.xmonad/xmobar.hs
then
    echo "Wifi no xmobar não configurado"
fi
echo "Não tem dispositivo wifi na maquina, sinal wifi não será configurado"
sleep 1

# 4
echo 'Removendo Pastas desnecessárias'
if ! rm -rf ~/dotfiles-tilingwm
    then
        echo 'Não foi possível remover as pastas'
        exit 1
fi
echo 'Pastas/Arquivos desnecessárias/os removidas!'

# 5 XMONAD
echo 'INSTALANDO XMONAD'
if ! sudo emerge -qn x11-wm/{xmonad,xmonad-contrib} x11-misc/{xmobar,stalonetray,lightdm} x11-terms/rxvt-unicode
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;32mXmonad instalado!\033[0m'

# Adicionando shutdown para uso sem sudo
if ! sudo chmod 4755 /sbin/shutdown
    then
        echo 'ERRO não consegui adicionar privilegios de uso para o comando shutdown ou já configurado antes'
fi
echo -e '\033[01;34mComando shutdown com privilegios adicionado!\033[0m'

# Criando atalho para o comando shutdown
if ! sudo ln -s /sbin/shutdown /bin/
    then
        echo 'ERRO não consegui criar o atalho para o comando shutdown ou já confirurado antes'
fi
echo -e '\033[01;34mAtalho para o comando shutdown adicionado!\033[0m'
sleep 1

sudo sed -i 's/[a-zA-Z0-9_ #]*autologin-session=[a-zA-Z0-9_ ]*/#autologin-session=/g' /etc/lightdm/lightdm.conf
sleep 2
sudo sed -i "s/[a-zA-Z0-9_ #]*autologin-user=[a-zA-Z0-9_ #]*/#autologin-user=/g" /etc/lightdm/lightdm.conf
sleep 2
sudo sed -i 's/[a-zA-Z0-9_ #]*user-session=[a-zA-Z0-9_ #]*/#user-session=default/g' /etc/lightdm/lightdm.conf
sleep 2

# Adicionando lightdm como gerenciador de login padrão
if ! sudo sed -i 's/DISPLAYMANAGER="xdm"/DISPLAYMANAGER="lightdm"/g' /etc/conf.d/xdm
    then
        echo 'ERRO não consegui adicionar lightdm como gerenciador de login padrão'
        exit 1
fi
echo "Gerenciador lightdm adicionado como padrão"
sleep 1
# Adicionado login sessão
if ! sudo sed -i 's/#autologin-session=/autologin-session=xmonad/g' /etc/lightdm/lightdm.conf
    then
        echo 'ERRO não consegui adicionar o autologin-session'
        exit 1
fi
echo -e '\033[01;34mAutologin-session adicionado!\033[0m'
sleep 1
# Adicionando usuŕio ao lightdm
if ! sudo sed -i "s/#autologin-user=/autologin-user=${USER}/g" /etc/lightdm/lightdm.conf
    then
        echo 'ERRO não consegui adicionar o usuário'
        exit 1
fi
echo -e '\033[01;34mUsuário adicionado ao lightdm!\033[0m'
sleep 1
# Adicionando user sessão
if ! sudo sed -i 's/#user-session=default/user-session=xmonad/g' /etc/lightdm/lightdm.conf
    then
        echo 'ERRO não consegui adicionar a sessão xmonad'
        exit 1
fi
echo -e '\033[01;34mUser sessão adicionada!\033[0m'
sleep 1
# Adicionando autologin ao grupo de usuŕios
if ! sudo groupadd -r autologin
    then
        echo 'ERRO não consegui adicionar autologin ao grupo de usuários ou já existe'
fi
echo -e '\033[01;34mautologin adiciondo ao grupo de usuários!\033[0m'
sleep 1
# Adicionando usuário ao grupo
if ! sudo gpasswd -a ${USER} autologin
    then
        echo 'ERRO não consegui adicionar o usuário ao grupo'
        exit 1
fi
echo -e '\033[01;34mUsuário adicionado ao grupo!\033[0m'
sleep 1
# Adicionando xdm para iniciar automaticamente
if ! sudo rc-update add xdm default
    then
        echo 'ERRO não consegui adicionar o xdm ao rc'
fi
echo -e '\033[01;34mxdm adicionado ao rc!\033[0m'
sleep 1
# 9 COMPILANDO
if ! xmonad --recompile
    then
        echo 'Não foi possível recompilar o xmonad'
        exit 1
fi
echo 'Xmonad compilado!'
sleep 1
# 10 REINICIANDO
if ! xmonad --restart
    then
        echo 'Não foi possível reiniciar o Xmonad'
        exit 1
fi
echo "Xmonad reiniciado!"

MenuX
}

Awesome(){

# ------------------ Flags para Awesome ------------------------
echo ""
echo "   __________    ___ ___ ___    __________    __________    ___________    ___________    __________ "
echo "  |          |  |   |   |   |  |          |  |          |  |           |  |           |  |          |"
echo "  |______    |  |   |   |   |  |    ______|  |   _______|  |           |  |           |  |   _______|"
echo "  |          |  |   |   |   |  |          |  |          |  |     |     |  |   |   |   |  |          |"
echo "  |   ___    |  |   |   |   |  |    ______|  |_______   |  |     |     |  |   |   |   |  |   _______|"
echo "  |      |   |  |           |  |          |  |          |  |           |  |   |   |   |  |          |"
echo "  |______|___|  |___________|  |__________|  |__________|  |___________|  |___|___|___|  |__________|"
echo ""

# GENTOOLKIT 
if ! sudo emerge -qn app-portage/gentoolkit
    then
        echo 'ERRO não foi possível instalar gentoolkit'
        exit 1
fi
echo "Gentoolkit instalado!"

# ABILITANDO FLAGS AWESOME WM
if ! sudo euse -E dbus luajit
    then
        echo 'ERRO não foi possível configurar as flags ou já configuradas'
fi
echo "FLAGS PARA AWESOME WM CONFIGURADAS!"

# sincronizando gentoo
if ! sudo emerge --sync
    then
        echo 'ERRO não consegui sincronizar'
        exit 1
fi
echo "Repositório gentoo sincronizado!"

# atualizando gentoo
if ! sudo emerge --update --deep --with-bdeps=y --newuse @world
    then
        echo 'ERRO não consegui atualizar'
        exit 1
fi
echo "Repositório gentoo atualizado!"

# Awesome
echo "Instalando Awesome"
if ! sudo emerge -qn x11-wm/awesome x11-misc/lightdm
    then
        echo 'ERRO não foi possível instalar Awesome windows manager'
        exit 1
fi
echo -e '\033[01;34mAwesome instalado!\033[0m'

# Configurando Awesome
echo "Criando pasta de configuração"
if ! mkdir -p ~/.config/awesome/
    then
        echo 'ERRO não foi possível criar a pasta awesome em .config, ela já existe, tudo bem!'
fi
echo -e '\033[01;34mPasta de configuração criada!\033[0m'

# Configurando Awesome
echo "Copiando configuração padrão"
if ! sudo cp -rfv /etc/xdg/awesome/rc.lua ~/.config/awesome/
    then
        echo 'ERRO não foi possível copiar a configuração do awesome'
        exit 1
fi
echo -e '\033[01;34mConfiguração copiada!\033[0m'
sleep 2
# Configurando Awesome
echo "Clonado tema copycats"
if ! git clone --recursive https://github.com/lcpz/awesome-copycats.git
    then
        echo 'ERRO não foi possível clonar os temas para awesome'
        exit 1
fi
echo -e '\033[01;34mClonado!\033[0m'

# Configurando Awesome
echo "Movendo tema"
if ! sudo cp -rf awesome-copycats/* ~/.config/awesome/
    then
        echo 'ERRO não foi possível mover os temas para as suas pastas'
        exit 1
fi
echo -e '\033[01;34mCopycats copiados!\033[0m'
sleep 2
# Configurando Awesome
echo "Removendo Clone"
if ! rm -rf awesome-copycats/
    then
        echo 'ERRO não consegui remover a pasta awesome-copycats, remova manualmente'
        exit 1
fi
echo -e '\033[01;34mCopycats removido!\033[0m'

# Configurando Awesome
echo "Copiando temas padão"
if ! sudo cp -rf /usr/share/awesome/themes/* ~/.config/awesome/themes
    then
        echo 'ERRO não foi possível copiar as pastas themes com os temas padrão do awesome'
        exit 1
fi
echo -e '\033[01;34mTemas padrões copiados!\033[0m'
sleep 3

sudo sed -i 's/[a-zA-Z0-9_ #]*autologin-session=[a-zA-Z0-9_ ]*/#autologin-session=/g' /etc/lightdm/lightdm.conf
sleep 2
sudo sed -i "s/[a-zA-Z0-9_ #]*autologin-user=[a-zA-Z0-9_ #]*/#autologin-user=/g" /etc/lightdm/lightdm.conf
sleep 2
sudo sed -i 's/[a-zA-Z0-9_ #]*user-session=[a-zA-Z0-9_ #]*/#user-session=default/g' /etc/lightdm/lightdm.conf
sleep 2

#echo "|||||||||||| INSTALAR LIGHTDM COM LOGIN AUTOMATICO  (AWESOME WM)||||||||||||"
#echo "Digite o nome do usuário"
#read nome

#echo "$nome"

# Adicionando lightdm como gerenciador de login padrão
if ! sudo sed -i 's/DISPLAYMANAGER="xdm"/DISPLAYMANAGER="lightdm"/g' /etc/conf.d/xdm
    then
        echo 'ERRO não consegui adicionar lightdm como gerenciador de login padrão'
        exit 1
fi
echo "Gerenciador lightdm adicionado como padrão"

# Adicionado login seif ! sudo sed -i 's/#autologin-session=/autologin-session=xmonad/g' /etc/lightdm/lightdm.conf
if ! sudo sed -i 's/#autologin-session=/autologin-session=awesome/g' /etc/lightdm/lightdm.conf
    then
        echo 'ERRO não consegui adicionar o autologin-session'
        exit 1
fi
echo -e '\033[01;34mAutologin-session adicionado!\033[0m'

# Adicionando usuŕio ao lightdm
if ! sudo sed -i "s/#autologin-user=/autologin-user=${USER}/g" /etc/lightdm/lightdm.conf
    then
        echo 'ERRO não consegui adicionar o usuário'
        exit 1
fi
echo -e '\033[01;34mUsuário adicionado ao lightdm!\033[0m'

# Adicionando user sessão
if ! sudo sed -i 's/#user-session=default/user-session=awesome/g' /etc/lightdm/lightdm.conf
    then
        echo 'ERRO não consegui adicionar a sessão xmonad'
        exit 1
fi
echo -e '\033[01;34mUser sessão adicionada!\033[0m'

# Adicionando autologin ao grupo de usuŕios
if ! sudo groupadd -r autologin
    then
        echo 'ERRO não consegui adicionar autologin ao grupo de usuários'
fi
echo -e '\033[01;34mautologin adiciondo ao grupo de usuários!\033[0m'

# Adicionando usuário ao grupo
if ! sudo gpasswd -a ${USER} autologin
    then
        echo 'ERRO não consegui adicionar o usuário ao grupo'
        exit 1
fi
echo -e '\033[01;34mUsuário adicionado ao grupo!\033[0m'

# Adicionando xdm para iniciar automaticamente
if ! sudo rc-update add xdm default
    then
        echo 'ERRO não consegui adicionar o xdm ao rc'
fi
echo -e '\033[01;34mxdm adicionado ao rc!\033[0m'

MenuX
}

#-------------------------------------------- PROGRAMAS PACKAGES / CONFIGURAÇÃO RANGER --------------------------------------------

Programas(){

	echo
	echo -e "\033[1;34m |||||             Instalação de programas              |||||\033[0m"
	echo
	echo -e "\033[1;35;40m[ 1 ]\033[0m Programas enssenciais"
	echo -e "\033[1;35;40m[ 2 ]\033[0m Netbeans (Baixe o jdk do site para /usr/portage/distfiles)"
	echo -e "\033[1;35;40m[ b ]\033[0m Voltar"
	echo
	echo -n "Qual a opção desejada? "
	read opcao
	case $opcao in
			1) Enssencial;;
			2) Netbeans ;;
			b) Menu ;;
			x) exit ;;
			*) "Opção desconhecida." ; echo ; Programas ;;
    esac
clear


}

Enssencial(){

# ------------------ Flags para as aplicações ------------------

# ABILITANDO FLAGS PARA AS APLICAÇÕES
if ! sudo euse -E python windowmode 256-color font-styles unicode3 infinality mp4 mp3 ffmpeg mpeg mplayer clipboard proprietary-codecs system-ffmpeg mad jpeg dhcpcd networkmanager nls lua wayland X opengl pulseaudio xface png imlib pixbuf
    then
        echo 'ERRO não foi possível configurar as flags ou já estão configuradas'
fi
echo "FLAGS PARA AS APLICAÇÕES ABILITADAS!"

# DESAILITANDO FLAGS PARA AS APLICAÇÕES
if ! sudo euse -D modemmanager
    then
        echo 'ERRO não foi possível configurar as flags ou já estão configuradas'
fi
echo "FLAGS PARA AS APLICAÇÕES DESAILITADAS!"

# sincronizando gentoo
if ! sudo emerge --sync
    then
        echo 'ERRO não consegui sincronizar'
        exit 1
fi
echo "Repositório gentoo sincronizado!"

# atualizando gentoo
if ! sudo emerge --update --deep --with-bdeps=y --newuse @world
    then
        echo 'ERRO não consegui atualizar'
        exit 1
fi
echo "Repositório gentoo atualizado!"

# 10 INSTALANDO PROGRAMAS ADCIONAIS PARA A USUABILIDADE DO DESKTOP
echo "Instalando programas"
if ! sudo emerge -qn media-libs/fontconfig-infinality net-misc/networkmanager app-misc/ranger app-editors/{mousepad,vim} media-plugins/alsa-plugins media-sound/{moc,pulseaudio,alsa-utils} media-video/mplayer app-text/{odt2txt,poppler} app-arch/{unrar,rar,unzip,zip,p7zip,atool} x11-misc/{numlockx,rofi,xcompmgr} www-client/{google-chrome,w3m} media-gfx/{scrot,feh} x11-apps/{xbacklight,xfd,xsetroot} sys-fs/{ntfs3g,dosfstools} x11-terms/{rxvt-unicode,xfce4-terminal} media-fonts/{droid,dejavu,fantasque-sans-mono,fontawesome} dev-util/ctags sys-libs/ncurses dev-python/pyflakes
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mProgramas instalados!\033[0m'
sleep 5
# CONFIGURANDO RANGER MANAGER FILE
if ! ranger --copy-config=all
    then
        echo 'ERRO na linha 576, não foi possível criar arquivos de configuração para o Ranger'
        exit 1
fi
echo -e '\033[01;34mRanger confiugrações copiadas!\033[0m'

# RANGER PRÉ-VISUALIZAÇÃO DE IMAGENS (inicio da configuração)
if ! sed 's/set preview_images false/set preview_images true/g' ~/.config/ranger/rc.conf > ~/.config/ranger/rc.confi
    then
        echo 'ERRO na linha 584, não foi possível configurar o gerenciador de arquivos para visualizar imagens'
        exit 1
fi
echo -e '\033[01;34mPreviwer imagens abilitado!\033[0m'

# RANGER TEMA SOLARIZED (final da configuração)
if ! sed 's/set colorscheme default/set colorscheme solarized/g' ~/.config/ranger/rc.confi > ~/.config/ranger/rc.conf
    then
        echo 'ERRO na linha 592, configurando o tema de cores para o gerenciador de arquivos ranger'
        exit 1
fi
echo -e '\033[01;34mRanger file manager totalmente configurado!\033[0m'

# cd home
if ! cd ~/
    then
        echo 'ERRO não foi possível localizar a pasta home'
        exit 1
fi
echo -e '\033[01;34mHome!\033[0m'
sleep 3
# Criando pastas padrão
if ! mkdir Documentos Downloads Música Vídeo
    then
        echo 'ERRO pastas padões já existem, tudo bem!'
fi
echo -e '\033[01;34mPastas padrão criadas!\033[0m'

# Setando fontes para o urxvt achalas
if ! xset +fp /usr/share/fonts/75dpi/
    then
        echo 'ERRO não foi possível executar o comando xset +fp'
        exit 1
fi

if ! xset fp rehash
    then
        echo 'ERRO não foi possível executar o comando xset fp rehash'
        exit 1
fi
echo -e '\033[01;34mFontes setadas!\033[0m'

# Abilitando filtro LCD
if ! sudo eselect fontconfig enable 11-lcdfilter-default.conf
    then
        echo 'ERRO Filtro não abilitado'
#        exit 1
fi
echo -e '\033[01;34mFiltro LCD abilitado!\033[0m'
sleep 2
# Adicionando como padrão o filtro LCD
if ! sudo eselect lcdfilter set default
    then echo 'ERRO Filtro LCD não foi adicionado como padrão'
fi
echo "default lcdfilter abilitado"

# Fonte infinality
if ! sudo eselect infinality set infinality
    then
        echo 'ERRO configuração da fonte infinality não adicionada'
#        exit 1
fi
echo -e '\033[01;34mInfinality configurado!\033[0m'
sleep 2
# MUDANDO FONTE ROFI
if ! echo "rofi.font: misc Tamzen\ 12" >> ~/.config/rofi/config
    then
        echo 'ERRO configuração da fonte ROFI não adicionada'
fi
echo -e '\033[01;34mFonte do ROFI configurado!\033[0m'
sleep 2
if ! echo "rofi.theme: /usr/share/rofi/themes//gruvbox-dark-soft.rasi" >> ~/.config/rofi/config
    then
        echo 'ERRO configuração do tema ROFI não adicionado'
fi
echo -e '\033[01;34mFonte do ROFI configurado!\033[0m'
sleep 2
# TIRANDO BOARDAS TEMAS ROFI
if ! sudo sed -i "s/border:           1;/border:           0;/g" /usr/share/rofi/themes/solarized_alternate.rasi
then
    echo "Não consegui tirar a borda do tema solarized alternate"
    exit 1
fi
sleep 2
if ! sudo sed -i "s/border:           1;/border:           0;/g" /usr/share/rofi/themes/gruvbox-dark-soft.rasi
then
    echo "Não consegui tirar a borda do tema gruvbox"
    exit 1
fi
###

Menu

}

Netbeans(){

# netbeans
if ! sudo emerge -aq dev-util/netbeans
    then
        echo 'ERRO não foi possível instalar o netbeans'
        exit 1
fi
echo 'Netbeans instalado!'

# desembaçando fontes java
if ! sudo sed -i 1i\ "_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'" /etc/environment
    then
        echo 'ERRO não consegui aplicar o filtro para fontes java'
        exit 1
fi

# java
sudo sed -i "/_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'/d" /etc/environment
var="0"
if test "$var" = "0"
then
sudo sed -i 1i\ "_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd_hrgb'" /etc/environment
fi
echo 'Filtro para fontes java instalado!'

}

#-------------------------------------------------------- VIM ------------------------------------------------------------
Vim(){

	echo
	echo -e "\033[01;34m |||||              Personalização do Vim              ||||| \033[0m"
	echo
	echo -e "\033[1;33;40m[ 1 ]\033[0m Fonte Powerline"
	echo -e "\033[1;33;40m[ 2 ]\033[0m Vim-plug e Plugins"
	echo -e "\033[1;33;40m[ 3 ]\033[0m Fish shell"
	echo -e "\033[1;33;40m[ 4 ]\033[0m Zsh shell"
	echo -e "\033[1;33;40m[ b ]\033[0m Voltar"
	echo
	echo -n "Qual a opção desejada? "
	read opcao
	case $opcao in
			1) FontPowerline ;;
			2) Vimplug ;;
			3) Fish ;;
			4) Zsh ;;
			b) Menu ;;
			x) exit ;;
			*) "Opção desconhecida." ; echo ; Vim ;;
    esac
clear
}

#------------------------------------------------------ POWERLINE FONTE ------------------------------------------------------

FontPowerline(){

#------------------------------------------------------- flag POWERLINE ------------------------------------------------------

# Removendo pasta fonts antiga
fonts="~/fonts"
if [-f "$fonts"]
    then
    rm -rf ~/fonts
    else
        echo "ok"
fi
echo -e '\033[01;34mPasta fonts removida!\033[0m'

echo 'Powerline 1 Clonando as fonts Powerline'
if ! git clone https://github.com/powerline/fonts.git --depth=1
    then
        echo 'ERRO não foi possível clonar fonts'
        exit 1
fi
echo -e '\033[01;34mFonte Powerline Clonada!\033[0m'

echo 'Powerline 3 Instalando fonts Powerline'
if ! sh fonts/install.sh
    then
        echo 'ERRO não foi possível localizar o arquivo de instalação das fonts Powerline'
        exit 1
fi
echo -e '\033[01;34mPowerline Instalado!\033[0m'

# Removendo pasta fonts
if ! rm -rf fonts
    then
        echo 'ERRO pasta fonts não removida'
        exit 1
fi
echo -e '\033[01;34mPasta fonts removida!\033[0m'


Vim
}


#------------------------------------------------ VIM PLUG CONFIGURAÇÃO -------------------------------------------------------

Vimplug(){

# Removendo arquivos de configurações antigos
vimrc="~/.vimrc"
if [ -f "$vimrc" ]
    then
        rm ~/.vimrc
    else
        echo "ok"
fi
echo -e '\033[01;34mClonado!\033[0m'

# Removendo arquivos de configurações antigos
xresources="~/.Xresources"
if [ -f "$xresources" ]
    then
        rm ~/.Xresources
    else
        echo "ok"
fi
echo -e '\033[01;34mClonado!\033[0m'

if ! rm -rf ~/mylinux-conf
    then
        echo "mylinux-conf não removido"
fi

if ! rm -rf ~/.vim
    then
        echo ".vim não removido"
fi
sleep 2
# Criando pasta Imagens
if ! mkdir ~/Imagens
    then
        echo 'ERRO não foi possível criar a pasta Imagens ou já exite a pasta'
fi
echo -e '\033[01;34mPasta Imagens criada!\033[0m'
sleep 2

# Airline 5 Clone arquivo .vimrc e .Xresources
if ! git clone https://github.com/Quebravel/mylinux-conf.git ~/mylinux-conf
    then
        echo 'ERRO não foi possível clonar mylinux-conf'
        exit 1
fi
echo -e '\033[01;34mClonado!\033[0m'
sleep 2

# Clone font tamzen
if ! git clone https://github.com/sunaku/tamzen-font.git ~/.local/share/fonts/tamzen-font
    then
        echo 'ERRO não foi possível clonar o tamzen-font ou já existe'
fi
echo 'Tamzen fonte clonada e adicionada ao local das fontes'
sleep 2

# 6 configurações
if ! cd ~/mylinux-conf
    then
        echo 'ERRO não foi possível localizar a pasta mylinux-conf'
        exit 1
fi
echo -e '\033[01;34mOk!\033[0m'

# 7 Mover .vimrc .Xresources
if ! cp -rf .vimrc .Xresources ~/
    then
        echo 'ERRO não foi possível copiar .vimrc e .Xresources para a pasta home'
        exit 1
fi
echo -e '\033[01;34mMovidos!\033[0m'
sleep 2
# criando pasta para o papel de parede
if ! cp -rf wallpapers/girl.jpg ~/Imagens
    then
        echo 'ERRO não foi possível mover o papel de parede'
        exit 1
fi
echo -e '\033[01;34mPapel de parede adicionado!\033[0m'

# Copiando ProFont e MonacoPowerline
if ! cp -rf proFont MonacoPowerline ~/.local/share/fonts/
    then
        echo 'ERRO não foi possível mover as fontes proFont e monaco'
        exit 1
fi
echo -e '\033[01;34mFonte ProFont e Monaco instalada!\033[0m'
sleep 2
if ! xset +fp /usr/share/fonts/75dpi/
then
    echo "ERRO não foi possível executar o comando xset +fp para configurar as fontes"
fi

if ! xset fp rehash
then
    echo "ERRO não foi possível executar o comando xset fp rehash para configurar as fontes"
fi

if ! xrdb ~/.Xresources
then
    echo "ERRO não foi possível executar o comando para reiniciar as configurações do Xresources"
fi

# Airline 8 Saindo da pasta
if ! cd ~/
    then
        echo 'ERRO não foi possível voltar a pasta home =('
        exit 1
fi
echo -e '\033[01;34mOk!\033[0m'

if ! rm -rfv ~/mylinux-conf
    then
        echo 'ERRO a pasta mylinux-conf não foi removida'
        exit 1
fi
echo -e '\033[01;34mOk!\033[0m'



#------------------------------------------------- PIP POWERLINE STATUS --------------------------------------------------------
<<airline
# Airline 10 Emerge pip
if ! sudo emerge -qn dev-python/pip
then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mPip instalado!\033[0m'

# Airline 11 usando pip status
if ! pip install --user powerline-status
then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mpowerline-status instalado!\033[0m'

# Airline 12 usando pip powerline
if ! pip install --user git+git://github.com/powerline/powerline
then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mConfiguração da fonte instalada!\033[0m'

# Airline 13 baixando symbols 1
if ! wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mSymbols baixados!\033[0m'

# Airline 14 baixando symbols 2-------------------------------
if ! wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mPowerline symbols baixado!\033[0m'

# Airline 15 Mova e aponte os arquivos para as seguintes pastas
if ! mv PowerlineSymbols.otf ~/.local/share/fonts/
then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mSymbols otf movido!\033[0m'

# Airline 17 mv 10-powerline-symbols.conf--------------------
if ! sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/
then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mPowerline symbols movida!\033[0m'

# Airline 16-------------------------------------------------
if ! fc-cache -vf ~/.local/share/fonts/
then
        echo 'ERRO'
        :exit 1
fi
echo -e '\033[01;34mFontes atualizadas!\033[0m'

# Vim 18 voltar para pasta home-----------------------------
if ! cd ~/
then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mOk!\033[0m'

airline

#---------------------------------------------------------PLUGINS-------------------------------------------------------

# Removendo pasta .vim
vim="~/.vim"
if [ -f "$vim" ]
    then
        rm -rf ~/.vim
    else
        echo "ok"
fi
echo -e '\033[01;34mPastas .vim antiga removida!\033[0m'
sleep 2
# PLUGIN INSTALANDO VIM-PLUG
if ! curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    then
        echo 'ERRO não foi possível fazer o download do vim-plug'
        exit 1
fi
echo -e '\033[01;34mVim-plug instalado!\033[0m'
sleep 3
# PLUGIN INSTALANDO
if ! vim +PlugInstall +qall
    then
        echo 'ERRO não foi possível executar a instalação com +PlugInstall'
        exit 1
fi
echo -e '\033[01;34m++++ PLUGINS INSTALADOS! ++++\033[0m'
sleep 1
# Removendo pastas desnecessárias
if ! rm -rf mylinux-conf
    then
        echo 'ERRO não foi possível remover a pasta mylinux-conf'
        exit 1
fi
echo -e '\033[01;34mPastas fonts e mylinux-conf removidas!\033[0m'
sleep 2
# Copiando as configurações para o root - .vimrc
if ! sudo cp -rf ~/.vimrc /root/
    then
        echo 'ERRO não foi possível copiar o .vimrc'
        exit 1
fi
echo -e '\033[01;34mArquivo .vimrc tambem copiado para o root!\033[0m'
sleep 3
# Copiando os plugins para o root - .vim
if ! sudo cp -rf ~/.vim /root/
    then
        echo 'ERRO não foi possível copiar a pasta .vim para o root'
        exit 1
fi
echo -e '\033[01;34mPasta .vim copiada para o root!\033[0m'


Vim
}

#-------------------------------------------------------------- FISH -----------------------------------------------------------
Fish(){

# sincronizando gentoo
if ! sudo emerge --sync
    then
        echo 'ERRO não consegui sincronizar'
        exit 1
fi
echo "Repositório gentoo sincronizado!"

# atualizando gentoo
if ! sudo emerge --update --deep --with-bdeps=y --newuse @world
    then
        echo 'ERRO não consegui atualizar'
        exit 1
fi
echo "Repositório gentoo atualizado!"

# Removendo pastas antigas
if ! rm -rf ~/oh-my-fish
    then
        echo "ok"
fi
echo -e '\033[01;34mPastas oh-my-fish antiga removida!\033[0m'

if ! rm -rf ~/.local/share/omf/
    then
        echo "ok"
fi
echo -e '\033[01;34mPastas omf antiga removida!\033[0m'

if ! rm -rf ~/mylinux-conf
     then
        echo "ok"
fi
echo -e '\033[01;34mPastas mylinux-conf antiga removida!\033[0m'
sleep 2
# Pasta raiz
if ! cd
    then
        echo 'ERRO não consegui voltar para a pasta home'
        exit 1
fi
echo -e '\033[01;34mok!\033[0m'

# Instalando fish
if ! sudo emerge -aqn app-shells/fish
    then
        echo 'ERRO não consegui instalar o shell fish'
        exit 1
fi
echo -e '\033[01;34mFish shell instalado!\033[0m'
sleep 2
# Baixando configuração do tema
if ! git clone https://github.com/Quebravel/mylinux-conf.git ~/mylinux-conf
    then
        echo 'ERRO não foi possível clonar mylinux-conf'
        exit 1
fi
echo -e '\033[01;34mConfiguração baixada!\033[0m'

# Criando pasta de configuração
if ! mkdir ~/.config/fish/
    then
        echo 'ERRO não foi possível criar a pasta fish em .config ou já existe'
fi
echo -e '\033[01;34mPasta fish criada!\033[0m'
sleep 2

# Movendo tema
if ! cp -rf ~/mylinux-conf/config.fish ~/.config/fish/
    then
        echo 'ERRO configuração do fish não copiada'
        exit 1
fi
echo -e '\033[01;34mConfiguração preferido copiada!\033[0m'
sleep 2
# Deixando o fish shell como padrão
if ! chsh -s /bin/fish
    then
        echo 'ERRO não consegui configurar o shell fish como padrão'
        exit 1
fi
echo -e '\033[01;34mShell padrão: Fish!\033[0m'

# Deixando o fish shell como padrão no root
if ! sudo chsh -s /bin/fish
    then
        echo 'ERRO não consegui configurar o shell fish como padrão no root'
        exit 1
fi
echo -e '\033[01;34mShell padrão: Fish!\033[0m'
sleep 2
# Clonando oh my fish!
if ! git clone https://github.com/oh-my-fish/oh-my-fish ~/oh-my-fish
    then
        echo 'ERRO não consegui clonar o oh-my-fish'
        exit 1
fi
echo -e '\033[01;34m Oh my fish clonado!\033[0m'
sleep 2
# instalando oh my fish
if ! cd ~/oh-my-fish
    then
        echo 'ERRO não consegui entrar na pasta oh-my-fish'
        exit 1
fi
sleep 2
if ! bin/install --offline
    then
        echo 'ERRO não consegui instalar o tema oh-my-fish'
        exit 1
fi
echo -e '\033[01;34mOh my fish instalado!\033[0m'
sleep 2
# Saido da pasta
if ! cd
    then
        echo 'ERRO não consegui voltar para a pasta home'
        exit 1
fi
sleep 2
# Entrando no fish
if ! fish
    then
        echo 'ERRO não consegui entrar no fish'
#        exit 1
fi
echo -e '\033[01;34mfish!\033[0m'



Vim
}

#-------------------------------------------------------------- ZSH ------------------------------------------------------------

Zsh(){

# zsh
if ! sudo emerge -qn app-shells/zsh
    then
        echo 'ERRO não foi possível instalar o zsh'
        exit 1
fi
echo -e '\033[01;34mZsh instalado!\033[0m'
sleep 1
# zsh completions
if ! sudo emerge -qn app-shells/zsh-completions
    then
        echo 'ERRO não foi possível instalar o zsh completions'
        exit 1
fi
echo -e '\033[01;34mZsh completion instalado!\033[0m'
sleep 1
# zsh completion gentoo
if ! sudo emerge -qn app-shells/gentoo-zsh-completions
    then
        echo 'ERRO não foi possível instalar o zsh completions gentoo'
        exit 1
fi
echo -e '\033[01;34mZsh completions gentoo instalado!\033[0m'
sleep 1

# zsh como padrão root
if ! sudo chsh -s /bin/zsh
    then
        echo 'ERRO não foi possível alterar o zsh como padão no root'
        exit 1
fi
echo -e '\033[01;34mZsh como padrão no root!\033[0m'
sleep 1
# zsh como padrão
if ! chsh -s /bin/zsh
    then
        echo 'ERRO não foi passível alterar o zsh como padrão'
        exit 1
fi
echo -e '\033[01;34mZsh como padrão!\033[0m'
sleep 1
# oh-my-zsh
if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    then
	sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    else
        echo 'ERRO não foi possivel instalar o oh-my-zsh'
        exit 1
fi
echo -e '\033[01;34mOh-my-zsh instalado!\033[0m'
sleep 2
# mudando tema oh-my-zsh
if ! sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc
    then
        echo 'ERRO não consegui mudar o tema'
        exit 1
fi
echo -e '\033[01;34mTema oh-my-zsh alterado para agnoster!\033[0m'



Vim
}


Teclado(){

if ! rm -rf ~/tecladoVideoConfig
    then
        echo 'Não tem a pasta tecladoVideoConfig, tudo bem'
fi

# 1 clonado
if ! git clone https://github.com/Quebravel/tecladoVideoConfig.git ~/tecladoVideoConfig
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mConfigurações clonadas!\033[0m'
sleep 2
# 2 movendo configuração do teclado para br-abnt2
if ! sudo cp ~/tecladoVideoConfig/30-keyboard.conf /etc/X11/xorg.conf.d/
    then
        echo 'ERRO cópia de configuração de teclado não movidas '
        exit 1
fi
echo -e '\033[01;34mConfiguração do teclado movida!\033[0m'

# 3 movendo configuração do touchpad
if ! sudo cp ~/tecladoVideoConfig/70-synaptics.conf /etc/X11/xorg.conf.d/
    then
        echo 'ERRO cópia de configuração do touchpad não movida'
        exit 1
fi
echo -e '\033[01;34mConfiguração do touchpad movida!\033[0m'

# 4 removendo pasta
if ! rm -rf tecladoVideoConfig
    then
        echo 'ERRO pasta tecladoVideoConfig não removida'
        exit 1
fi
echo -e '\033[01;34mPasta removida!\033[0m'


Menu
}


Video(){
	echo
	echo -e "\033[1;34m |||||            Escolha o drive da sua GPU            |||||\033[0m"
	echo
	echo -e "\033[1;34;40m[ 1 ]\033[0m Configurar/Instalar Driver Intel"
	echo -e "\033[1;34;40m[ 2 ]\033[0m Configurar/Instalar Driver Radeon"
	echo -e "\033[1;34;40m[ 3 ]\033[0m Configurar/Instalar Driver Nvidia"
	echo -e "\033[1;34;40m[ 4 ]\033[0m Configurar/Instalar Driver Virtualbox"
	echo -e "\033[1;34;40m[ 5 ]\033[0m Configurar dbus/consolekit/alsasound/networkmanager"
	echo -e "\033[1;34;40m[ b ]\033[0m Voltar"
	echo
	echo -n "Qual a opção desejada? "
	read opcao
	case $opcao in
			1) Intel ;;
			2) Radeon ;;
			3) Nvidia ;;
			4) Vbox ;;
			5) Audio ;;
			b) Menu ;;
			x) exit ;;
			*) "Opção desconhecida." ; echo ; Video ;;
    esac
clear
}



Intel(){

# flag VIDEO_CARDS="intel"
sudo sed -i 's/VIDEO_CARDS="radeon"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="intel"/g' /etc/portage/make.conf
fi
sleep 2
sudo sed -i 's/VIDEO_CARDS="nvidia"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="intel"/g' /etc/portage/make.conf
fi
sleep 2
sudo sed -i 's/VIDEO_CARDS="virtualbox"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="intel"/g' /etc/portage/make.conf
fi
sudo sed -i 's/VIDEO_CARDS="vesa"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="intel"/g' /etc/portage/make.conf
fi

sleep 3

# Intel flag
sudo sed -i 's/intel //g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/USE="/USE="intel /g' /etc/portage/make.conf
fi
sleep 2
# 0 Instalando drive intel
if ! sudo emerge -qn x11-drivers/xf86-video-intel
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mDrive intel instalado!\033[0m'

# 1 clonando pasta da intel
if ! git clone https://github.com/Quebravel/tecladoVideoConfig.git
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mConfigurações clonadas!\033[0m'
sleep 2
# movendo configuração intel
if ! sudo mv -v tecladoVideoConfig/20-intel.conf /etc/X11/xorg.conf.d/
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34mConfiguração movida!\033[0m'

# removendo pasta
if ! rm -rf tecladoVideoConfig
    then
        echo 'ERRO pasta tecladoVideoConfig não removida'
        exit 1
fi
echo -e '\033[01;34mPasta removida!\033[0m'

Video
}

Radeon(){

# Flag VIDEO_CARDS="radeon"
sudo sed -i 's/VIDEO_CARDS="intel"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="radeon"/g' /etc/portage/make.conf
fi
sleep 2
sudo sed -i 's/VIDEO_CARDS="nvidia"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="radeon"/g' /etc/portage/make.conf
fi
sleep 2
sudo sed -i 's/VIDEO_CARDS="virtualbox"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="radeon"/g' /etc/portage/make.conf
fi
sleep 2
sudo sed -i 's/VIDEO_CARDS="vesa"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="radeon"/g' /etc/portage/make.conf
fi

sleep 3

# 0 Instalando drive radeon
if ! sudo emerge -qn x11-drivers/xf86-video-amdgpu
    then
        echo 'ERRO instalação do drive de video da radeon não executada'
        exit 1
fi
echo -e '\033[01;34mDrive radeon instalado!\033[0m'

# 1 clonando configuração
if ! git clone https://github.com/Quebravel/tecladoVideoConfig.git
    then
        echo 'ERRO git das configurações de teclado e videos não executado'
        exit 1
fi
echo -e '\033[01;34mConfigurações clonadas!\033[0m'
sleep 2
# 2 movendo configuração radeon
if ! sudo mv -v tecladoVideoConfig/50-device.conf /etc/X11/xorg.conf.d/
    then
        echo 'ERRO configuração de video da radeon não copiada'
        exit 1
fi
echo -e '\033[01;34mConfiguração movida!\033[0m'
sleep 2
# 3 removendo a pasta
if ! rm -rf tecladoVideoConfig
    then
        echo 'ERRO pasta tecladoVideoConfig não removida'
        exit 1
fi
echo -e '\033[01;34mPasta removida!\033[0m'

Video
}

Nvidia(){

# Flag VIDEO_CARDS="nvidia"
sudo sed -i 's/VIDEO_CARDS="intel"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="nvidia"/g' /etc/portage/make.conf
fi
sleep 2

sudo sed -i 's/VIDEO_CARDS="radeon"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="nvidia"/g' /etc/portage/make.conf
fi
sleep 2

sudo sed -i 's/VIDEO_CARDS="virtualbox"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="nvidia"/g' /etc/portage/make.conf
fi
sleep 2

sudo sed -i 's/VIDEO_CARDS="vesa"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="nvidia"/g' /etc/portage/make.conf
fi

sleep 3

# acpi
sudo sed -i 's/acpi //g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/USE="/USE="acpi /g' /etc/portage/make.conf
fi
sleep 2
# multilib
sudo sed -i 's/multilib //g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/USE="/USE="multilib /g' /etc/portage/make.conf
fi
sleep 2
# static-libs
sudo sed -i 's/static-libs //g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/USE="/USE="static-libs /g' /etc/portage/make.conf
fi

# wayland
sudo sed -i 's/wayland //g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/USE="/USE="wayland /g' /etc/portage/make.conf
fi
sleep 2
# Nvidia driver
if ! sudo emerge -qn x11-drivers/nvidia-drivers
    then
        echo 'ERRO não consegui instalar o driver nvidia'
        exit 1
fi
echo -e '\033[01;34mDriver Nvidia instalado!\033[0m'
sleep 2
# Nvidia opções
if ! sudo emerge -qn media-video/nvidia-settings
    then
        echo 'ERRO não consegui instalar o gerenciador da Nvidia'
        exit 1
fi
echo -e '\033[01;34mGerenciador da Nvidia instalado!\033[0m'

Video
}

Vbox(){

# Flag VIDEO_CARDS="virtualbox"
sudo sed -i 's/VIDEO_CARDS="intel"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="virtualbox"/g' /etc/portage/make.conf
fi
sleep 2

sudo sed -i 's/VIDEO_CARDS="radeon"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="virtualbox"/g' /etc/portage/make.conf
fi
sleep 2

sudo sed -i 's/VIDEO_CARDS="nvidia"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="virtualbox"/g' /etc/portage/make.conf
fi
sleep 2

sudo sed -i 's/VIDEO_CARDS="vesa"/VIDEO_CARDS=""/g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/VIDEO_CARDS=""/VIDEO_CARDS="virtualbox"/g' /etc/portage/make.conf
fi

sleep 3

# dri
sudo sed -i 's/dri //g' /etc/portage/make.conf
var="0"
if test "$var" = "0"
then
sudo sed -i 's/USE="/USE="dri /g' /etc/portage/make.conf
fi

sleep 2

# x11-drivers/xf86-video-virtualbox
if ! sudo emerge -qn x11-drivers/xf86-video-virtualbox app-emulation/{virtualbox-additions,virtualbox-guest-additions}
    then
        echo 'ERRO não foi possível instalar o drive e os adicionais para o virtualbox'
        exit 1
fi
echo -e '\033[01;34mDrive e os adicionais foram instalados!\033[0m'

# [][][]
if ! [][][]
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34m[][][]!\033[0m'

# [][][]
if ! [][][]
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34m[][][]!\033[0m'

# [][][]
if ! [][][]
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34m[][][]!\033[0m'

Video
}

Audio(){

# dbus start
if ! sudo /etc/init.d/dbus start
    then
        echo 'ERRO dbus não iniciou ou já iniciado'
fi
echo -e '\033[01;34m dbus iniciado!\033[0m'
sleep 2
# dbus rc
if ! sudo rc-update add dbus default
    then
        echo 'ERRO dbus não setando ou já adicionado anteriormente'
fi
echo -e '\033[01;34m dbus adicionado ao rc!\033[0m'

# consolekit start
if ! sudo /etc/init.d/consolekit start
    then
        echo 'ERRO consolekit não iniciou ou já iniciado'
fi
echo -e '\033[01;34m consolekit iniciado!\033[0m'
sleep 2
# consolekit rc
if ! sudo rc-update add consolekit default
    then
        echo 'ERRO consolekit não setando ou já adicionado anteriormente'
fi
echo -e '\033[01;34m consolekit no rc!\033[0m'

# alsasound start
if ! sudo /etc/init.d/alsasound start
    then
        echo 'ERRO alsasound não iniciado ou já iniciado anteriormente'
fi
echo -e '\033[01;34m alsasound iniciado!\033[0m'
sleep 2
# alsasound boot
if ! sudo rc-update add alsasound boot
    then
        echo 'ERRO alsasound não adicionado ao boot ou já adicionado anteriormente'
fi
echo -e '\033[01;34m alsasound configurado para iniciar durante o boot!\033[0m'
sleep 2
# alsamixer ligando o áudio
if ! amixer sset Master unmute
    then
        echo '1555 ERRO não foi possível ligar o áudio'
        exit 1
fi
echo -e '\033[01;34mAudio ligado!\033[0m'

# alsamixer intencisade maxima do áudio
if ! amixer sset Master 100%
    then
        echo 'ERRO não foi possível aumentar a amplitude do áudio'
fi
echo -e '\033[01;34mAudio com intencidade maxima!\033[0m'

# Atualizando source profile
if ! sudo env-update && source /etc/profile
    then
        echo 'ERRO env-update não atualizado'
        exit 1
fi
echo -e '\033[01;34mSource profile atualizado!\033[0m'


Video
}


Menu

<< yume
# [][][]
if ! [][][]
    then
        echo 'ERRO'
        exit 1
fi
echo -e '\033[01;34m[][][]!\033[0m'

yume
