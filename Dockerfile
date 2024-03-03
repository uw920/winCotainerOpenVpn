
FROM mcr.microsoft.com/windows/servercore:ltsc2022
#FROM mcr.microsoft.com/windows:ltsc2019
LABEL maintainer "atom.you@icloud.com"

SHELL [ "powershell", "-Command"]
ARG CFG="dianxin"
ENV CFG=$CFG

#ADD https://swupdate.openvpn.org/community/releases/OpenVPN-2.6.9-I001-amd64.msi C:\\openvpn-install.msi
#RUN msiexec /i "C:\\OpenVPN\\openvpn-install.msi" /qn /norestart
#RUN msiexec /i "C:\\OpenVPN\\openvpn-install.msi" PRODUCTDIR="C:\\OpenVPN\\" /quiet /qn /norestart ADDLOCAL=OpenVPN.Service,OpenVPN,Drivers,Drivers.Wintun /passive
#msiexec /i "D:\Software\orion\Downloads\OpenVPN-2.6.9-I001-amd64.msi" PRODUCTDIR="C:\\OpenVPN\\" /quiet /qn /norestart ADDLOCAL=OpenVPN.Service,OpenVPN,Drivers,Drivers.Wintun /passive
#RUN msiexec /i "C:\\openvpn-install.msi" /quiet /norestart ADDLOCAL=OpenVPN.Service,OpenVPN,Drivers,Drivers.Wintun /passive || echo "Error ignored"
#RUN Start-Process msiexec.exe -ArgumentList '-i', 'c:\openvpn-install.msi', '/quiet', '/norestart' -NoNewWindow

RUN mkdir "C:\\myopenvpn"
COPY "ca.crt" "C:\\myopenvpn\\ca.crt"
COPY "ustc-cmcc.ovpn" "C:\\myopenvpn\\ustc-cmcc.ovpn"
COPY "ustc-dianxin.ovpn" "C:\\myopenvpn\\ustc-dianxin.ovpn"
#COPY dianxin.bat C:\\
#COPY cmcc.bat C:\\
COPY OpenVPN.zip C:\\
RUN Expand-Archive -Force "C:\OpenVPN.zip" "c:\\"

#RUN setx path "%path%;C:\\OpenVPN\\bin"
#CMD ["cmd", "/c", "C:\\%CFG%.bat"]
CMD ["cmd", "/c", "C:\\OpenVPN\\bin\\openvpn.exe", "--config", "C:\\myopenvpn\\ustc-%CFG%.ovpn", "--ca", "C:\\myopenvpn\\ca.crt"]
