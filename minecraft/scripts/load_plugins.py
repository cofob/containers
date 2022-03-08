import os
from json import load
from hashlib import sha256
from multiprocessing import Pool


with open('config.json', 'r') as file:
    config = load(file)

if not os.path.isdir('plugins'):
    os.mkdir('plugins')

if not os.path.isdir('mods') and config.get("mods"):
    os.mkdir('mods')


h = sha256(config["server"].encode()).hexdigest()[:8]
name = f'server-{h}.jar'

if not os.path.isfile(name):
    print("Downloading server.")
    os.system(f'wget -nv -O {name} {config["server"]}')

for p in os.listdir():
    if p.startswith('server') and p.endswith('.jar'):
        if p != name:
            os.remove(p)


os.chdir('plugins')

if os.path.isfile('downloading.jar'):
    os.remove('downloading.jar')

pl = []

append = config.get('base', '')


def download(url):
    if url.startswith('#'):
        return
    url = append + url
    h = sha256(url.encode()).hexdigest()[:8]
    name = f'{h}.jar'
    pl.append(name)
    print(url, name)
    if not os.path.isfile(name):
        os.system(f'wget -nv -O "{name}" "{url}"')



print("Downloading plugins.")
with Pool(10) as p:
    p.map(download, config["plugins"])


pls = os.listdir()
for p in pls:
    if p not in pl:
        if os.path.isfile(p):
            os.remove(p)

os.chdir('..')


if config.get('mods'):
    print("Downloading mods.")
    os.chdir('mods')

    if os.path.isfile('downloading.jar'):
        os.remove('downloading.jar')

    with Pool(10) as p:
        p.map(download, config["mods"])
    
    os.chdir('..')



if config.get("commands"):
    for command in config["commands"]:
        print(f"Executing '{command}'")
        os.system(command)


print('Done.')
