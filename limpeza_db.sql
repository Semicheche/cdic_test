-- Exclusão, a fim de manter carros únicos: 
-- carros únicos: 20
DROP TABLE Temp;

CREATE TEMP table Temp
as
SELECT *, 0 as Seq
FROM Cars
where 1=2;

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
);

select * 
from Temp
order by name, seq;

DELETE 
-- select *
FROM acessories a
WHERE a.car_id IN (SELECT t.car_id from Temp t WHERE t.seq <> 1);

DELETE 
-- select *
FROM cars c
WHERE c.car_id IN (SELECT t.car_id from Temp t WHERE t.seq <> 1);
