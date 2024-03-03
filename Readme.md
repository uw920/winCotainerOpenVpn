## 1. 尝试在Docker中安装OpenVPN的MSI包
可以用命令在本地Win11环境中实现MSI静默安装, 但在Docker中无法成功, 试过好几种方法, 参数下面这个Link

### workaround
把本地的安装包, 复制到Windows container中, 可手动执行.

## 2. 开机启动VPN
可以开机启动VPN, 但还是要输入用户名和密码

## 3.运行命令：
**build**
```bash
D:\workspace\ptest\src\docker>docker build -t myvpn:1 .
Sending build context to Docker daemon   11.2MB
Step 1/12 : FROM mcr.microsoft.com/windows/servercore:ltsc2022
 ---> 1f57f3b65348
Step 2/12 : LABEL maintainer ""
 ---> Using cache
 ---> 35127a7de20d
Step 3/12 : SHELL [ "powershell", "-Command"]
 ---> Using cache
 ---> dd80a99f1b6a
Step 4/12 : ARG CFG="dianxin"
 ---> Using cache
 ---> f7dc9705dc54
Step 5/12 : ENV CFG=$CFG
 ---> Using cache
 ---> c25029bc7f21
Step 6/12 : RUN mkdir "C:\\myopenvpn"
 ---> Using cache
 ---> ff702e2be17f
Step 7/12 : COPY "ca.crt" "C:\\myopenvpn\\ca.crt"
 ---> Using cache
 ---> b7ab90b71ab0
Step 8/12 : COPY "ustc-cmcc.ovpn" "C:\\myopenvpn\\ustc-cmcc.ovpn"
 ---> Using cache
 ---> 51a71aaa3209
Step 9/12 : COPY "ustc-dianxin.ovpn" "C:\\myopenvpn\\ustc-dianxin.ovpn"
 ---> Using cache
 ---> a8a4634c4597
Step 10/12 : COPY OpenVPN.zip C:\\
 ---> Using cache
 ---> 7227cce9fdd8
Step 11/12 : RUN Expand-Archive -Force "C:\OpenVPN.zip" "c:\\"
 ---> Using cache
 ---> 2031f35d2cfa
Step 12/12 : CMD ["cmd", "/c", "C:\\OpenVPN\\bin\\openvpn.exe", "--config", "C:\\myopenvpn\\ustc-%CFG%.ovpn", "--ca", "C:\\myopenvpn\\ca.crt"]
 ---> Using cache
 ---> f5972187002c
Successfully built f5972187002c
Successfully tagged myvpn:1

What's Next?
  View a summary of image vulnerabilities and recommendations → docker scout quickview

```


**run with default value**
```bash
D:\workspace\ptest\src\docker>docker run -it myvpn:1
2024-03-03 14:52:20 WARNING: Compression for receiving enabled. Compression has been used in the past to break encryption. Sent packets are not compressed unless "allow-compression yes" is also set.
2024-03-03 14:52:20 Note: --cipher is not set. OpenVPN versions before 2.5 defaulted to BF-CBC as fallback when cipher negotiation failed in this case. If you need this fallback please add '--data-ciphers-fallback BF-CBC' to your configuration and/or add BF-CBC to --data-ciphers.
2024-03-03 14:52:20 Note: '--allow-compression' is not set to 'no', disabling data channel offload.
2024-03-03 14:52:20 OpenVPN 2.6.9 [git:v2.6.9/6640a10bf6d84eee] Windows [SSL (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] [DCO] built on Feb 12 2024
2024-03-03 14:52:20 Windows version 10.0 (Windows 10 or greater), amd64 executable
2024-03-03 14:52:20 library versions: OpenSSL 3.2.0 23 Nov 2023, LZO 2.10
2024-03-03 14:52:20 DCO version: N/A
Enter Auth Username:
Enter Auth Password:
2024-03-03 14:52:22 ERROR: Auth username is empty
2024-03-03 14:52:22 Exiting due to fatal error
```
**run with paramenter cmcc**
```bash
D:\workspace\ptest\src\docker>docker run -it -e CFG=cmcc myvpn:1
2024-03-03 14:54:50 WARNING: Compression for receiving enabled. Compression has been used in the past to break encryption. Sent packets are not compressed unless "allow-compression yes" is also set.
2024-03-03 14:54:50 Note: --cipher is not set. OpenVPN versions before 2.5 defaulted to BF-CBC as fallback when cipher negotiation failed in this case. If you need this fallback please add '--data-ciphers-fallback BF-CBC' to your configuration and/or add BF-CBC to --data-ciphers.
2024-03-03 14:54:50 Note: '--allow-compression' is not set to 'no', disabling data channel offload.
2024-03-03 14:54:50 OpenVPN 2.6.9 [git:v2.6.9/6640a10bf6d84eee] Windows [SSL (OpenSSL)] [LZO] [LZ4] [PKCS11] [AEAD] [DCO] built on Feb 12 2024
2024-03-03 14:54:50 Windows version 10.0 (Windows 10 or greater), amd64 executable
2024-03-03 14:54:50 library versions: OpenSSL 3.2.0 23 Nov 2023, LZO 2.10
2024-03-03 14:54:50 DCO version: N/A
Enter Auth Username:
Enter Auth Password:
```