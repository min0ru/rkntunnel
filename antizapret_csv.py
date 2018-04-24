import urllib.request

source_url = 'https://api.antizapret.info/all.php?type=csv'

ip_list = set()

with urllib.request.urlopen(source_url) as source:
    for csvline in source:
        ip_list.update(csvline.decode('utf-8').rstrip().split(';')[-1].split(','))

for ip in ip_list:
    print(ip)
