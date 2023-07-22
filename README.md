# sshConnect
A WIP ssh connection selector
 
## Features
* Access all your ssh servers from one menu using a TUI
* Only need to expose one port to access all your ssh servers
* Cusomizable
* Deploy using docker

## Installation

### On linux
1. Install the dependencies:
 - wget
 - openssh-server 
 - openssh-client 
 - bc 
 - whiptail 
 - sshpass 
2. Download sshcon
   ```sudo wget https://raw.githubusercontent.com/Pegoku/sshConnect/main/sshcon -O /usr/bin/sshcon ```
3. Make the file executable
```sudo chmod +x /usr/bin/sshcon ```
4. Create the sshcon user and set a custom shell
```sudo useradd --shell /usr/bin/sshcon sshcon```
5. Copy systemctl sshd config
```sudo cp /etc/systemd/system/sshd.service /etc/systemd/system/sshd-sshcon.service ```
6. Copy sshd-config file
```sudo cp /etc/ssh/sshd{,-sshcon}_config```
7. Add this lines to ssh-sshcon_config
```
Port 24
AllowUsers sshcon
```
8. Edit sshd-sshcon.service
```
FROM: ExecStart=/usr/sbin/sshd -D $SSHD_OPTS
TO: ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd-sshcon_config $SSHD_OPTS

FROM: Alias=sshd.service
TO: Alias=sshd-sshcon.service
```
9. Change user password
```echo 'sshcon:passwordforuser' | sudo chpasswd```
10. Refresh systemctl
```sudo systemctl daemon-reload```
1.  Enable and run service
```sudo systemctl enable sshd-sshcon.service --now```

### Using docker
1. Install [docker](https://docs.docker.com/engine/install/)
2. Install [git](https://git-scm.com/downloads)
3. Clone the repository
``` git clone https://github.com/Pegoku/sshConnect.git ```
1. Edit **sshcon**
2. Edit **Dockerfile**
3. Build the docker image
``` docker build -t <image_name> . ```
1. Run the image
``` docker run -d -p 24:24 <image_name> ```

## Planned features
- [ ] Configuration of servers using a config file
- [ ] Easier installation
- [ ] Multiple users with per-user options