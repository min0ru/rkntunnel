import json
import urllib2

source_url = 'https://api.antizapret.info/all.php?type=json'
data = json.load(urllib2.urlopen(source_url))

ip_list = []
url_list = []
for site in data['register']:
    ips = site['ip'].split(',')
    ip_list.extend(ips)
    url = site['url']
    url_list.append(url)

ip_list = list(set(ip_list))
url_list = list(set(url_list))

for ip in ip_list:
    print ip