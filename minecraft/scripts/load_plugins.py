import os
from json import load
from hashlib import sha256
from multiprocessing import Pool
from subprocess import Popen


with open("config.json", "r") as file:
    config = load(file)

if not os.path.isdir("plugins"):
    os.mkdir("plugins")

if not os.path.isdir("mods") and config.get("mods"):
    os.mkdir("mods")


h = sha256(config["server"].encode()).hexdigest()[:8]
name = f"server-{h}.jar"

if not os.path.isfile(name):
    print("Downloading server.")
    os.system(f'wget -nv -O {name} {config["server"]}')

for p in os.listdir():
    if p.startswith("server") and p.endswith(".jar"):
        if p != name:
            os.remove(p)


def download(i, folder):
    append = config.get("base", "")
    if i.startswith("#"):
        return
    url = append + i
    h = sha256(url.encode()).hexdigest()[:8]
    name = f"{h}.jar"
    print(url, name)
    if not os.path.isfile(name):
        Popen('wget', '-nv', '-O', f'{folder}/{i}', url)


def download_plugins(i):
    return download(i, "plugins")


def download_mods(i):
    return download(i, "mods")


print("Downloading plugins.")
with Pool(10) as p:
    p.map(download_plugins, config["plugins"])


if config.get("mods"):
    print("Downloading mods.")
    with Pool(10) as p:
        p.map(download_mods, config["mods"])


if config.get("commands"):
    for command in config["commands"]:
        print(f"Executing '{command}'")
        os.system(command)


print("Done.")
