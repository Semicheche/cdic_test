#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
from bs4 import BeautifulSoup
import pandas as pd
car = {}
cars = []

def conecta_com_site(url):
    result = requests.get(url)
    return BeautifulSoup(result.text, 'html.parser')


def scraping_pagina(res):
    cards = res.find_all('div', class_='well card')

    for card in cards:
        car = {
            'img': card.find('div', class_='image-card').img['src'],
            'nome': card.find('p', class_='txt-name').get_text(),
            'categoria': card.find('p', class_='txt-category').get_text(),
            'motor': card.find('p', class_='txt-motor').get_text(),
            'descricao': card.find('p', class_='txt-description').get_text(),
            'items': ''.join([i.get_text() for i in card.findAll('li', class_='txt-items') if i.get_text() != '...']),
            'local': card.find('p', class_='txt-location').get_text(),
            'valor': card.find('div', class_='value').find('p').get_text()
        }
        cars.append(car)
print('=========================')
print(f'Acessando home')
res = conecta_com_site("https://alura-site-scraping.herokuapp.com/index.php")
total_pagina = res.find('span', class_='info-pages').get_text().split(' ')[-1]
print(f'Site com {total_pagina} paginas...\n')
print('Scraping pagina principal...\n')
scraping_pagina(res)

for pag in range(2, int(total_pagina)+1):
    print('-----------------------')
    print(f'Acessando pagina {pag}')
    url_padrao = "https://alura-site-scraping.herokuapp.com/index.php"+f'?page={pag}'
    res = conecta_com_site(url_padrao)
    print(f'Fazendo Scrapping...')
    scraping_pagina(res)

print('Criando DataFrame...')
cars_df = pd.DataFrame(cars)
print('Salvando cars.csv')
cars_df.to_csv(r'cars.csv', index=False)