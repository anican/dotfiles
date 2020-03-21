import argparse
r"""
----------------------------------
Example:
$ pwd
  /Users/anican/Documents/example
$ ls
  README.md
$ boiler list
  cse446.tex
  cse447.tex
  cse490g1.tex
  dl-model.py
  dl-train.py
$ boiler add cse448.tex example.tex
  boiler: Specified template does not exist!
$ boiler add cse446.tex && ls
  README.md cse446.tex
$ rm cse446.tex
$ boiler add cse447.tex example.tex
$ ls
  README.md  example.tex

----------------------------------
Templates:
    - tex: hw templates book, etc.
    - python: dl model template
    -
"""
if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ani\'s Template Loader')
