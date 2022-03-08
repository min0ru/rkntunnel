# rkntunnel

## Usage:

Install dependencies and add services to automatic startup (Debian/Ubuntu):

```bash
sudo apt install ipset redsocks
sudo systemctl enable redsocks
sudo systemctl start redsocks

sudo apt install python3-dev python3-venv

sudo apt install golang

sudo apt install libffi-dev python3-dev python3-virtualenv

python -m venv .venv
.venv/bin/pip install -r requirements.txt
```

Add "rkntunnel" host as SSH endpoint:

```bash
echo "Host rkntunnel\nHostName: ssh_server_addr\nPort ssh_server_port\n" >>
~/.ssh/config
```

Run tunnel:

```bash
./rkntunnel
```

## To disable tunnel:

```bash
./stop_rkntunnel
```

------
Constitution of the Russian Federation

Article 29.5

The freedom of mass communication shall be guaranteed. Censorship shall be banned.

Article 23.2

Everyone shall have the right to privacy of correspondence, of telephone conversations, postal, telegraph and other messages. Limitations of this right shall be allowed only by court decision.

