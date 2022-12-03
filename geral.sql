-- Total: 249 registros
SELECT car_id, name, motor, year, km_driven, value, url_photo, location, category
	FROM public.cars
-- where name='BMW M5'
order by 2,1

-- 999 registros
select * from acessories order by 2,1

-- Carros que aparecem mais de uma vez: 10 casos
SELECT name, url_photo, count(*)
from cars
group by name, url_photo
having count(*)>1
order by 1

-- Acessórios que aparecem mais de uma vez no mesmo carro: 0 casos
select cars.car_id, name, acessory_title, count(*)
from acessories
inner join cars
on cars.car_id = acessories.car_id
group by cars.car_id, name, acessory_title
--having count(*)>1
order by 2,1

-- acessório em apenas um carro: count=1
select acessory_title, count(*)
from acessories
group by acessory_title
order by 2

select cars.*, acessories.*
from acessories
inner join cars
on cars.car_id = acessories.car_id
where acessory_title='Sensordechuva'

-- Exclusão, a fim de manter carros únicos: 
-- carros únicos: 20
DROP TABLE Temp

CREATE TEMP table Temp
as
SELECT *, 0 as Seq
FROM Cars
where 1=2

INSERT INTO Temp
(SELECT *,
	rank() over(partition by c.name, c.url_photo order by c.car_id) as seq
FROM cars c
WHERE EXISTS
	(SELECT c1.name, url_photo, count(c1.car_id)
	FROM cars c1
	 WHERE c1.name = c.name
	   and c1.url_photo = c.url_photo
	 GROUP BY c1.name, url_photo
	 having count(*) > 1
	)
ORDER BY c.name, c.car_id
)

select * 
from Temp
order by name, seq

DELETE 
-- select *
FROM acessories a
WHERE a.car_id IN (SELECT t.car_id from Temp t WHERE t.seq <> 1)

DELETE 
-- select *
FROM cars c
WHERE c.car_id IN (SELECT t.car_id from Temp t WHERE t.seq <> 1)
