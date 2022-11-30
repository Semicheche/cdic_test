#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
from bs4 import BeautifulSoup
import pandas as pd

url_padrao = "https://alura-site-scraping.herokuapp.com/index.php"

acessorios = []
cars = []
car = {}
acessorio = {}

def conecta_com_site(url):
    result = requests.get(url)
    return BeautifulSoup(result.text, 'html.parser')


def scraping_pagina(res, idx, acc_id):
    cards = res.find_all('div', class_='well card')

    for card in cards:
        car = {
            'id': idx,
            'nome': card.find('p', class_='txt-name').get_text(),
            'motor': card.find('p', class_='txt-motor').get_text(),
            'year': card.find('p', class_='txt-description').get_text().split('-')[0],
            'km': card.find('p', class_='txt-description').get_text().split('-')[-1],
            'valor': card.find('div', class_='value').find('p').get_text(),
            'localizacao': card.find('p', class_='txt-location').get_text(),
            'categoria': card.find('p', class_='txt-category').get_text(),
            'url': card.find('div', class_='image-card').img['src'],
        }
        for li in card.findAll('li', class_='txt-items'):
            desc  = li.get_text() if li.get_text() != '...' else None
            if desc:
                print()
                acessorio = {
                    'id': acc_id,
                    'car_id': idx,
                    'descricao': ''.join(desc.split(' ')[1:])
                }
                acessorios.append(acessorio)
                acc_id = acc_id+1
        cars.append(car)
        idx = idx+1

def main():
    print('=========================')
    print(f'Acessando home')
    global url_padrao
    res = conecta_com_site(url_padrao)
    #Extrai o Valor do total de paginas
    total_pagina = res.find('span', class_='info-pages').get_text().split(' ')[-1]
    print(f'Site com {total_pagina} paginas...\n')
    print('Scraping pagina principal...\n')
    scraping_pagina(res, 1, 1)

    for pag in range(2, int(total_pagina)+1):
        print('-----------------------')
        print(f'Acessando pagina {pag}')
        url_padrao = url_padrao+f'?page={pag}'
        res = conecta_com_site(url_padrao)
        print(f'Fazendo Scrapping...')
        scraping_pagina(res, len(cars), len(acessorios))

    print('Criando DataFrame Carros...')
    cars_df = pd.DataFrame(cars)
    print('Criando DataFrame Acessorios...')
    acessorios_df = pd.DataFrame(acessorios)
    print('Salvando carros.csv')
    cars_df.to_csv(r'carros.csv', index=False)
    print('Salvando acessorios.csv')
    acessorios_df.to_csv(r'acessorios.csv', index=False)

main()