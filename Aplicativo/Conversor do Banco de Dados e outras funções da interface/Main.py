import pandas as pd # importa a biblioteca Pandas
import json # importa a biblioteca json
import codecs


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
arqu = codecs.open('data.dat', 'w', 'utf-8')

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
     #Converter os dados para string utf-8
    # txt = data["produto"] + "\n"
    # txt += data["substancia"] + "\n"
    # txt += data["laboratorio"] + "\n"
    # txt += data["apresentacao"] + "\n"
    # txt += data["classe"] + "\n"
    # txt += data["tipo"] + "\n"
    # txt += data["tarja"] + "\n"
    # txt += data["estimativa"] + "\n"
    # txt += data["liberado2022"] + "\n"
    # txt += "\n"
    #arqu.write(txt)
    txt = ""
    txt += "produto!" +  data["produto"] + "@"
    txt += "substancia!" + data["substancia"] + "@"
    txt += "laboratorio!" + data["laboratorio"] + "@"
    txt += "apresentacao!" + data["apresentacao"] + "@"
    txt += "classe!" + data["classe"] + "@"
    txt += "tipo!" + data["tipo"] + "@"
    txt += "tarja!" + data["tarja"] + "@"
    txt += "estimativa!" + data["estimativa"] + "@"
    txt += "liberado2022!" + data["liberado2022"] + "@"
    arqu.write(txt+"\n")
    

#print(df["PRODUTO"]) # imprime o DataFram
#converter dados para string

arquivo = open("dados.json", "w") # abre um arquivo chamado dados.json em modo de escrita
json.dump(dados, arquivo) # escreve o dicionário como uma string JSON no arquivo
arquivo.close() # fecha o arquivo
arqu.close()



