-- inserir as consultas/recursos SQL e/ou PL/SQL aqui

-- a) consulta herárquica para obter o número de veículos por status, ano e cidade. Use a cláusula ROLLUP para obter os múltiplos grupos.
SELECT category as status, year as ano, location as cidade, count(car_id) as qtd
FROM public.cars
group by ROLLUP(category, year, location)
order by 1, 2, 3
;

-- b) consulta para obter a quantidade de acessórios e a quantidade de acessórios únicos de cada carro. Acessórios únicos são aqueles que somente um único carro possui
SELECT c.name as carro, 

	(select count(a.acessorie_id) from public.acessories a 
	 where c.car_id = a.car_id
	 ) as acessorios,
	 
	(select count(a.acessorie_id) from public.acessories a 
	 where c.car_id = a.car_id 
	   and a.acessory_title not in 
		 (select distinct a1.acessory_title from public.acessories a1
		 where a.car_id <> a1.car_id)
	) as acessorios_unicos

FROM public.cars c
order by c.name
;
-- inserir as consultas/recursos SQL e/ou PL/SQL aqui