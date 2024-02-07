import pandas as pd # importa a biblioteca Pandas
import json # importa a biblioteca json
df = pd.read_excel("Tabela CMED 18.10.xls") # lê o arquivo Excel e cria um DataFrame
linhaInicial = 1
linhaFinal = 28919
#criar tabelas
produtos = df["PRODUTO"][linhaInicial:linhaFinal+1]
substancias = df["SUBSTÂNCIA"][linhaInicial:linhaFinal+1]
laboratorio = df["LABORATÓRIO"][linhaInicial:linhaFinal+1]
apresentacao = df["APRESENTAÇÃO"][linhaInicial:linhaFinal+1]
classes = df["CLASSE TERAPÊUTICA"][linhaInicial:linhaFinal+1]
tipo = df["TIPO DE PRODUTO (STATUS DO PRODUTO)"][linhaInicial:linhaFinal+1]
tarja = df["TARJA"][linhaInicial:linhaFinal+1]

#Variavel para armazenar os produtos 
dados = {}
arqu = open("data.dat", "w")

for i in range(linhaInicial, linhaFinal+1):
    por = round((i/linhaFinal)*100)
    print("Progresso: ", i, " de ", linhaFinal, " - ",por," %")
    #print(df["PRODUTO"][i])
    #verificar a primeira letra do nome
    nome = df["PRODUTO"][i]
    primeiraLetra = nome[0]
    #verificar se existe uma pasta com esse nome
    #if primeiraLetra not in dados:
    #    dados[primeiraLetra] = {}
    if nome not in dados:
        dados[nome] = []
    data = {}
    data["produto"] = df["PRODUTO"][i]
    data["substancia"] = df["SUBSTÂNCIA"][i]
    data["laboratorio"] = df["LABORATÓRIO"][i]
    data["apresentacao"] = df["APRESENTAÇÃO"][i]
    data["classe"] = df["CLASSE TERAPÊUTICA"][i]
    data["tipo"] = df["TIPO DE PRODUTO (STATUS DO PRODUTO)"][i]
    data["tarja"] = df["TARJA"][i]
    data["estimativa"] = str(df["PMC 12%"][i])
    data["liberado2022"] = df["COMERCIALIZAÇÃO 2022"][i]
    dados[nome].append(data)
    arqu.write(data["produto"] + "\n")
    arqu.write(data["substancia"] + "\n")
    arqu.write(data["laboratorio"] + "\n")
    arqu.write(data["apresentacao"] + "\n")
    arqu.write(data["classe"] + "\n")
    arqu.write(data["tipo"] + "\n")
    arqu.write(data["tarja"] + "\n")
    arqu.write(data["estimativa"] + "\n")
    arqu.write(data["liberado2022"] + "\n")
    arqu.write("\n")

#print(df["PRODUTO"]) # imprime o DataFram
#converter dados para string

arquivo = open("dados.json", "w") # abre um arquivo chamado dados.json em modo de escrita
json.dump(dados, arquivo) # escreve o dicionário como uma string JSON no arquivo
arquivo.close() # fecha o arquivo
arqu.close()



