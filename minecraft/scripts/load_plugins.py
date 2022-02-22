import os
from json import load
from hashlib import sha256


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

print("Downloading plugins.")
for i in config['plugins']:
    if i.startswith('#'):
        continue
    i = append + i
    h = sha256(i.encode()).hexdigest()[:8]
    name = f'{h}.jar'
    pl.append(name)
    if not os.path.isfile(name):
        os.system(f'wget -nv -O downloading.jar "{i}"')
        os.rename('downloading.jar', f'{name}')

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

    for i in config.get('mods'):
        if i.startswith('#'):
            continue
        i = append + i
        h = sha256(i.encode()).hexdigest()[:8]
        name = f'{h}.jar'
        pl.append(name)
        if not os.path.isfile(name):
            os.system(f'wget -nv -O downloading.jar "{i}"')
            os.rename('downloading.jar', f'{name}')
    
    os.chdir('..')



if config.get("commands"):
    for command in config["commands"]:
        print(f"Executing '{command}'")
        os.system(command)


print('Done.')
