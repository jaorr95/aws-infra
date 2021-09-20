#cloud-config
repo_update: true
repo_upgrade: all
packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg
  - lsb-release

write_files:
%{ for config_file in config_server ~}
  - encoding: b64
    content: ${config_file.content}
    permissions: '0644'
    path: ${config_file.path}
%{ endfor ~}


runcmd:
  - curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
  - echo  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  - apt update -y
  - apt install -y docker-ce docker-ce-cli containerd.io docker-compose
  - systemctl start docker
  - systemctl enable docker
  - docker-compose -f /etc/server/docker-compose.yml  up --build -d

