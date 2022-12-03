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

