# Importar o módulo pandas
import pandas as pd

# Ler o arquivo do excel
arquivo = pd.read_excel("Tabela CMED 18.10.xls")

# Selecionar a coluna apresentação
coluna = arquivo["APRESENTAÇÃO"]

# Criar uma lista vazia para armazenar as substrings
lista = []

# Percorrer cada linha da coluna
for linha in coluna:
  # Verificar se a linha é uma string
  if isinstance(linha, str):
    # Dividir a linha em palavras
    palavras = linha.split()
    # Percorrer cada palavra
    for palavra in palavras:
      # Remover os parênteses da palavra, se houver
      palavra = palavra.replace("(", "").replace(")", "")
      # Verificar se a palavra contém apenas letras maiúsculas
      if palavra.isupper():
        # Verificar se a palavra contém algum número
        if not any(char.isdigit() for char in palavra):
          # Verificar se a palavra já está na lista
          if palavra not in lista:
            # Adicionar a palavra na lista
            lista.append(palavra)

# Exibir a lista
print(lista)