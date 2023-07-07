# Databricks notebook source
# %%
#pip install sqlfluff

# %%
from typing import Any, Dict, Iterator, List, Union
import sqlfluff
import os


# %%
nove_arquivo_source = 'input.sql'
nove_arquivo_destino = 'Output.sql'

# %%
arq = open(nove_arquivo_source)

# %%
linhas = arq.readlines()


# %%
arq.close()

# %%
my_bad_query = (' '.join(linhas))

# %%
lint_result = sqlfluff.lint(my_bad_query, config_path  = 'setup.cfg', exclude_rules=['L014','L010','L030','L034','L016'])

# %%
fix_result_1 = sqlfluff.fix(my_bad_query, config_path  = 'setup.cfg', exclude_rules=['L014','L010','L030','L034','L016'])

# %%
fix_result_1

# %%
fix_result_2 = sqlfluff.fix(fix_result_1, config_path  = 'setup.cfg', exclude_rules=['L014','L010','L030','L034','L016'])

# %%
with open(nove_arquivo_destino, 'w') as f:
    f.write(fix_result_2)

# %%
f.close()

# %%
os.system('notepad '+nove_arquivo_destino)



