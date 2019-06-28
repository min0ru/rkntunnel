import urllib.request

source_url = 'https://reestr.rublacklist.net/api/v2/ips/csv'

ip_list = set()

with urllib.request.urlopen(source_url) as source:
    for csvline in source:
        ip_list.update(csvline.decode('utf-8').rstrip().split(';')[-1].split(','))

for ip in ip_list:
    print(ip)
