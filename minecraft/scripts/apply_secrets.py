import os
import re
from json import load

if os.path.isfile("secrets.json"):
    with open("secrets.json", "r") as file:
        secrets = load(file)
else:
    secrets = {}

pattern_filename = re.compile(r"(.*)(yml|yaml|conf|txt|json|properties)")
pattern_replace = r"{ ?text ?}"


def process_file(path):
    try:
        r = pattern_filename.findall(path)
        if not r:
            return
        with open(path, "r") as f:
            text = f.read()
        for secret_name in os.environ:
            text = re.sub(
                pattern_replace.replace("text", secret_name),
                os.environ[secret_name],
                text,
                flags=re.I,
            )
        for secret_name in secrets:
            text = re.sub(
                pattern_replace.replace("text", secret_name),
                secrets[secret_name],
                text,
                flags=re.I,
            )
        with open(path, "w") as f:
            f.write(text)
    except Exception as e:
        print(e)


def process_folder(path=""):
    if path:
        os.chdir(path)
    for i in os.listdir():
        if i == "secrets.json":
            continue
        if os.path.isdir(i):
            process_folder(i)
        elif os.path.isfile(i):
            process_file(i)
    os.chdir("..")


if __name__ == "__main__":
    print("Environ: " + ", ".join(os.environ))
    print("Secrets: " + ", ".join(list(secrets.keys())))
    process_folder()
    print("Done.")
